import 'package:flutter/material.dart';
import 'package:sample_app/layout/default_layout.dart';

class ARScreen extends StatelessWidget {
  const ARScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'AR',
      body: Center(
        child: Text('AR'),
      ),
    );
  }
}
