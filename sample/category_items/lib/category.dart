import 'package:flutter/cupertino.dart';

class Category {
  final String id;
  final IconData iconData;
  final Color iconColor;
  final String label;

  Category({
    required this.id,
    required this.iconData,
    required this.iconColor,
    required this.label,
  });
}

class SubCategory {
  final String parentId;
  final String id;
  final String label;
  final IconData? iconData;
  bool _selected = true;

  SubCategory({
    required this.parentId,
    required this.id,
    required this.label,
    required this.iconData,
  });

  void toggleSelected() {
    _selected = !_selected;
  }

  bool get selected => _selected;
}
