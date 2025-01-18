import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/field_value_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'field_values_controller.g.dart';

@riverpod
Future<List<FieldValueModel>> getfieldValues(GetfieldValuesRef ref,
    {required int id, required int? parentId}) async {
  "${{"parent_id": parentId}}".log();
  return await AppConstants.fieldValues(id).getList(
      fromJson: FieldValueModel.fromJson, data: {"parent_id": parentId});
}
