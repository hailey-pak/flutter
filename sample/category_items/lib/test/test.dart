import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Scrollable ToggleButtons Example'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<bool> _selections = List.generate(20, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ToggleButtons(
        children: List.generate(
          _selections.length,
              (index) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Item ${index + 1}'),
          ),
        ),
        isSelected: _selections,
        onPressed: (int index) {
          setState(() {
            _selections[index] = !_selections[index];
          });
        },
      ),
    );
  }
}
