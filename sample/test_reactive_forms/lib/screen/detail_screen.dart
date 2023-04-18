import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:test_reactive_forms/component/data_form.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/main.dart';

class DetailScreen extends StatefulWidget {
  final String fid;

  const DetailScreen({
    required this.fid,
    Key? key,
  }) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    var box = Hive.box(dataBox);
    var dataModel = box.get(widget.fid);

    return DefaultLayout(
      title: 'Detail Screen',
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: DataForm(
                dataModel: dataModel),
          ),
        ),
      ),
    );
  }
}
