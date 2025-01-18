import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

class FieldCountNotifier extends StateNotifier<int> {
  final StateNotifierProviderRef<FieldCountNotifier, int> ref;
  FieldCountNotifier(this.ref) : super(0);
  bool nextPage() {
    if ((state + 1) == ref.watch(fieldsSizeProvider)) {
      return false;
    } else {
      state = state + 1;

      return true;
    }
  }

  previousPage() {
    state == 0 ? "".log() : state = state - 1;
  }

  reset() {
    state == 0;
  }
}

final fieldCounterProvider =
    StateNotifierProvider<FieldCountNotifier, int>((ref) {
  return FieldCountNotifier(ref);
});

class FieldsSizeNotifier extends StateNotifier<int> {
  FieldsSizeNotifier() : super(0);
  setSize(int size) {
    state = size;
  }
}

final fieldsSizeProvider =
    StateNotifierProvider<FieldsSizeNotifier, int>((ref) {
  return FieldsSizeNotifier();
});
