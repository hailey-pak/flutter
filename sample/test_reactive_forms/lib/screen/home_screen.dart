import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/main.dart';
import 'package:test_reactive_forms/model/base_map_model.dart';
import 'package:test_reactive_forms/model/data_model.dart';
import 'package:test_reactive_forms/screen/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Box box = Hive.box(dataBox);
    final List<dynamic> keys = box.keys.toList();

    return DefaultLayout(
      title: 'Home Screen',
      body: GridView.count(
        crossAxisCount: 5,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        children: keys
            .map(
              (key) {
                BaseMapModel dataModel = box.get(key);
                return ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            DetailScreen(fid: key),
                      ),
                    );
                  },
                  child: Text(dataModel.jibun),
                );
              },
            )
            .toList(),
      ),
    );
  }
}
