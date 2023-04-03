import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final Widget body;

  const DefaultLayout({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      body: body,
    );
  }
}
