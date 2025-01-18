import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';

class ParentNotifier extends StateNotifier<Map<int, int?>> {
  final StateNotifierProviderRef<ParentNotifier, Map<int, int?>> ref;
  ParentNotifier(this.ref) : super({});
  addParent({required int order, required int? parentId}) {
    Map<int, int?> map = {};
    map.addAll(state);
    map[order + 1] = parentId;

    state = map;
  }

  clear() {
    state = {};
  }
}

final parentProvider =
    StateNotifierProvider<ParentNotifier, Map<int, int?>>((ref) {
  return ParentNotifier(ref);
});
