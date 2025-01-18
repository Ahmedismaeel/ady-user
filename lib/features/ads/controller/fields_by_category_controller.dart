import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/category_field_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fields_by_category_controller.g.dart';

@riverpod
Future<List<FieldHelperModel>> fieldsByCateogry(FieldsByCateogryRef ref,
    {required int categoryId}) async {
  final list = await AppConstants.categoryFields(categoryId)
      .getList(fromJson: CategoryFieldModel.fromJson);
  list.sort((a, b) => a.order?.compareTo(b.order ?? 0) ?? 0);
  List<FieldHelperModel> helperList = [];
  for (var i = 0; i < list.length; i++) {
    helperList.add(FieldHelperModel(
        i, list[i], i == 0 ? false : list[i - 1].isParent == 1));
  }
  return helperList;
}

class FieldHelperModel {
  final int order;
  final bool hasParent;
  final CategoryFieldModel field;
  FieldHelperModel(this.order, this.field, this.hasParent);
  log() {
    "order $order \n ${field.toJson()}".log();
  }
}
