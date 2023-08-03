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
          color: Colors.pink,
          centerTitle: true,
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle (
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          toolbarHeight: 50,
          iconTheme: IconThemeData(
            color: Colors.green,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.yellow,
          ),
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
        title: Text("AppBar Theme"),
        leading: Icon(Icons.menu),
        actions: [IconButton(onPressed: (){}, icon: Icon(Icons.add_alert))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
