import 'package:category_items/category.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scrollable SegmentedButton Example'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Set<Category> selected = {};

  //샘플값
  List<Category> categories = [
    Category(id: 'cat1', iconData: Icons.circle, iconColor: Colors.red, label: '카테고리1'),
    Category(id: 'cat2', iconData: Icons.circle, iconColor: Colors.orange, label: '카테고리2'),
    Category(id: 'cat3', iconData: Icons.circle, iconColor: Colors.yellow, label: '카테고리3'),
    Category(id: 'cat4', iconData: Icons.circle, iconColor: Colors.green, label: '카테고리4'),
    Category(id: 'cat5', iconData: Icons.circle, iconColor: Colors.blue, label: '카테고리5'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton(
        style: SegmentedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(),
        ),
        segments: categories
            .map(
              (category) => ButtonSegment(
                value: category,
                label: Text(category.label),
                icon: Icon(category.iconData, color: category.iconColor),
              ),
            )
            .toList(),
        selected: selected,
        onSelectionChanged: (newSelection) {
          setState(() {
            selected = newSelection;
          });
        },
        multiSelectionEnabled: true,
        emptySelectionAllowed: true,
      ),
    );
  }
}
