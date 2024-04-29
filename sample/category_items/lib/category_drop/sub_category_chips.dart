import 'package:category_items/category_drop/category_drop_menu.dart';
import 'package:category_items/category_drop/category_item.dart';
import 'package:flutter/material.dart';

class SubCategoryChipsController {
  final ValueNotifier<CategoryItem> itemNotifier;

  SubCategoryChipsController(CategoryItem item) : itemNotifier = ValueNotifier<CategoryItem>(item);

  CategoryItem get item => itemNotifier.value;

  set item(CategoryItem item) {
    itemNotifier.value = item;
  }

  void toggleVisible(CategoryItem sub) {
    List<CategoryItem> newSubs = itemNotifier.value.subCategories.map((e) {
      if (e == sub) {
        e.visible = !e.visible;
      }
      return e;
    }).toList();

    itemNotifier.value = CategoryItem(
      id: item.id,
      label: item.label,
      icon: item.icon,
      iconColor: item.iconColor,
      subCategories: newSubs,
    );
  }
}

class SubCategoryChips extends StatefulWidget {
  const SubCategoryChips({
    super.key,
    required this.category,
    this.controller,
    this.categoryDropMenuController,
  });

  final CategoryItem category;
  final SubCategoryChipsController? controller;
  final CategoryDropMenuController? categoryDropMenuController;

  @override
  State<SubCategoryChips> createState() => _SubCategoryChipsState();
}

class _SubCategoryChipsState extends State<SubCategoryChips> {
  late SubCategoryChipsController _controller;
  late CategoryDropMenuController _categoryDropMenuController;

  @override
  void initState() {
    super.initState();

    // 위젯 컨트롤러가 null이면 새로 생성
    _controller = widget.controller ?? SubCategoryChipsController(widget.category);

    _categoryDropMenuController = widget.categoryDropMenuController ?? CategoryDropMenuController([widget.category]);

    _controller.itemNotifier.addListener(_visibleChanged);
  }

  void _visibleChanged() {
    _categoryDropMenuController.visibleChanged(_controller.item);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: _controller.item.subCategories.map((sub) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RawChip(
              padding: EdgeInsets.zero,
              avatar: Icon(
                sub.icon,
                color: sub.visible ? _controller.item.iconColor : Colors.grey,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _controller.toggleVisible(sub);
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
