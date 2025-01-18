import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'view_ad_controller.g.dart';

@riverpod
Future<dynamic> viewAdController(ViewAdControllerRef ref, {required id}) async {
  return await AppConstants.viewAd(id)
      .get(fromJson: (Map<String, dynamic> s) {});
}
