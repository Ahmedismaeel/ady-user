import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyAdsHelperNotifier extends StateNotifier<List<int>> {
  MyAdsHelperNotifier() : super([]);
  addProductId(int id) {
    List<int> items = [];
    items.addAll(state);
    if (!items.contains(id)) {
      items.add(id);
    } else {
      items.remove(id);
    }
    state = items;
  }

  bool isChecked(int id) {
    return state.contains(id);
  }

  reset() {
    state = [];
  }
}

final myadsHelperProvider =
    StateNotifierProvider<MyAdsHelperNotifier, List<int>>((ref) {
  return MyAdsHelperNotifier();
});
