import 'package:category_items/sample_drop/category_item.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

List<CategoryItem> list = [
  CategoryItem(
    id: 'PC0100',
    icon: Icons.circle,
    iconColor: Colors.red,
    label: '도로 및 광장',
    subCategories: [
      CategoryItem(id: 'PC0101', icon: Icons.directions_walk, label: '산책로/보행로'),
      CategoryItem(id: 'PC0102', icon: Icons.crop_square_sharp, label: '광장'),
      CategoryItem(id: 'PC0103', icon: Icons.add, label: '교량'),
    ],
  ),
  CategoryItem(
    id: 'PC0200',
    icon: Icons.circle,
    iconColor: Colors.orange,
    label: '조경시설',
    subCategories: [
      CategoryItem(id: 'PC0201', icon: Icons.shopping_cart, label: '조각/조형물'),
      CategoryItem(id: 'PC0202', icon: Icons.account_tree, label: '문주/열주'),
      CategoryItem(id: 'PC0203', icon: Icons.water_rounded, label: '식수대/플랜터'),
    ],
  ),
  CategoryItem(
    id: 'PC0300',
    icon: Icons.circle,
    iconColor: Colors.green,
    label: '휴양시설',
    subCategories: [
      CategoryItem(id: 'PC0301', icon: Icons.chair, label: '의자'),
      CategoryItem(id: 'PC0302', icon: Icons.chair_alt, label: '정자'),
      CategoryItem(id: 'PC0303', icon: Icons.table_bar, label: '파고라'),
      CategoryItem(id: 'PC0304', icon: Icons.deck, label: '데크'),
      CategoryItem(id: 'PC0305', icon: Icons.table_restaurant_outlined, label: '야외탁자'),
      CategoryItem(id: 'PC0306', icon: Icons.account_balance, label: '기타휴양시설'),
    ],
  ),
  CategoryItem(
    id: 'PC0400',
    icon: Icons.circle,
    iconColor: Colors.blue,
    label: '유희시설',
  ),
  CategoryItem(
    id: 'PC0500',
    icon: Icons.circle,
    iconColor: Colors.purple,
    label: '운동시설',
  ),
  CategoryItem(
    id: 'PC0600',
    icon: Icons.circle,
    iconColor: Colors.pink,
    label: '교양시설',
  ),
  CategoryItem(
    id: 'PC0700',
    icon: Icons.circle,
    iconColor: Colors.amber,
    label: '편익시설',
  ),
  CategoryItem(
    id: 'PC0900',
    icon: Icons.circle,
    iconColor: Colors.brown,
    label: '공원관리시설',
  ),
];

void main() => runApp(const DropdownMenuApp());

class DropdownMenuApp extends StatelessWidget {
  const DropdownMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('DropdownMenu Sample')),
        body: const Row(
          children: [
            DropdownMenuExample(),
            SizedBox(width: 10),
            DropdownMenuExample2(),
          ],
        ),
      ),
    );
  }
}

class DropdownMenuExample extends StatefulWidget {
  const DropdownMenuExample({super.key});

  @override
  State<DropdownMenuExample> createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  CategoryItem dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<CategoryItem>(
        items: list.map((CategoryItem item) {
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
        }).toList(),
        onChanged: (CategoryItem? value) {
          setState(() {
            dropdownValue = value!;
          });
        },
        value: dropdownValue,
        iconSize: 0.0,
      ),
    );
  }
}

class DropdownMenuExample2 extends StatefulWidget {
  const DropdownMenuExample2({super.key});

  @override
  State<DropdownMenuExample2> createState() => _DropdownMenuExample2State();
}

class _DropdownMenuExample2State extends State<DropdownMenuExample2> {
  CategoryItem dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<CategoryItem>(
      initialSelection: dropdownValue,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        suffixIconColor: Colors.transparent,
        filled: true,
      ),
      trailingIcon: null,
      menuStyle: const MenuStyle(
        backgroundColor: MaterialStatePropertyAll<Color>(Colors.transparent),
        elevation: MaterialStatePropertyAll<double>(0),
        shape: MaterialStatePropertyAll<ContinuousRectangleBorder>(ContinuousRectangleBorder()),
      ),
      dropdownMenuEntries: list.map((CategoryItem item) {
        return DropdownMenuEntry(
          value: item,
          label: item.label,
          labelWidget: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(item.icon, color: item.iconColor),
            const SizedBox(width: 8.0),
            Text(item.label),
          ]),
        );
      }).toList(),
      onSelected: (CategoryItem? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
    );
  }
}
