import 'package:flutter/material.dart';
import 'package:sample_app/layout/default_layout.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '검색',
      body: Center(
        child: Text('검색'),
      ),
    );
  }
}
