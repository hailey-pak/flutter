import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_theory/layout/default_layout.dart';
import 'package:riverpod_theory/riverpod/code_generation_provider.dart';

class CodeGenerationScreen extends ConsumerWidget {
  const CodeGenerationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');

    final state1 = ref.watch(gStateProvider);
    final state2 = ref.watch(gStateFutureProvider);
    final state3 = ref.watch(gStateFuture2Provider);
    final state4 = ref.watch(gStateMultiplyProvider(
      number1: 10,
      number2: 20,
    ));

    return DefaultLayout(
      title: 'CodeGenerationScreen',
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'State1 : $state1',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          state2.when(
            data: (data) {
              return Text(
                'State2 : $data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            },
            error: (error, stackTrace) {
              return Text(
                error.toString(),
                textAlign: TextAlign.center,
              );
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          state3.when(
            data: (data) {
              return Text(
                'State3 : $data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              );
            },
            error: (error, stackTrace) {
              return Text(
                error.toString(),
                textAlign: TextAlign.center,
              );
            },
            loading: () {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          Text(
            'State4 : $state4',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final state5 = ref.watch(gStateNotifierProvider);

              return Row(
                children: [
                  Text(
                    'State5 : $state5',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  if (child != null) child,
                ],
              );
            },
            child: Text('    hello'),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).increment();
                },
                child: Text('Increment'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(gStateNotifierProvider.notifier).decrement();
                },
                child: Text('Decrement'),
              ),
            ],
          ),

          //invalidate() 유효하지 않게 하다
          ElevatedButton(
            onPressed: () {
              ref.invalidate(gStateNotifierProvider);
            },
            child: Text('Invalidate'),
          ),
        ],
      ),
    );
  }
}

class _StateFiveWidget extends ConsumerWidget {
  const _StateFiveWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state5 = ref.watch(gStateNotifierProvider);

    return Text(
      'State5 : $state5',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 20,
      ),
    );
  }
}
