import 'package:flutter/material.dart';
import 'package:sample_app/layout/default_layout.dart';

class QRScreen extends StatelessWidget {
  const QRScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'QR',
      body: Center(
        child: Text('QR'),
      ),
    );
  }
}
