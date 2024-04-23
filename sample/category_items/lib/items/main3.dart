import 'package:category_items/items/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Menu> data = [];

  @override
  void initState() {
    super.initState();

    for (var element in dataList) {
      data.add(element);
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category Menu Item',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expandable ListView'),
        ),
        body: Container(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (context, index) => _buildList(data[index]),
              ),
            ],
          ),
        ),
      ),
      color: Colors.white,
    );
  }

  Widget _buildList(Menu list) {
    if (list.subMenu.isEmpty) {
      return ListTile(
        onTap: () {},
        leading: Icon(list.icon, color: list.iconColor),
        title: Text(list.label),
      );
    }
    return ExpansionTile(
      leading: Icon(list.icon, color: list.iconColor),
      title: Text(
        list.label,
      ),
      children: list.subMenu.map(_buildList).toList(),
    );
  }
}
