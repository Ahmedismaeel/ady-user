import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/create_add_request.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/selected_cateogry_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_parent_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/phone_option_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/add_field_request.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'create_ad_controller.g.dart';

@riverpod
class CreateAd extends _$CreateAd {
  @override
  SubmitState<int> build() {
    return const SubmitState.initial();
  }

  create({
    required TextEditingController nameAr,
    required TextEditingController nameEn,
    required TextEditingController unitPrice,
    required TextEditingController descriptionAr,
    required TextEditingController descriptionEn,
    required TextEditingController phone,
    required String? thumbnail,
    required List<String> imageList,
    // required int subscribedPlanId
  }) async {
    final request = CreateAdRequest(
        name: [nameEn.text, nameAr.text],
        categoryId: ref.watch(categoryIdProvider).id,
        subCategoryId: ref.watch(subcategoryIdProvider).id,
        subSubCategoryId: ref.watch(subSubcategoryIdProvider)?.id,
        description: [descriptionEn.text, descriptionAr.text],
        unitPrice: double.tryParse(unitPrice.text),
        images: List.generate(
            imageList.length, (i) => Images(imageName: imageList[i])),
        thumbnail: thumbnail,
        subscribedPlanId: ref.watch(planSelectionProvider),
        latitude: ref.watch(locationAdProvider)?.latitude,
        longitude: ref.watch(locationAdProvider)?.longitude,
        governorateId: ref.watch(governorateHelperProvider)?.id ?? 0,
        wilyaId: ref.watch(wilayatHelperProvider)?.id ?? 0,
        isCall: ref.read(phoneOptionProvider.notifier).getValue(),
        phone: phone.text);

    await postHelper(state, url: AppConstants.createAd, body: request,
        onSuccess: (onSuccess) {
      "$onSuccess".log();
      addField("${onSuccess["product_id"]}");
    });
  }

  addField(String productId) async {
    if (ref.watch(saveHelperProvider).isEmpty) {
      state = const SubmitState.success(response: 0);
      return;
    }
    await postHelper(state,
        url: AppConstants.addAdFields,
        body: AddFieldRequest(
            productId: productId,
            items: List.generate(
                ref.watch(saveHelperProvider).length,
                (index) => Item(
                    fieldId:
                        ref.watch(saveHelperProvider)[index].field?.field.id,
                    value: ref.watch(saveHelperProvider)[index].values))),
        onSuccess: (onSuccess) {
      "$onSuccess".log();
      state = const SubmitState.success(response: 0);
    });
  }
}

class PlanIdNotifier extends StateNotifier<int?> {
  PlanIdNotifier() : super(null);

  save(int id) {
    state = id;
  }

  clear() {
    state = null;
  }
}

final planSelectionProvider =
    StateNotifierProvider<PlanIdNotifier, int?>((ref) {
  return PlanIdNotifier();
});

class LocationNotifier extends StateNotifier<LocationAd?> {
  LocationNotifier() : super(null);

  save({required double latitude, required double longitude}) {
    state = LocationAd(latitude: latitude, longitude: longitude);
  }

  clear() {
    state = null;
  }
}

final locationAdProvider =
    StateNotifierProvider<LocationNotifier, LocationAd?>((ref) {
  return LocationNotifier();
});

class LocationAd {
  final double latitude;
  final double longitude;
  LocationAd({required this.latitude, required this.longitude});
}
