import 'package:category_items/sample_drop/category_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryMenuWidget2 extends StatefulWidget {
  const CategoryMenuWidget2({
    super.key,
    required this.categoryItems,
  });

  final List<CategoryItem> categoryItems;

  @override
  State<CategoryMenuWidget2> createState() => _CategoryMenuWidget2State();
}

class _CategoryMenuWidget2State extends State<CategoryMenuWidget2> {
  late List<DropdownMenuItem<CategoryItem>> menus;
  late CategoryItem selected;
  final ScrollController _scrollController = ScrollController();

  late double textLength;

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

    selected = widget.categoryItems.first;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('----------------build----------------');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _dropMenu(),
          const SizedBox(width: 16.0),
          Expanded(child: _subCategoryChips(selected)),
        ],
      ),
    );
  }

  Widget _dropMenu() {
    print('dropMenu');
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(selected.icon, color: selected.iconColor),
        items: widget.categoryItems.map((CategoryItem item) {
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
                  child: _subCategoryChips(item),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) async {
          await _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          setState(() {
            selected = value!;
          });
        },
        dropdownStyleData: DropdownStyleData(
          width: double.maxFinite,
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          offset: const Offset(0, -8),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
        ),
      ),
    );
  }

  Widget _subCategoryChips(CategoryItem item) {
    print('_subCategoryChips');
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: item.subCategories.map((sub) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RawChip(
              padding: EdgeInsets.zero,
              avatar: Icon(
                sub.icon,
                color: sub.visible ? item.iconColor : Colors.grey,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  sub.visible = !sub.visible;
                });
              },
              label: Container(),
              labelPadding: EdgeInsets.zero,
              // backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                // borderRadius: BorderRadius.circular(16.0),
                side: const BorderSide(color: Colors.transparent),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
