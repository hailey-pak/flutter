import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_actual/layout/default_layout.dart';
import 'package:go_router_actual/provider/auth_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/one');
            },
            child: const Text('Screen One (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/one/two');
            },
            child: const Text('Screen Two (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              // context.go('/one/two/three');
              context.goNamed('three');
            },
            child: const Text('Screen Three (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('error');
            },
            child: const Text('Error Screen (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/login');
            },
            child: const Text('Login Screen (GO)'),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(userProvider.notifier).logout();
            },
            child: const Text('Logout (GO)'),
          ),
        ],
      ),
    );
  }
}
