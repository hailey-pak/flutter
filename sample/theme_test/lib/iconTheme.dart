import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        iconTheme: IconThemeData(
          color: Colors.purpleAccent,
          size: 100.0,
          fill: 0.0,
          grade: 10,
          weight: 10.0,
          opacity: 1.0,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(

          ),
        ),
        actionIconTheme: ActionIconThemeData(

        ),
      ),
      home: AppBarScreen(),
    );
  }
}

class AppBarScreen extends StatelessWidget {
  const AppBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Icon Theme"),
        leading: Icon(Icons.menu),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add_alert))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.android),
            Icon(Icons.flight),
            Icon(Icons.directions_subway),
            Icon(
              Icons.widgets,
              color: Colors.blue.shade400,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
