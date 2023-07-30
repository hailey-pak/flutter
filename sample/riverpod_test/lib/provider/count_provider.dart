
import 'package:flutter_riverpod/flutter_riverpod.dart';

final countProvider = StateNotifierProvider((ref) => CountProvider());

class CountProvider extends StateNotifier {
  CountProvider() : super(0);

  void add() => state++;

  void remove() => state--;
}