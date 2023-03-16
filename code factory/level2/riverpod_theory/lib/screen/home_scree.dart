import 'package:flutter/material.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/screen/future_provider_screen.dart';
import 'package:riverpod_theory/screen/state_notifier_provider_screen.dart';
import 'package:riverpod_theory/screen/state_provider_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
        title: 'HomeScreen',
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StateProviderScreen(),
                  ),
                );
              },
              child: Text('StateProviderScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => StateNotifierProviderScreen(),
                  ),
                );
              },
              child: Text('StateNotifierProviderScreen'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FutureProviderScreen(),
                  ),
                );
              },
              child: Text('FutureProviderScreen'),
            ),
          ],
        ));
  }
}
