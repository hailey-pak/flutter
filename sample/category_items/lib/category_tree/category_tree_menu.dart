import 'package:category_items/category_tree/category_item.dart';
import 'package:flutter/material.dart';

class CategoryTreeMenuController {
  final ValueNotifier<List<String>> visibleListNotifier;
  final ValueNotifier<List<CategoryItem>> itemsNotifier;

  CategoryTreeMenuController(List<CategoryItem> items)
      : itemsNotifier = ValueNotifier<List<CategoryItem>>(items),
        visibleListNotifier = ValueNotifier<List<String>>([]) {
    visibleListNotifier.value = _getVisibleList();
  }

  List<CategoryItem> get items => itemsNotifier.value;
  List<String> get visibleList => visibleListNotifier.value;

  List<String> _getVisibleList() {
    List<String> list = [];

    for (CategoryItem item in itemsNotifier.value) {
      if (item.subCategories != null && item.subCategories.isNotEmpty) {
        for (CategoryItem sub in item.subCategories) {
          if (sub.visible) list.add(sub.label);
        }
      } else {
        if (item.visible) list.add(item.label);
      }
    }
    return list;
  }

  void toggleVisible(CategoryItem sub) {
    itemsNotifier.value = itemsNotifier.value = itemsNotifier.value.map((item) {
      for (CategoryItem subItem in item.subCategories) {
        if (subItem == sub) {
          subItem.visible = !subItem.visible;
        }
      }
      return item;
    }).toList();
    visibleListNotifier.value = _getVisibleList();
  }

  void dispose() {
    itemsNotifier.dispose();
    visibleListNotifier.dispose();
  }
}

class CategoryTreeMenu extends StatefulWidget {
  const CategoryTreeMenu({
    super.key,
    required this.categoryItems,
    this.controller,
  });

  final List<CategoryItem> categoryItems;
  final CategoryTreeMenuController? controller;

  @override
  State<CategoryTreeMenu> createState() => _CategoryTreeMenuState();
}

class _CategoryTreeMenuState extends State<CategoryTreeMenu> {
  late Map<CategoryItem, bool> _data;
  late CategoryTreeMenuController _controller;

  @override
  void initState() {
    super.initState();

    _data = {};
    for (CategoryItem item in widget.categoryItems) {
      _data.putIfAbsent(item, () => false);
    }

    // 위젯 컨트롤러가 null이면 새로 생성
    _controller = widget.controller ?? CategoryTreeMenuController(widget.categoryItems);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[widget.categoryItems[index]] = isExpanded;
        });
      },
      expandedHeaderPadding: EdgeInsets.zero,
      materialGapSize: 0,
      children: _data.entries.map((item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (context, isExpanded) {
            return ListTile(
              leading: Icon(item.key.icon, color: item.key.iconColor),
              title: Text(item.key.label),
            );
          },
          body: SingleChildScrollView(
            child: Column(
              children: item.key.subCategories.map((sub) {
                return ListTile(
                  leading: Icon(sub.icon, color: item.key.iconColor),
                  title: Text(sub.label),
                  trailing: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        _controller.toggleVisible(sub);
                      });
                    },
                    value: sub.visible,
                    activeColor: item.key.iconColor,
                  ),
                  contentPadding: const EdgeInsets.only(left: 48.0, right: 8.0),
                  onTap: () {
                    setState(() {
                      _controller.toggleVisible(sub);
                    });
                  },
                );
              }).toList(),
            ),
          ),
          isExpanded: _data[item.key]!,
        );
      }).toList(),
    );
  }
}
