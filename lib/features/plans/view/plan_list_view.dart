import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/plan_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/subscribe_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/widget/new_plan_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class PlanListView extends ConsumerWidget {
  final int categoryId;
  final int type;
  const PlanListView({super.key, required this.categoryId, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // SharedPreferenceHelper.instance.getLang()?.log();
    // ref.listen(subscribePlanProvider, (p, next) {
    //   next.when(() {}, initial: () {}, loading: () {}, success: (s) {
    //     PaySubscriptionView(
    //       url: s,
    //     ).launch(context);
    //   }, failed: (e) {});
    // });
    return ProviderHelperWidget(
        function: (list) {
          return PlanListWidget(
            list: list,
          );
        },
        loadingShape: PlanListWidget(list: [
          PlanModel(),
          PlanModel(),
          PlanModel(),
        ]),
        errorWidget: (error) =>
            Lottie.asset("assets/lottie/failed.json", fit: BoxFit.contain),
        listener:
            ref.watch(planListProvider(categoryId: categoryId, type: type)));
  }
}

class PlanListWidget extends ConsumerWidget {
  final List<PlanModel> list;
  const PlanListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return list.isEmpty
        ? Lottie.asset("assets/lottie/noData2.json")
        : ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext _, int index) {
              final plan = list[index];
              return PlanWidgetNew(
                plan: plan,
                isRenew: true,
              ).paddingOnly(bottom: 12, right: 12);
            },
          );
  }
}

class PlanWidgetAll extends ConsumerWidget {
  const PlanWidgetAll({super.key, required this.plan, this.isSeller = false});

  final PlanModel plan;
  final bool isSeller;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        decoration: boxDecorationDefault(
            color: UiColors.bgBlue,
            // boxShadow: [],
            border: Border.all(color: UiColors.borderBlue),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${plan.name}".capitalizeEachWord(),
              textAlign: TextAlign.start,
              style: textStyle(30).copyWith(
                  color: UiColors.darkBlue, fontWeight: FontWeight.w500),
            ),
            12.height,

            Row(
              children: [
                Text(
                  "${plan.count}",
                  style: textStyle(28).copyWith(
                      color: UiColors.black, fontWeight: FontWeight.w500),
                ),
                4.width,
                Text(
                  "Ad".translate(context),
                  style: textStyle(16).copyWith(
                    color: UiColors.black,
                  ),
                )
              ],
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Duration".translate(context),
                  style: titleRegular.copyWith(color: ColorResources.black),
                ),
                Text(
                  " ${plan.duration}" + " " + "Days".translate(context),
                  style: titleRegular.copyWith(color: ColorResources.black),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expiry".translate(context),
                  style: textStyle(12),
                ),
                Text(
                  " ${plan.expiryDuration}" + " " + "Days".translate(context),
                  style: textStyle(12),
                ),
              ],
            ),
            const Spacer(),
            Container(
              decoration: boxDecorationDefault(
                  color: UiColors.darkBlue,
                  boxShadow: [],
                  borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${"Buy at ".translate(context)} ${plan.price} OMR",
                    style: textStyle(15).copyWith(color: ColorResources.white),
                  )
                ],
              ),
            ).onTap(() async {
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
            }),
            // onSuccess: (onSuccess) {
            //   PaySubscriptionView(
            //     url: onSuccess,
            //   ).launch(context);
            // },
            // onFailed: (onFailed) {})
          ],
        ));
  }
}
