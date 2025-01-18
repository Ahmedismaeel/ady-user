import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'plan_list_controller.g.dart';

@riverpod
Future<List<PlanModel>> planList(PlanListRef ref,
    {required int categoryId, required int type}) async {
  return await AppConstants.planByCategoryId(categoryId, type)
      .getList(fromJson: PlanModel.fromJson);
}





//////