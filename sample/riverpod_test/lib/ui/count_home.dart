import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_test/provider/count_provider.dart';

class CountHomeWidget extends ConsumerWidget {
  const CountHomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build Count Home Widget');
    final count = ref.watch(countProvider);
    return Center(
      child: Text(
        count.toString(),
        style: const TextStyle(fontSize: 80),
      ),
    );
  }
}
