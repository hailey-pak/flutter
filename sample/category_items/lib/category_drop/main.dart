import 'package:category_items/category_drop/category_drop_menu.dart';
import 'package:category_items/category_drop/category_drop_sub_chips.dart';
import 'package:category_items/category_drop/category_item.dart';
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
            title: const Text('Category Menu Widget'),
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

  late CategoryDropMenuController controller;
  List<CategoryItem> items = categoryItems;

  @override
  void initState() {
    super.initState();

    controller = CategoryDropMenuController(items);
    controller.visibleListNotifier.addListener(_getVisibleList);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
        CategoryDropAndSubChips(categoryItems: items, controller: controller),
        SizedBox(height: 20),
      ],
    );
  }
}

