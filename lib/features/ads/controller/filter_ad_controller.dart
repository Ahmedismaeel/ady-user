import 'package:flutter_sixvalley_ecommerce/features/ads/helper/marker_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'filter_ad_controller.g.dart';

@riverpod
Future<FilterResponse> adSearch(
  AdSearchRef ref, {
  required FilterRequest request,
}) async {
  final data = await AppConstants.searchAd.get(
      fromJson: FilterResponse.fromJson,
      data: FilterRequest(
        name: request.name,
        productType: request.productType ?? [],
        categoryId: request.categoryId,
        subCategoryId: request.subCategoryId,
        governorateId: request.governorateId,
        wilyaId: request.wilyaId,
        priceMin: request.priceMin,
        priceMax: request.priceMax,
        items: request.items ?? [],
        location: request.location,
        radius: 60,
        latitude: request.latitude,
        longitude: request.longitude,
        priceSort: request.priceSort,
        dateSort: request.dateSort,
        offset: request.offset ?? 0,
        limit: request.limit ?? 10,
      ).toJson());
  return data;
  // ref.read(markerProvider.notifier).setProducts(list.products);
}
