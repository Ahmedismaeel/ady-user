import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/update_ad/model/edit_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

final getEditProvider =
    FutureProvider.family.autoDispose<EditResponse, int>((ref, int? id) async {
  return await AppConstants.editAdHelper(id)
      .get(fromJson: EditResponse.fromJson);
});
