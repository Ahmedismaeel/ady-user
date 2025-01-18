import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

class PhoneOptionNotifier extends StateNotifier<List<int>> {
  PhoneOptionNotifier() : super([]);
  setCall() {
    "setCall".log();
    if (state.contains(0)) {
      List<int> list = [...state];
      list.remove(0);
      state = list;
    } else {
      List<int> list = [...state];
      list.add(0);
      state = list;
    }
  }

  setWhatsapp() {
    "setWhatsapp".log();
    if (state.contains(1)) {
      List<int> list = [...state];
      list.remove(1);
      state = list;
    } else {
      List<int> list = [...state];
      list.add(1);
      state = list;
    }
  }

  int? getValue() {
    if (state.contains(1) && state.contains(0)) {
      return 2;
    } else if (state.contains(1)) {
      return 1;
    } else if (state.contains(0)) {
      return 0;
    } else {
      return null;
    }
  }
}

final phoneOptionProvider =
    StateNotifierProvider<PhoneOptionNotifier, List<int>>((ref) {
  return PhoneOptionNotifier();
});
