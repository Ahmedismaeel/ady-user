import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';

// final assignToPlanProvider = FutureProvider.autoDispose.family<bool, int>((ref, id) async {
//   return true;
// });
class AssignToPlanNotifier extends StateNotifier<SubmitState<int>> {
  final StateNotifierProviderRef<AssignToPlanNotifier, SubmitState<int>> ref;
  AssignToPlanNotifier(this.ref) : super(const SubmitState.initial());

  send({required int planId, required List<int> productIdList}) async {
    state = const SubmitState.initial();
    await postHelper(state,
        url: AppConstants.assingProductToPlan,
        body: {"plan_id": planId, "products": productIdList},
        onSuccess: (onSuccess) {
      state = const SubmitState.success(response: 0);
    });
  }
}

final assignToPlanProvider =
    StateNotifierProvider<AssignToPlanNotifier, SubmitState<int>>((ref) {
  return AssignToPlanNotifier(ref);
});
