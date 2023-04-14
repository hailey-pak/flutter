import 'package:flutter/material.dart';
import 'package:sample_form/component/data_form.dart';
import 'package:sample_form/layout/default_layout.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      title: 'Detail Screen',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: DataForm(),
          ),
        ),
      ),
    );
  }
}