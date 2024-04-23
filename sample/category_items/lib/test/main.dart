import 'package:category_items/test/category.dart';
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
  }

  bool parentVisible = true;
  bool childVisible = false;
  Category? selectedHorizontal;
  List<SubCategory> selectedSub = [];

  Category? selectedVertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          getHorizontalList(),
          const SizedBox(height: 16),
          Expanded(child: getVerticalList()),
        ],
      ),
    );
  }

  Widget getHorizontalList() {
    return Stack(
      children: [
        Visibility(
          visible: parentVisible,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: categoryListHorizontal(),
          ),
        ),
        Visibility(
          visible: childVisible,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: getSelectedSubList(),
          ),
        ),
      ],
    );
  }

  void selectParent() {
    parentVisible = !parentVisible;
    childVisible = !parentVisible;

    if (selectedHorizontal != null) {
      selectedSub = getSubCategory(selectedHorizontal!.id);
    }

  }

  Widget categoryListHorizontal() {
    //대분류
    List<Widget> list = categories.map((category) {
      return ActionChip.elevated(
        avatar: Icon(category.iconData, color: category.iconColor),
        label: Text(category.label),
        backgroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          setState(() {
            selectedHorizontal = category;
            selectParent();
          });
        },
      );
    }).toList();

    return SizedBox(
      height: 100,
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
    );
  }

  List<SubCategory> getSubCategory(String parentId) {
    return subCategories.where((element) => element.parentId == parentId).toList();
  }

  Widget? getSelectedSubList() {
    if (selectedHorizontal != null) {
      Widget parent = ActionChip.elevated(
        avatar: Icon(selectedHorizontal!.iconData, color: selectedHorizontal!.iconColor),
        label: Text(selectedHorizontal!.label),
        backgroundColor: Colors.white,
        elevation: 5,
        onPressed: () {
          setState(() {
            //원상복귀
            selectedHorizontal = null;
            selectParent();
          });
        },
      );

      return SizedBox(
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            parent,
            const SizedBox(width: 8.0),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: selectedSub.map((e) {
                    return ActionChip.elevated(
                      avatar: Icon(e.selected ? e.iconData : Icons.adjust, color: selectedHorizontal!.iconColor),
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
          ],
        ),
      );
    }
  }

  Widget getVerticalList() {
    List<Widget> list = categoryListVertical();

    return Padding(
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
    );
  }

  List<Widget> categoryListVertical() {
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
                  if (selectedVertical == category) {
                    selectedVertical = null;
                  } else {
                    selectedVertical = category;
                  }
                });
              },
            ),
            Visibility(
              visible: selectedVertical == category,
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
}
