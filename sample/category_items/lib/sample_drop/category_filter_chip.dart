import 'package:category_items/sample_drop/category_item.dart';
import 'package:flutter/material.dart';

class CategoryFilterChip extends StatefulWidget {
  const CategoryFilterChip({
    super.key,
    required this.categoryItem,
  });

  final CategoryItem categoryItem;

  @override
  State<CategoryFilterChip> createState() => _CategoryFilterChipState();
}

class _CategoryFilterChipState extends State<CategoryFilterChip> {
  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(
        widget.categoryItem.label,
      ),
      onPressed: (){
        //
      },
    );
  }
}
