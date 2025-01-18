import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

typedef ProductData = ({String id, String slug, String productId});
final productDetailsProvider = FutureProvider.family
    .autoDispose<ProductDetailsModel, ProductData>(
        (ref, ProductData data) async {
  return '${AppConstants.productDetailsUri}${data.slug}?guest_id=1'
      .get(fromJson: ProductDetailsModel.fromJson);
});


// 
// 
// 
// 
// 
// ref.watch(getAddFieldListProvider(adId: id))
