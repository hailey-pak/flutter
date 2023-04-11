import 'package:flutter/material.dart';
import 'package:test_reactive_forms/component/data_form.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/model/field_model.dart';

class DetailScreen extends StatelessWidget {
  final String fid;
  final List<FieldModel> fields;

  const DetailScreen({
    required this.fid,
    required this.fields,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Detail Screen',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: DataForm(
                fields: fields,
                fid: fid),
          ),
        ),
      ),
    );
  }
}
