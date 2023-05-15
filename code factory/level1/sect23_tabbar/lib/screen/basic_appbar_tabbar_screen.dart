import 'package:flutter/material.dart';
import 'package:sect23_tabbar/const/tabs.dart';

class BasicAppBarTabBarScreen extends StatelessWidget {
  const BasicAppBarTabBarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Basic AppBar Screen'),
          bottom: TabBar(
            indicatorColor: Colors.red,
            indicatorWeight: 4.0,
            indicatorSize: TabBarIndicatorSize.tab,
            isScrollable: true,
            tabs: TABS
                .map(
                  (e) => Tab(
                    icon: Icon(e.icon),
                    child: Text(e.label),
                  ),
                )
                .toList(),
          ),
        ),
        body: TabBarView(
          children: TABS
              .map(
                (e) => Center(
                  child: Icon(e.icon),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
