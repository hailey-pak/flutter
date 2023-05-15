import 'package:flutter/material.dart';
import 'package:sect23_tabbar/screen/appbar_using_controller.dart';
import 'package:sect23_tabbar/screen/basic_appbar_tabbar_screen.dart';
import 'package:sect23_tabbar/screen/bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BasicAppBarTabBarScreen(),
                  ),
                );
              },
              child: Text('Basic AppBar TabBar Screen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AppBarUsingController(),
                  ),
                );
              },
              child: Text('AppBar Using Controller'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BottomNavigationBarScreen(),
                  ),
                );
              },
              child: Text('Bottom Navigation Bar Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
