import 'package:flutter/material.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/riverpod/state_provider.dart';
import 'package:riverpod_theory/riverpod/stream_provider.dart';

class StreamProviderScreen extends ConsumerWidget {
  const StreamProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(multipleStreamProvider);

    return DefaultLayout(
      title: 'StreamProviderScreen',
      body: Center(
        child: state.when(
          data: (data) => Text(
            data.toString(),
          ),
          error: (error, stackTrace) => Text(
            error.toString(),
          ),
          loading: () => CircularProgressIndicator(),
        ),
      ),
    );
  }
}
