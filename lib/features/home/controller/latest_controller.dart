import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

final latestServiceProvider =
    AutoDisposeFutureProvider<FilterResponse>((ref) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": 4,
    "product_type": ["physical", "digital"],
    "date_sort": "desc",
    "offset": 0,
    "limit": 10
  });
});

final latestProductProvider =
    AutoDisposeFutureProvider<FilterResponse>((ref) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": 3,
    "product_type": ["physical", "digital"],
    "date_sort": "desc",
    "offset": 0,
    "limit": 10
  });
});
final latestAutoAdsProvider =
    AutoDisposeFutureProvider<FilterResponse>((ref) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": 1,
    "product_type": ["ad"],
    "offset": 0,
    "limit": 10,
    "date_sort": "desc",
  });
});
final latestRealStateAdsProvider =
    AutoDisposeFutureProvider<FilterResponse>((ref) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": 2,
    "product_type": ["ad"],
    "offset": 0,
    "date_sort": "desc",
    "limit": 10
  });
});
final latestServiceAdsProvider =
    AutoDisposeFutureProvider<FilterResponse>((ref) async {
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": 4,
    "product_type": ["ad"],
    "offset": 0,
    "limit": 10,
    "date_sort": "desc",
  });
});

final latestProductAdsProvider =
    AutoDisposeFutureProvider<FilterResponse>((ref) async {
  await Future.delayed(
      const Duration(seconds: 2)); // Simulating a network request
  return await AppConstants.searchAd
      .get(fromJson: FilterResponse.fromJson, data: {
    "category_id": 3,
    "product_type": ["ad"],
    "offset": 0,
    "limit": 10,
    "date_sort": "desc",
  });
});
