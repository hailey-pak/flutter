
import 'package:category_items/category_tree/category_tree_menu.dart';
import 'package:category_items/category_tree/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Category Menu'),
          ),
          body: MyScreen(),
        ),
      ),
    );
  }
}

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {

  List<CategoryItem> items = categoryItems;
  late CategoryTreeMenuController controller;

  @override
  void initState() {
    super.initState();

    controller = CategoryTreeMenuController(items);
    controller.visibleListNotifier.addListener(_getVisibleList);
  }

  void _getVisibleList(){
    // String arrayRepresentation = controller.visibleList.join(', ');
    // print('[$arrayRepresentation]');
    print('visible List: ${controller.visibleList.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryTreeMenu(categoryItems: items, controller: controller),
      ],
    );
  }
}

