import 'package:flutter/material.dart';
import 'package:sample_app/screen/ar_screen.dart';
import 'package:sample_app/screen/map_screen.dart';
import 'package:sample_app/screen/qr_screen.dart';
import 'package:sample_app/screen/schedule_screen.dart';
import 'package:sample_app/screen/search_screen.dart';

class Option {
  final String name;
  final IconData icon;
  final Widget widget;

  Option({
    required this.name,
    required this.icon,
    required this.widget,
  });
}

class RootLayout extends StatefulWidget {
  const RootLayout({Key? key}) : super(key: key);

  @override
  State<RootLayout> createState() => _RootLayoutState();
}

class _RootLayoutState extends State<RootLayout> with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectedIndex = 0;
  late String _title;

  final List<Option> options = [
    Option(name: '지도', icon: Icons.map, widget: const MapScreen()),
    Option(name: '검색', icon: Icons.search, widget: const SearchScreen()),
    Option(name: '일정', icon: Icons.calendar_today_sharp, widget: const ScheduleScreen()),
    Option(name: 'QR', icon: Icons.qr_code, widget: const QRScreen()),
    Option(name: 'AR', icon: Icons.camera, widget: const ARScreen()),
  ];

  void tabListener() {
    setState(() {
      selectedIndex = controller.index;
      _title = options[selectedIndex].name;
    });
  }

  @override
  void initState() {
    super.initState();

    controller = TabController(length: 5, vsync: this);
    controller.addListener(tabListener);
    _title = options[0].name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: options.map((e) => e.widget).toList(),
      ),
      bottomNavigationBar: renderNavigationBar(),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        _title,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.notifications_none_rounded),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings),
        ),
      ],
    );
  }

  BottomNavigationBar renderNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) => controller.animateTo(index),
      type: BottomNavigationBarType.fixed,
      fixedColor: Colors.pink,
      // selectedFontSize: 48.sp,
      unselectedItemColor: Theme.of(context).primaryColor,
      // unselectedFontSize: 48.sp,
      showUnselectedLabels: true,
      items: options
          .map((e) => renderNavigationBarItem(icon: e.icon, label: e.name))
          .toList(),
    );
  }

  BottomNavigationBarItem renderNavigationBarItem({
    required IconData icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
      ),
      label: label,
    );
  }
}
