import 'package:flutter_riverpod/flutter_riverpod.dart';

class SortDataNotifier extends StateNotifier<int> {
  SortDataNotifier() : super(0);
  set(int val) {
    state = val;
  }

  clear() {
    state = 0;
  }
}

final sortProvider = StateNotifierProvider<SortDataNotifier, int>((ref) {
  return SortDataNotifier();
});
