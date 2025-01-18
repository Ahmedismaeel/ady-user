import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/shipping_details_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/subscribe_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class PlanWidgetNew extends ConsumerWidget {
  // final int subscribedId;
  const PlanWidgetNew({
    super.key,
    // required this.subscribedId,
    required this.plan,
    required this.isRenew,
    this.isSeller = false,
  });
  final bool isRenew;
  final bool isSeller;
  final PlanModel plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Badge(
      // smallSize: 22,
      largeSize: 18,
      textStyle: textStyle(13),
      offset: const Offset(-8, -4),
      isLabelVisible: (plan.discount ?? 0) > 0,
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      label: Text(
        "%${plan.discount ?? ""}",
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: boxDecorationDefault(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(4, 4), // Offset in x and y direction
              ),
            ],
            color: UiColors.bgBlue,
            border: Border.all(color: UiColors.borderBlue)),
        // height: 220,
        width: 165,
        child: Column(
          children: [
            18.height,
            // Divider(),
            Row(
              children: [
                Text(
                  "${plan.name}".capitalize(),
                  style: textStyle(19).copyWith(
                      color: UiColors.darkBlue, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            5.height,
            Divider(
              color: UiColors.lightGrey,
            ).paddingSymmetric(horizontal: 30),
            RichText(
                text: TextSpan(
                    text: "${plan.price}",
                    style: textStyle(28).copyWith(color: UiColors.darkBlue),
                    children: [TextSpan(text: "OMR", style: textStyle(12))])),
            Divider(
              color: UiColors.lightGrey,
            ).paddingSymmetric(horizontal: 12),
            RichText(
                text: TextSpan(
                    text: "${plan.count}",
                    style: textStyle(28).copyWith(color: UiColors.darkBlue),
                    children: [
                  isSeller
                      ? TextSpan(
                          text: getTranslated("product/service", context),
                          style: textStyle(12))
                      : TextSpan(
                          text: getTranslated("Ad", context),
                          style: textStyle(12))
                ])),
            Divider(
              color: UiColors.lightGrey,
            ).paddingSymmetric(horizontal: 30),
            // 8.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated('duration', context),
                  style: textStyle(14).copyWith(color: UiColors.darkGrey),
                ),
                Text(
                  " ${plan.duration ?? "-"}" +
                      " " +
                      getTranslated("Days", context),
                  style: textStyle(14).copyWith(color: UiColors.darkGrey),
                ),
              ],
            ),
            8.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated("expiry", context).capitalize(),
                  style: textStyle(14).copyWith(color: UiColors.darkGrey),
                ),
                Text(
                  " ${plan.expiryDuration ?? "-"}" +
                      " " +
                      getTranslated("Days", context),
                  style: textStyle(14).copyWith(color: UiColors.darkGrey),
                ),
              ],
            ),

            17.height,

            Container(
              decoration: boxDecorationDefault(
                  color: UiColors.darkBlue,
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                getTranslated("Buy", context),
                style: textStyle(16).copyWith(color: UiColors.white),
              ),
            ).onTap((() async {
              isSeller
                  ? await ref
                      .read(subscribePlanProvider.notifier)
                      .becomeASeller(
                          planId: plan.id ?? 0,
                          isDefault: plan.is_default == 1,
                          context: context)
                  : await ref.read(subscribePlanProvider.notifier).subscribe(
                      planId: plan.id ?? 0,
                      isDefault: plan.is_default == 1,
                      context: context);
            })),
            14.height
          ],
        ),
      ),
    );
  }
}

class MyPlanWidgetNew extends ConsumerWidget {
  const MyPlanWidgetNew({
    super.key,
    required this.plan,
    this.isSeller = false,
  });

  final bool isSeller;
  final PlanModel plan;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Badge(
      // smallSize: 22,
      largeSize: 18,
      textStyle: textStyle(13),
      offset: const Offset(-8, -4),
      isLabelVisible: (plan.discount ?? 0) > 0,
      padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
      label: Text(
        "%${plan.discount ?? ""}",
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        margin: EdgeInsets.symmetric(horizontal: 6),
        decoration: boxDecorationDefault(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 5, // Blur radius
                offset: Offset(4, 4), // Offset in x and y direction
              ),
            ],
            color: UiColors.bgBlue,
            border: Border.all(color: UiColors.borderBlue)),
        // height: 220,
        width: 165,
        child: Column(
          children: [
            18.height,
            // Divider(),
            Row(
              children: [
                Text(
                  "${plan.name}".capitalize(),
                  style: textStyle(19).copyWith(
                      color: UiColors.darkBlue, fontWeight: FontWeight.normal),
                ),
              ],
            ),
            5.height,
            Divider(
              color: UiColors.lightGrey,
            ).paddingSymmetric(horizontal: 30),
            RichText(
                text: TextSpan(
                    text: "${plan.price}",
                    style: textStyle(28).copyWith(color: UiColors.darkBlue),
                    children: [TextSpan(text: "OMR", style: textStyle(12))])),
            Divider(
              color: UiColors.lightGrey,
            ).paddingSymmetric(horizontal: 12),
            RichText(
                text: TextSpan(
                    text: "${plan.count}",
                    style: textStyle(28).copyWith(color: UiColors.darkBlue),
                    children: [
                  TextSpan(
                      text: getTranslated("Ad", context), style: textStyle(12))
                ])),
            Divider(
              color: UiColors.lightGrey,
            ).paddingSymmetric(horizontal: 30),
            // 8.height,

            8.height,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getTranslated("Remaining", context).capitalize(),
                  style: textStyle(14).copyWith(color: UiColors.darkGrey),
                ),
                Text(
                  "${(plan.count ?? 0.00)}/${(plan.totalCount ?? 15)}" +
                      " " +
                      getTranslated("Ad", context),
                  style: textStyle(14).copyWith(color: UiColors.darkGrey),
                ),
              ],
            ),
            8.height,
            SizedBox(
              width: 120,
              child: LinearProgressIndicator(
                borderRadius: BorderRadius.circular(12),
                value: (plan.count ?? 0.00) / (plan.totalCount ?? 15),
                backgroundColor: UiColors.white,
                color: UiColors.secondary,
              ),
            ),

            17.height,
            // isHistory
            //     ? Container(
            //         decoration: boxDecorationDefault(
            //             color: UiColors.lightGrey,
            //             boxShadow: [],
            //             borderRadius: BorderRadius.circular(4)),
            //         padding:
            //             const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            //         child: Text(
            //           getTranslated("Renew", context),
            //           style: textStyle(16).copyWith(color: UiColors.white),
            //         ),
            //       )
            //     :
            Container(
              decoration: boxDecorationDefault(
                  color: UiColors.darkBlue,
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Text(
                getTranslated("Renew", context),
                style: textStyle(16).copyWith(color: UiColors.white),
              ),
            ).onTap((() async {
              isSeller
                  ? await ref
                      .read(subscribePlanProvider.notifier)
                      .becomeASeller(
                          planId: plan.id ?? 0,
                          isDefault: plan.is_default == 1,
                          context: context)
                  : await ref.read(subscribePlanProvider.notifier).subscribe(
                      planId: plan.id ?? 0,
                      isDefault: plan.is_default == 1,
                      context: context);
            })),
            14.height
          ],
        ),
      ),
    );
  }
}
