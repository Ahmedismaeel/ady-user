import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'my_ads_controller.g.dart';

// @riverpod
// Future<List<Product>> myAds(MyAdsRef ref, {int? statusId}) async {
//   if (statusId != null) {
//     return await "${AppConstants.myAds}/status/$statusId"
//         .getList(fromJson: Product.fromJson);
//   } else {
//     return await AppConstants.myAds.getList(fromJson: Product.fromJson);
//   }
// }

typedef MyAdParam = ({int statusId, int? categoryId});

final myAdsProvider = FutureProvider.family<List<Product>, MyAdParam>(
    (ref, MyAdParam param) async {
  return param.categoryId == null
      ? await "${AppConstants.myAds}/status/${param.statusId}"
          .getList(fromJson: Product.fromJson)
      : await "${AppConstants.myAds}/status/${param.statusId}/${param.categoryId}"
          .getList(fromJson: Product.fromJson);
});
