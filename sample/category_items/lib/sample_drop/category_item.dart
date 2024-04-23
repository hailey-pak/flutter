import 'package:flutter/material.dart';

class CategoryItem {
  final String id;
  final String label;
  final IconData icon;
  Color? iconColor;
  bool visible = true;
  List<CategoryItem> subCategories = [];

  CategoryItem({
    required this.id,
    required this.label,
    required this.icon,
    Color? iconColor,
    List<CategoryItem>? subCategories,
  }) {
    iconColor != null ? this.iconColor = iconColor : null;
    subCategories != null ? this.subCategories = subCategories : [];
  }


}