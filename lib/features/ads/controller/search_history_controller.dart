import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/share_preferance.dart';

class SearchHistoryNotifier extends StateNotifier<List<String>> {
  SearchHistoryNotifier()
      : super(SharedPreferenceHelper.instance.getSavedSearchProductName());

  saveText(String search) async {
    await SharedPreferenceHelper.instance.saveSearchProductName(search);
    state = SharedPreferenceHelper.instance.getSavedSearchProductName();
  }

  deleteText(String search) async {
    await SharedPreferenceHelper.instance.removeSearchProductName(search);
    state = SharedPreferenceHelper.instance.getSavedSearchProductName();
  }

  clear() async {
    await SharedPreferenceHelper.instance.clearSearchProductNames();
    state = SharedPreferenceHelper.instance.getSavedSearchProductName();
  }
}

final searchHistoryProvider =
    StateNotifierProvider<SearchHistoryNotifier, List<String>>((ref) {
  return SearchHistoryNotifier();
});
