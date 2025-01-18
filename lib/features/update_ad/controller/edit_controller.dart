import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/my_ads_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/create_add_request.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/create_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/phone_option_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';

class EditAdNotifier extends StateNotifier<SubmitState<int>> {
  final StateNotifierProviderRef<EditAdNotifier, SubmitState<int>> ref;
  EditAdNotifier(this.ref) : super(const SubmitState.initial());

  update({
    required int adId,
    required TextEditingController nameAr,
    required TextEditingController nameEn,
    required TextEditingController unitPrice,
    required TextEditingController descriptionAr,
    required TextEditingController descriptionEn,
    required TextEditingController phone,
    required String? thumbnail,
    required List<String>? imageList,
    required int? governorateId,
    required int? wilyaId,
  }) {
    state = SubmitState.initial();

    final body = CreateAdRequest(
        name: [nameEn.text, nameAr.text],
        description: [descriptionEn.text, descriptionAr.text],
        unitPrice: double.tryParse(unitPrice.text),
        images: List.generate(
            imageList?.length ?? 0, (i) => Images(imageName: imageList?[i])),
        thumbnail: thumbnail,
        // subscribedPlanId: ref.watch(planSelectionProvider),
        latitude: ref.watch(locationAdProvider)?.latitude,
        longitude: ref.watch(locationAdProvider)?.longitude,
        governorateId: governorateId,
        wilyaId: wilyaId,
        isCall: ref.read(phoneOptionProvider.notifier).getValue(),
        phone: phone.text);
    body.toJson().log();
    putHelper(state, url: AppConstants.updateAd(id: adId), body: body,
        onSuccess: (success) {
      state = SubmitState.success(response: 0);
      ref.invalidate(myAdsProvider);
    });
  }
}

final editAdProvider =
    StateNotifierProvider<EditAdNotifier, SubmitState<int>>((ref) {
  return EditAdNotifier(ref);
});

class UpdateStatusNotifier extends StateNotifier<SubmitState<int>> {
  final StateNotifierProviderRef<UpdateStatusNotifier, SubmitState<int>> ref;
  UpdateStatusNotifier(this.ref) : super(const SubmitState.initial());
  updateStatus({required int statusId, required int productId}) {
    state = const SubmitState.initial();
    "${{"status": statusId, "id": productId}}".log();
    // final d = {"status": statusId, "id": productId};
    postHelper(state,
        url: AppConstants.updateAdStatus,
        body: {"status": statusId, "id": productId}, onSuccess: (s) {
      state = const SubmitState.success(response: 0);
      ref.invalidate(myAdsProvider);
    });
  }
}

final updateAdStatusProvider =
    StateNotifierProvider<UpdateStatusNotifier, SubmitState<int>>((ref) {
  return UpdateStatusNotifier(ref);
});
