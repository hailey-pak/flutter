
import 'package:category_items/sample_drop/category_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            const SizedBox(width: 8.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: item.subCategories.map((sub) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Chip(
                        padding: EdgeInsets.zero,
                        avatar: Icon(
                          sub.visible ? sub.icon : Icons.adjust,
                          color: sub.visible ? selected.iconColor : Colors.grey,
                          size: 24,
                        ),
                        label: Text(sub.label),
                        labelPadding: EdgeInsets.zero,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();

    selected = menus.first.value!;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          _dropMenu(),
          const SizedBox(width: 8.0),
          Expanded(child: _subMenuChip()),
        ],
      ),
    );
  }

  Widget _dropMenu() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Icon(selected.icon, color: selected.iconColor),
        items: menus,
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
    return DropdownMenu<CategoryItem>(
      initialSelection: selected,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        suffixIconColor: Colors.transparent,
        filled: true,
        labelStyle: TextStyle(fontSize: 0),
      ),
      trailingIcon: null,
      leadingIcon: Icon(selected.icon, color: selected.iconColor),
      width: 50,
      textStyle: TextStyle(fontSize: 0),
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
        elevation: MaterialStatePropertyAll<double>(0),
        shape: MaterialStatePropertyAll<ContinuousRectangleBorder>(ContinuousRectangleBorder()),
      ),
      dropdownMenuEntries: widget.categoryItems.map((CategoryItem item) {
        return DropdownMenuEntry(
          value: item,
          label: item.label,
          leadingIcon: Icon(item.icon, color: item.iconColor),
        );
      }).toList(),
      onSelected: (CategoryItem? value) {
        setState(() {
          selected = value!;
        });
      },
    );
  }

  Widget _subMenuChip() {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: selected.subCategories.map((sub) {
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: RawChip(
              padding: EdgeInsets.zero,
              avatar: Icon(
                sub.visible ? sub.icon : Icons.adjust,
                color: sub.visible ? selected.iconColor : Colors.grey,
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  sub.visible = !sub.visible;
                });
              },
              label: Container(),
              labelPadding: EdgeInsets.zero,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
                side: BorderSide(color: Colors.white),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
