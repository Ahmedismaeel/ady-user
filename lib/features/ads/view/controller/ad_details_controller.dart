import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

final adDetailsProvider = FutureProvider.autoDispose
    .family<ProductDetailsModel, String>((ref, String slug) async {
  return await "${AppConstants.productDetailsUri}$slug?guest_id=1"
      .get(fromJson: ProductDetailsModel.fromJson);
});
