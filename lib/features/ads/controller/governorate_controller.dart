import 'package:flutter_sixvalley_ecommerce/features/ads/models/governorate_mode.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'governorate_controller.g.dart';

@riverpod
Future<List<GovernorateModel>> governorateList(GovernorateListRef ref) async {
  return await AppConstants.governorateList
      .getList(fromJson: GovernorateModel.fromJson);
}
