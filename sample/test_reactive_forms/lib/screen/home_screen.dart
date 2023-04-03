import 'package:flutter/material.dart';
import 'package:test_reactive_forms/layout/default_layout.dart';
import 'package:test_reactive_forms/screen/detail_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: 'Home Screen',
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => DetailForm()));
          },
          child: Text('입력폼으로 이동'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(
              MediaQuery.of(context).size.width / 2,
              MediaQuery.of(context).size.height / 5,
            ),
            textStyle: TextStyle(
              fontSize: 50.0,
            ),
          ),
        ),
      ),
    );
  }
}
