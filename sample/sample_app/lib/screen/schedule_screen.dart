import 'package:flutter/material.dart';
import 'package:sample_app/layout/default_layout.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '일정',
      body: Center(
        child: Text('일정'),
      ),
    );
  }
}
