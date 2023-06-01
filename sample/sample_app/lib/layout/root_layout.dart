import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sample_app/const/colors.dart';
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

class _RootLayoutState extends State<RootLayout>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectedIndex = 0;
  late String _title;

  final List<Option> options = [
    Option(name: '지도', icon: Icons.map, widget: const MapScreen()),
    Option(name: '검색', icon: Icons.search, widget: const SearchScreen()),
    Option(
        name: '일정',
        icon: Icons.calendar_today_sharp,
        widget: const ScheduleScreen()),
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
      body: SafeArea(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: options.map((e) => e.widget).toList(),
        ),
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
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,   //뒤로가기 버튼 제거
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
      onTap: (index) => controller.animateTo(index),
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.white,
      unselectedItemColor: PRIMARY_COLOR,
      items: options
          .map((e) => renderNavigationBarItem(
              icon: e.icon, label: e.name, index: options.indexOf(e)))
          .toList(),
    );
  }

  BottomNavigationBarItem renderNavigationBarItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight + 8.0,
        color: selectedIndex == index ? PRIMARY_COLOR : Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selectedIndex == index ? Colors.white : PRIMARY_COLOR,
              ),
              Text(
                label,
                style: TextStyle(
                    color:
                        selectedIndex == index ? Colors.white : PRIMARY_COLOR),
              ),
            ],
          ),
        ),
      ),
      label: '',
      // label: label,
    );
  }
}
