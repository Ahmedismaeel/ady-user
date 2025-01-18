import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

typedef Parameters = ({int active, int? category});
final expiredAdProvider = FutureProvider.autoDispose
    .family<List<Product>, Parameters>((ref, id) async {
  return await AppConstants.expiredAd(category: id.category, status: id.active)
      .getList(fromJson: Product.fromJson);
});
