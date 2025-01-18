import 'package:dio/dio.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/upload_image_response.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

part 'upload_image_controller.g.dart';

@riverpod
class UploadImage extends _$UploadImage {
  @override
  SubmitState<UploadImageResponse> build() {
    return const SubmitState.initial();
  }

  Future<void> uploadImage(
      {required XFile image, required ImageType type}) async {
    final body = FormData.fromMap(
        {"image": MultipartFile.fromFileSync(image.path), "type": type.name});
    await postFormDataHelper(state, url: AppConstants.uploadImage, body: body,
        onSuccess: (onSuccess) {
      // "==================> success \n $onSuccess ".log();
      state = SubmitState.success(
          response: UploadImageResponse.fromJson(onSuccess));
    });
    state = SubmitState.initial();
  }
}

enum ImageType { product, thumbnail, meta }
