import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

categoryColor(int i) {
  switch (i) {
    case 1:
      return Colors.teal;
    case 2:
      return Colors.teal;

    case 3:
      return Colors.indigo;
    case 4:
      return Colors.teal;
    default:
      return UiColors.darkBlue;
  }
}

class PlanWidget extends StatelessWidget {
  const PlanWidget({
    super.key,
    required this.plan,
  });

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecorationDefault(
            color: categoryColor(plan.categoryId ?? 0), boxShadow: []),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  plan.name ?? "Starter Plan",
                  style: textStyle(20).copyWith(color: UiColors.white),
                ),
              ],
            ),
            3.height,
            Row(
              children: [
                Text(
                  "For".translate(context) +
                      " ${categoryById(plan.categoryId ?? 0)}",
                  style: textStyle(14).copyWith(color: UiColors.white),
                ),
              ],
            ),
            15.height,
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12),
                value: (plan.count ?? 0.00) /
                    ((plan.totalCount ?? 15) == 0
                        ? 15
                        : (plan.totalCount ?? 15)),
                backgroundColor: UiColors.white,
                color: UiColors.secondary,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "${(plan.count ?? 0.00)}/${((plan.totalCount ?? 15) == 0 ? 15 : (plan.totalCount ?? 15))}",
                  style: textStyle(16).copyWith(color: UiColors.white),
                ),
              ],
            ),
            7.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Ads Remaining".translate(context),
                  style: textStyle(16).copyWith(color: UiColors.white),
                ),
              ],
            ),
          ],
        ));
  }
}
