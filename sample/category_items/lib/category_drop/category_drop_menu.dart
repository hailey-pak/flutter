import 'package:category_items/category_drop/category_item.dart';
import 'package:category_items/category_drop/sub_category_chips.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryDropMenuController {
  final ValueNotifier<CategoryItem> selectedNotifier;
  final ValueNotifier<List<CategoryItem>> itemsNotifier;
  final ValueNotifier<List<String>> visibleListNotifier;

  CategoryDropMenuController(List<CategoryItem> items)
      : itemsNotifier = ValueNotifier<List<CategoryItem>>(items),
        selectedNotifier = ValueNotifier<CategoryItem>(items.first),
        visibleListNotifier = ValueNotifier<List<String>>([]) {
    visibleListNotifier.value = _getVisibleList();
  }

  CategoryItem get selected => selectedNotifier.value;

  set selected(CategoryItem item) {
    selectedNotifier.value = item;
  }

  List<CategoryItem> get items => itemsNotifier.value;

  void visibleChanged(CategoryItem item) {
    changed = item;
    itemsNotifier.value = itemsNotifier.value.map((e) {
      if (e.id == item.id) {
        return item;
      } else {
        return e;
      }
    }).toList();

    visibleListNotifier.value = _getVisibleList();
  }

  CategoryItem? changed;

  List<String> _getVisibleList() {
    List<String> list = [];

    for (CategoryItem item in itemsNotifier.value) {
      if (item.subCategories.isNotEmpty) {
        for (CategoryItem sub in item.subCategories) {
          if (sub.visible) list.add(sub.label);
        }
      } else {
        if (item.visible) list.add(item.label);
      }
    }
    return list;
  }

  List<String> get visibleList => visibleListNotifier.value;

  void dispose() {
    selectedNotifier.dispose();
    itemsNotifier.dispose();
    visibleListNotifier.dispose();
  }
}

class CategoryDropMenu extends StatefulWidget {
  const CategoryDropMenu({
    super.key,
    required this.categoryItems,
    this.controller,
  });

  final List<CategoryItem> categoryItems;
  final CategoryDropMenuController? controller;

  @override
  State<CategoryDropMenu> createState() => _CategoryDropMenuState();
}

class _CategoryDropMenuState extends State<CategoryDropMenu> {
  late double textLength;
  late List<DropdownMenuItem> list;
  late CategoryDropMenuController _controller;

  @override
  void initState() {
    super.initState();

    ScreenUtil().setSp(15);

    int maxLength = 0;
    for (CategoryItem item in widget.categoryItems) {
      if (item.label.length > maxLength) {
        maxLength = item.label.length;
      }
    }
    textLength = 15.sp * maxLength;

    // 위젯 컨트롤러가 null이면 새로 생성
    _controller = widget.controller ?? CategoryDropMenuController(widget.categoryItems);

    list = widget.categoryItems.map((CategoryItem item) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          children: [
            Icon(item.icon, color: item.iconColor),
            const SizedBox(width: 8.0),
            SizedBox(
              width: textLength,
              child: Text(
                item.label,
                style: TextStyle(fontSize: 15.sp),
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: SubCategoryChips(
                category: item,
                categoryDropMenuController: _controller,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(_controller.selected.icon, color: _controller.selected.iconColor),
        ),
        items: list,
        onChanged: (value) {
          setState(() {
            _controller.selected = value!;
          });
        },
        dropdownStyleData: DropdownStyleData(
          width: double.maxFinite,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }
}
