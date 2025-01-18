import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/add_ad_field_request.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/category_field_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

class AddFieldHelper extends StateNotifier<AddAdFieldRequest> {
  final StateNotifierProviderRef<AddFieldHelper, AddAdFieldRequest> ref;
  AddFieldHelper(this.ref)
      : super(AddAdFieldRequest(
          items: [],
        ));

  addProductId(int productId) {
    state = state.copyWith(productId: productId);
  }

  removeFieldValues({required int orderId}) {
    List<Item> list = [];
    list.addAll(state.items);
    try {
      final selection = list.firstWhere((item) => item.order == orderId);
      addFieldWithValues(selection.field!, []);
    } catch (e) {}
  }

  addFieldWithValues(CategoryFieldModel field, List<String> values,
      {int? order}) {
    List<Item> list = [];
    list.addAll(state.items);
    try {
      list.firstWhere((item) => item.field?.id == field.id);
      list.removeWhere((item) => item.field?.id == field.id);
      list.add(Item(
        order: order ?? ref.watch(fieldCounterProvider),
        field: field,
        value: values,
      ));
    } catch (e) {
      list.add(Item(
        order: ref.watch(fieldCounterProvider),
        field: field,
        value: values,
      ));
    }
    state = state.copyWith(items: list);
    "${state.toJson()}".log();
  }

  clear() {
    " -- clear XX xx".log();
    state = AddAdFieldRequest(
      items: [],
    );
  }
}

final addhelperProvider =
    StateNotifierProvider<AddFieldHelper, AddAdFieldRequest>((ref) {
  return AddFieldHelper(ref);
});
