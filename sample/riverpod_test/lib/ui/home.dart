import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/provider/count_provider.dart';
import 'package:riverpod_test/ui/count_home.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build Home');
    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Sample')),
      body: const CountHomeWidget(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => ref.read(countProvider.notifier).add(),
            icon: Icon(Icons.add),
          ),
          IconButton(
            onPressed: () => ref.read(countProvider.notifier).remove(),
            icon: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
