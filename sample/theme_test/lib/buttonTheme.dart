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
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll<Color>(Colors.green),
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.black),
            padding: MaterialStatePropertyAll(EdgeInsets.all(8.0)),
            fixedSize: MaterialStatePropertyAll(Size(200, 80)),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                }
                return null;
              },
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.amberAccent,
            padding: const EdgeInsets.all(16.0),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.blue,
          ),
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.pink,
            iconSize: 30,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          iconSize: 30,
          sizeConstraints: BoxConstraints.tightFor(width: 100, height: 100),
        ),
        menuButtonTheme: MenuButtonThemeData(
          style: MenuItemButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.pink,
          ),
        ),
      ),
      home: ButtonThemScreen(),
    );
  }
}

class ButtonThemScreen extends StatelessWidget {
  const ButtonThemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Icon Theme"),
        leading: Icon(Icons.menu),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add_alert))],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(onPressed: () {}, child: Text('Elevated Button')),
            FilledButton(onPressed: () {}, child: Text('Filled Button')),
            FilledButton.tonal(
                onPressed: () {}, child: Text('Filled Tonal Button')),
            OutlinedButton(onPressed: () {}, child: Text('Outlined Button')),
            TextButton(onPressed: () {}, child: Text('Text Button')),
            IconButton(onPressed: () {}, icon: Icon(Icons.widgets)),
            const SegmentButtonWidget(),
            MenuItemButton(
              child: Text('Menu Item Button'),
              onPressed: () {},
            ),
            SubmenuButton(menuChildren: [
              TextButton(
                onPressed: () {},
                child: Text('button1'),
              ),
              TextButton(
                onPressed: () {},
                child: Text('button2'),
              ),
            ], child: Text('SubMenu Button')),
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

class SegmentButtonWidget extends StatefulWidget {
  const SegmentButtonWidget({super.key});

  @override
  State<SegmentButtonWidget> createState() => _SegmentButtonWidgetState();
}

class _SegmentButtonWidgetState extends State<SegmentButtonWidget> {
  int _selected = 1;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<int>(
      segments: const <ButtonSegment<int>>[
        ButtonSegment<int>(
          value: 1,
          label: Text('one'),
        ),
        ButtonSegment<int>(
          value: 2,
          label: Text('two'),
        ),
        ButtonSegment<int>(
          value: 3,
          label: Text('three'),
        ),
        ButtonSegment<int>(
          value: 4,
          label: Text('four'),
        ),
      ],
      selected: <int>{_selected},
      onSelectionChanged: (newSelect) {
        setState(() {
          _selected = newSelect.first;
        });
      },
    );
  }
}
