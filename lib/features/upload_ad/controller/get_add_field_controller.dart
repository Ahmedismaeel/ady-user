import 'package:flutter_sixvalley_ecommerce/features/ads/models/add_field_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_add_field_controller.g.dart';

@riverpod
Future<List<AdFieldModel>> getAddFieldList(GetAddFieldListRef ref,
    {required int adId}) async {
  return await AppConstants.getAdField(adId)
      .getList(fromJson: AdFieldModel.fromJson);
}
