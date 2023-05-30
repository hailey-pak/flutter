import 'package:flutter/material.dart';
import 'package:sample_app/layout/default_layout.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '지도',
      body: Center(
        child: Text('지도'),
      ),
    );
  }
}
