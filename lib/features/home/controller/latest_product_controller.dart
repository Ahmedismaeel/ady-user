import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'latest_product_controller.g.dart';

@riverpod
Future<ProductModel> latestProductList(LatestProductListRef ref,
    {required int page}) async {
  return await (AppConstants.newArrivalProductUri + "$page")
      .get(fromJson: ProductModel.fromJson);
}
