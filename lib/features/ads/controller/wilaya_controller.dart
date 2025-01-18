import 'package:flutter_sixvalley_ecommerce/features/ads/models/wilaya_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wilaya_controller.g.dart';

@riverpod
Future<List<WilayaModel>> wilayaList(WilayaListRef ref, int id) async {
  return await AppConstants.wilayaList(
          ref.watch(governorateHelperProvider)?.id ?? 0)
      .getList(fromJson: WilayaModel.fromJson);
}
