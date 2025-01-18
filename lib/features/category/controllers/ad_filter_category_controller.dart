import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_new_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ad_filter_category_controller.g.dart';

@riverpod
Future<FilterResponse> adfilterByCategory(
  AdfilterByCategoryRef ref,
) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": ref.watch(categoryProvider)?.id,
    "product_type": ['ad'],
    "offset": 0,
    "limit": 10,
  });
}

@riverpod
Future<FilterResponse> productfilterByCategory(
  ProductfilterByCategoryRef ref,
) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": ref.watch(categoryProvider)?.id,
    "product_type": ['physical', 'digital'],
    "offset": 0,
    "limit": 10,
  });
}
