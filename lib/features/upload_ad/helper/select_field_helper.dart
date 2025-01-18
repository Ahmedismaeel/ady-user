// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
// import 'package:flutter_sixvalley_ecommerce/features/ads/models/add_ad_field_request.dart';
// import 'package:flutter_sixvalley_ecommerce/features/ads/models/category_field_model.dart';
// import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
// import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

// class AddFieldHelper extends StateNotifier<AddAdFieldRequest> {
//   final StateNotifierProviderRef<AddFieldHelper, AddAdFieldRequest> ref;
//   AddFieldHelper(this.ref)
//       : super(AddAdFieldRequest(
//           items: [],
//         ));

//   addProductId(int productId) {
//     state = state.copyWith(productId: productId);
//   }

//   removeFieldValues({required int orderId}) {
//     List<Item> list = [];
//     list.addAll(state.items);
//     try {
//       final selection = list.firstWhere((item) => item.order == orderId);
//       addFieldWithValues(selection.field!, []);
//     } catch (e) {}
//   }

//   addFieldWithValues(CategoryFieldModel field, List<String> values,
//       {int? order}) {
//     List<Item> list = [];
//     list.addAll(state.items);
//     try {
//       list.firstWhere((item) => item.field?.id == field.id);
//       list.removeWhere((item) => item.field?.id == field.id);
//       list.add(Item(
//         order: order ?? ref.watch(fieldCounterProvider),
//         field: field,
//         value: values,
//       ));
//     } catch (e) {
//       list.add(Item(
//         order: ref.watch(fieldCounterProvider),
//         field: field,
//         value: values,
//       ));
//     }
//     state = state.copyWith(items: list);
//     "${state.toJson()}".log();
//   }

//   clear() {
//     " -- clear XX xx".log();
//     state = AddAdFieldRequest(
//       items: [],
//     );
//   }
// }

// final addhelperProvider =
//     StateNotifierProvider<AddFieldHelper, AddAdFieldRequest>((ref) {
//   return AddFieldHelper(ref);
// });

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_parent_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/save_data_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

class SaveAdHelperNotifier extends StateNotifier<List<SaveAddHelperModel>> {
  final StateNotifierProviderRef ref;
  SaveAdHelperNotifier(this.ref) : super([]);

  addValue(
      {required FieldWithOrder field,
      required List<String> values,
      int? parent}) {
    List<SaveAddHelperModel> list = [];
    list.addAll(state);
    try {
      int index = list.indexWhere((item) => item.field?.order == field.order);
      list[index] = (SaveAddHelperModel(field: field, values: values));
    } catch (e) {
      list.add(SaveAddHelperModel(field: field, values: values));
    }

    if (field.field.isParent == 1) {
      ref
          .read(parentProvider.notifier)
          .addParent(order: field.order, parentId: parent);
      state = list;
      removeValue(order: field.order + 1);
    } else {
      state = list;
    }
  }

  removeValue({
    required int order,
  }) {
    List<SaveAddHelperModel> list = [];
    list.addAll(state);
    try {
      int index = list.indexWhere((item) => item.field?.order == order);
      SaveAddHelperModel item = list[index];
      item.log();
      list[index] = item.copyWith(values: []);
      list[index].values.log();
      state = list;
    } catch (e) {}
  }

  clear() {
    ref.read(parentProvider.notifier).clear();
    state = [];
  }
}

final saveHelperProvider =
    StateNotifierProvider<SaveAdHelperNotifier, List<SaveAddHelperModel>>(
        (ref) {
  return SaveAdHelperNotifier(ref);
});
