import 'package:flutter/material.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';

class DetailForm extends StatefulWidget {
  const DetailForm({Key? key}) : super(key: key);

  @override
  State<DetailForm> createState() => _DetailFormState();
}

class _DetailFormState extends State<DetailForm> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Detail Form',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(''),
          ),
        ),
      ),
    );
  }
}
