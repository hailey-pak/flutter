import 'package:flutter/material.dart';

class Menu {
  final String id;
  final IconData icon;
  final Color iconColor;
  final String label;
  List<Menu> subMenu = [];

  Menu({
    required this.id,
    required this.icon,
    required this.iconColor,
    required this.label,
    List<Menu>? subMenu,
  }) {
    subMenu != null ? this.subMenu = subMenu : this.subMenu = [];
  }

}

//샘플값
List dataList = [
  Menu(
    id: 'PC0100',
    icon: Icons.circle,
    iconColor: Colors.red,
    label: '도로 및 광장',
    subMenu: [
      Menu(id: 'PC0101', icon: Icons.directions_walk, iconColor: Colors.red, label: '산책로/보행로'),
      Menu(id: 'PC0102', icon: Icons.crop_square_sharp, iconColor: Colors.red, label: '광장'),
      Menu(id: 'PC0103', icon: Icons.add, iconColor: Colors.red, label: '교량'),
    ],
  ),
  Menu(
    id: 'PC0200',
    icon: Icons.circle,
    iconColor: Colors.orange,
    label: '조경시설',
    subMenu: [
      Menu(id: 'PC0201', icon: Icons.shopping_cart, iconColor: Colors.orange, label: '조각/조형물'),
      Menu(id: 'PC0202', icon: Icons.account_tree, iconColor: Colors.orange, label: '문주/열주'),
      Menu(id: 'PC0203', icon: Icons.water_rounded, iconColor: Colors.orange, label: '식수대/플랜터'),
    ],
  ),
  Menu(
    id: 'PC0300',
    icon: Icons.circle,
    iconColor: Colors.green,
    label: '휴양시설',
    subMenu: [
      Menu(id: 'PC0301', icon: Icons.chair, iconColor: Colors.green, label: '의자'),
      Menu(id: 'PC0302', icon: Icons.chair_alt, iconColor: Colors.green, label: '정자'),
      Menu(id: 'PC0303', icon: Icons.table_bar, iconColor: Colors.green, label: '파고라'),
      Menu(id: 'PC0304', icon: Icons.deck, iconColor: Colors.green, label: '데크'),
      Menu(id: 'PC0305', icon: Icons.table_restaurant_outlined, iconColor: Colors.green, label: '야외탁자'),
      Menu(id: 'PC0306', icon: Icons.account_balance, iconColor: Colors.green, label: '기타휴양시설'),
    ],
  ),
  Menu(id: 'PC0400', icon: Icons.circle, iconColor: Colors.blue, label: '유희시설'),
  Menu(id: 'PC0500', icon: Icons.circle, iconColor: Colors.purple, label: '운동시설'),
  Menu(id: 'PC0600', icon: Icons.circle, iconColor: Colors.pink, label: '교양시설'),
  Menu(id: 'PC0700', icon: Icons.circle, iconColor: Colors.amber, label: '편익시설'),
];
