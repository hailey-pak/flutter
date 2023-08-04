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
          iconTheme: IconThemeData(
            size: 30,
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.green,
          size: 50.0,
          fill: 0.0,
          grade: 10,
          weight: 10.0,
          opacity: 1.0,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.pink,
            iconSize: 30,
          ),
        ),

        actionIconTheme: ActionIconThemeData(
          backButtonIconBuilder: (context) {
            return Icon(Icons.arrow_back_ios_new);
          },
          closeButtonIconBuilder: (context) {
            return Icon(Icons.cancel, color: Colors.purple, size: 30,);
          },
          drawerButtonIconBuilder: (context) {
            return Text('menu');
          },
          endDrawerButtonIconBuilder: (context) {
            return Icon(Icons.menu_open);
          },
        ),
      ),
      home: IconThemeScreen(),
    );
  }
}

class IconThemeScreen extends StatelessWidget {
  const IconThemeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Icon Theme"),
        // leading: Icon(Icons.menu),
        automaticallyImplyLeading: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add_alert))],
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
            BackButton(),
            CloseButton(),
            DrawerButton(),
            EndDrawerButton(),
            IconTheme(data: IconThemeData(color: Colors.pink, size: 40,), child: Icon(Icons.add_alert)),
            Theme(
              data: Theme.of(context).copyWith(
                iconTheme: IconThemeData(color: Colors.red, size: 50),
              ),
              child: Icon(Icons.favorite),
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
