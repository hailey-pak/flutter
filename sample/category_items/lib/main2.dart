import 'package:category_items/category.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Category Menu Item',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Category Menu Item'),
      color: Colors.white,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //샘플값
  List<Category> categories = [
    Category(id: 'cat1', iconData: Icons.circle, iconColor: Colors.red, label: '카테고리1'),
    Category(id: 'cat2', iconData: Icons.circle, iconColor: Colors.orange, label: '카테고리2'),
    Category(id: 'cat3', iconData: Icons.circle, iconColor: Colors.yellow, label: '카테고리3'),
    Category(id: 'cat4', iconData: Icons.circle, iconColor: Colors.green, label: '카테고리4'),
    Category(id: 'cat5', iconData: Icons.circle, iconColor: Colors.blue, label: '카테고리5'),
  ];

  List<SubCategory> subCategories = [];
  Category? selected;
  List<bool> selections = [];


  @override
  void initState() {
    super.initState();

    if (subCategories.isEmpty) {
      for (int i = 0; i < categories.length; i++) {
        Category category = categories[i];
        subCategories.addAll([
          SubCategory(parentId: category.id, id: '${category.id}-1', label: '아이템${i + 1}-1', iconData: Icons.account_balance),
          SubCategory(parentId: category.id, id: '${category.id}-2', label: '아이템${i + 1}-2', iconData: Icons.account_circle_rounded),
          SubCategory(parentId: category.id, id: '${category.id}-3', label: '아이템${i + 1}-3', iconData: Icons.account_balance_wallet),
          SubCategory(parentId: category.id, id: '${category.id}-4', label: '아이템${i + 1}-4', iconData: Icons.account_tree),
          SubCategory(parentId: category.id, id: '${category.id}-5', label: '아이템${i + 1}-5', iconData: Icons.switch_account_outlined),
        ]);
      }
    }

    if (selections.isEmpty) {
      selections = List.filled(categories.length, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> list = categoryList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return list[index];
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(width: 8.0);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  List<Widget> categoryList() {
    return categories.map((category) {
      return Column(
          children: [
            ActionChip.elevated(
              avatar: Icon(category.iconData, color: category.iconColor),
              label: Text(category.label),
              backgroundColor: Colors.white,
              elevation: 5,
              onPressed: () {
                setState(() {
                  if (selected == category) {
                    selected = null;
                  } else {
                    selected = category;
                  }
                });
              },
            ),
            Visibility(
              visible: selected == category,
              child: SingleChildScrollView(
                child: Column(
                  children: getSubCategory(category.id).map((e) {
                    return ActionChip.elevated(
                      avatar: Icon(e.selected ? e.iconData : Icons.adjust, color: category.iconColor),
                      label: Text(e.label),
                      onPressed: (){
                        setState(() {
                          e.toggleSelected();
                        });
                      },
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.white)),
                      elevation: 5,
                    );
                  }).toList(),
                ),
              ),
            ),
          ]
      );
    }).toList();
  }

  List<SubCategory> getSubCategory(String parentId) {
    return subCategories.where((element) => element.parentId == parentId).toList();
  }

}
