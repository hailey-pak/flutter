import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sect23_tabbar/const/tabs.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen>
    with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();

    controller = TabController(
      length: TABS.length,
      vsync: this,
    );

    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bottom Navigation Bar'),
      ),
      body: TabBarView(
        controller: controller,
        children: TABS
            .map(
              (e) => Center(
                child: Icon(e.icon),
              ),
            )
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          currentIndex: controller.index,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.animateTo(index);
          },
          items: TABS
              .map(
                (e) => BottomNavigationBarItem(
                  icon: Icon(e.icon),
                  label: e.label,
                ),
              )
              .toList()),
    );
  }
}
