import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_plan_controller.g.dart';

@riverpod
Future<List<PlanModel>> myPlanList(MyPlanListRef ref) async {
  return await "${AppConstants.myPlan}".getList(fromJson: PlanModel.fromJson);
}
