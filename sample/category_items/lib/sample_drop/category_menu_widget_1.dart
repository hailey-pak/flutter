import 'package:category_items/sample_drop/category_item.dart';
import 'package:flutter/material.dart';

class CategoryMenuWidget extends StatefulWidget {
  const CategoryMenuWidget({
    super.key,
    required this.categoryItems,
  });

  final List<CategoryItem> categoryItems;

  @override
  State<CategoryMenuWidget> createState() => _CategoryMenuWidgetState();
}

class _CategoryMenuWidgetState extends State<CategoryMenuWidget> {
  late List<DropdownMenuItem<CategoryItem>> menus;
  late CategoryItem selected;

  @override
  void initState() {
    super.initState();

    menus = widget.categoryItems.map((CategoryItem item) {
      return DropdownMenuItem(
        value: item,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: item.iconColor),
            const SizedBox(width: 8.0),
            Text(item.label),
          ],
        ),
      );
    }).toList();

    selected = menus.first.value!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              items: menus,
              onChanged: (CategoryItem? value) {
                setState(() {
                  selected = value!;
                });
              },
              value: selected,
              iconSize: 0.0,
            ),
          ),
          const SizedBox(width: 8.0),
          Expanded(child: _subMenuChip()),
        ],
      ),
    );
  }

  Widget _subMenuChip() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selected.subCategories.map((sub) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ActionChip(
              avatar: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(
                  sub.visible ? sub.icon : Icons.adjust,
                  color: selected.iconColor,
                  size: 16,
                ),
              ),
              label: Text(sub.label),
              onPressed: () {
               setState(() {
                 sub.visible = !sub.visible;
               });
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
