import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

class RemoveCartNotifier extends StateNotifier<SubmitState<int>> {
  RemoveCartNotifier() : super(const SubmitState.initial());

  delete() async {
    try {
      await deleteHelper(state, url: AppConstants.removeFromCartUri,
          onSuccess: (onSuccess) {
        state = const SubmitState.success(response: 0);
        return true;
      });
    } catch (e) {
      return false;
    }
    return false;
  }
}

final removeCartProvider =
    StateNotifierProvider<RemoveCartNotifier, SubmitState<int>>((ref) {
  return RemoveCartNotifier();
});
