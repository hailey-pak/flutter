import 'package:category_items/category_drop/category_drop_menu.dart';
import 'package:category_items/category_drop/category_item.dart';
import 'package:category_items/category_drop/sub_category_chips.dart';
import 'package:flutter/material.dart';


class CategoryDropAndSubChips extends StatefulWidget {
  const CategoryDropAndSubChips({
    super.key,
    required this.categoryItems,
    this.controller,
  });

  final List<CategoryItem> categoryItems;
  final CategoryDropMenuController? controller;

  @override
  State<CategoryDropAndSubChips> createState() => _CategoryDropAndSubChipsState();
}

class _CategoryDropAndSubChipsState extends State<CategoryDropAndSubChips> {
  late CategoryDropMenuController _controller;
  late SubCategoryChipsController _subController;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? CategoryDropMenuController(widget.categoryItems);
    _subController = SubCategoryChipsController(_controller.selected);

    _controller.selectedNotifier.addListener(_selectedValueChanged);
    _controller.itemsNotifier.addListener(_visibleChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _subController.dispose();
    super.dispose();
  }

  void _visibleChanged() {
    //현재 선택되어있는 카테고리의 visible이 변경되면 subController의 아이템도 변경
    if (_controller.changed != null && _controller.changed!.id == _subController.itemNotifier.value.id) {
      setState(() {
        _subController.item = _controller.changed!;
      });
    }
  }

  void _selectedValueChanged() {
    setState(() {
      _subController.item = _controller.selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CategoryDropMenu(
          categoryItems: widget.categoryItems,
          controller: _controller,
        ),
        const SizedBox(width: 16.0),
        Expanded(
          child: SubCategoryChips(
            category: _controller.selected,
            controller: _subController,
          ),
        ),
      ],
    );
  }
}
