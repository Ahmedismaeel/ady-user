import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/my_plan_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/subscribe_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';

import 'package:flutter_sixvalley_ecommerce/features/plans/view/plan_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/widget/new_plan_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
// import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:nb_utils/nb_utils.dart';

final sellerProvider = FutureProvider.family
    .autoDispose<List<PlanModel>, int>((ref, int id) async {
  List<PlanModel> list = await AppConstants.planListByType(id)
      .getList(fromJson: PlanModel.fromJson);

  // Sort the list to start with items where is_default is 1
  list.sort((a, b) => (b.is_default ?? 0).compareTo((a.is_default ?? 0)));

  return list;
});

class SellerPlansView extends ConsumerWidget {
  final bool showBackButton;
  const SellerPlansView({
    super.key,
    required this.showBackButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Seller Plans".translate(context),
        isBackButtonExist: showBackButton,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        child: RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(sellerProvider);
            },
            child: ProviderHelperWidget(
                function: (list) {
                  "${list}".log();
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      final plan = list[index];
                      return SellerPlanWidget(plan: plan);
                    },
                  );
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: ResponsiveHelper.isTab(context) ? 3 : 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 12,
                      childAspectRatio: (1 / 1.5),
                    ),
                    itemCount: list.length,
                    padding: const EdgeInsets.all(0),
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return PlanWidgetNew(
                        plan: list[index],
                        isRenew: true,
                        isSeller: true,
                      );

                      return PlanWidgetAll(
                        isSeller: true,
                        plan: list[index],
                      );
                    },
                  );
                },
                listener: ref.watch(sellerProvider(2)))

            // ListView(
            //   children: [

            //     24.height,
            //     Row(
            //       children: [
            //         Text(
            //           "Buy Plans for".translate(context),
            //           style: textStyle(16).copyWith(
            //               color: UiColors.black, fontWeight: FontWeight.bold),
            //         ),
            //         3.width,
            //         Text(
            //           categoryById(3),
            //           style: textStyle(16).copyWith(
            //               color: UiColors.darkBlue, fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ),
            //     12.height,
            //     const SizedBox(
            //       height: 270,
            //       child: PlanListView(
            //         categoryId: 3,
            //         type: 2,
            //       ),
            //     ),
            //     24.height,
            //     Row(
            //       children: [
            //         Text(
            //           "Buy Plans for".translate(context),
            //           style: textStyle(16).copyWith(
            //               color: UiColors.black, fontWeight: FontWeight.bold),
            //         ),
            //         3.width,
            //         Text(
            //           categoryById(4),
            //           style: textStyle(16).copyWith(
            //               color: UiColors.darkBlue, fontWeight: FontWeight.bold),
            //         ),
            //       ],
            //     ),
            //     12.height,
            //     const SizedBox(
            //       height: 270,
            //       child: PlanListView(
            //         categoryId: 4,
            //         type: 2,
            //       ),
            //     )
            //   ],
            // ),

            ),
      ),
    );
  }
}

class SellerPlanWidget extends StatelessWidget {
  const SellerPlanWidget({
    super.key,
    required this.plan,
  });

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12, left: 30, right: 30),
        decoration:
            boxDecorationDefault(color: UiColors.darkBlue, boxShadow: []),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                30.width,
                Text(
                  (plan.name ?? "Starter Plan").capitalizeEachWord(),
                  style: textStyle(24).copyWith(color: UiColors.white),
                ),
                plan.discount != null && (plan.discount ?? 0.00) > 0
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: UiColors.error,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${plan.discount}%",
                          style: textStyle(16).copyWith(color: UiColors.white),
                        ),
                      )
                    : 30.width,
              ],
            ),
            15.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                plan.discount != null && (plan.discount ?? 0.00) > 0
                    ? Text(
                        "${(plan.price! * 100) / (100 - plan.discount!)}",
                        style: textStyle(24).copyWith(
                            color: UiColors.white,
                            decoration: TextDecoration.lineThrough),
                      )
                    : SizedBox(),
                12.width,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text("OMR",
                    //     style: textStyle(12)
                    //         .copyWith(color: UiColors.white)),
                    // 3.width,
                    Text("${plan.price}",
                        style: textStyle(38).copyWith(color: UiColors.white)),
                    3.width,
                    Text(
                        plan.duration! == 30
                            ? "/Monthly".translate(context)
                            : plan.duration! == 365
                                ? "/Yearly".translate(context)
                                : plan.duration! == 14
                                    ? "/Two Weeks".translate(context)
                                    : "/Monthly".translate(context),
                        style: textStyle(14).copyWith(color: UiColors.white)),
                  ],
                ),
              ],
            ),
            12.height,
            RichText(
                text: TextSpan(
                    text: "${plan.count} ",
                    style: textStyle(28).copyWith(color: UiColors.white),
                    children: [
                  TextSpan(
                      text: getTranslated("product/service", context),
                      style: textStyle(12).copyWith(color: UiColors.white))
                ])),
            12.height,
            HtmlWidget(plan.description ?? "",
                    textStyle: TextStyle(color: UiColors.white))
                .paddingSymmetric(horizontal: 35),
            // Text(
            //   "${plan.description ?? ""}".translate(context),
            //   textAlign: TextAlign.justify,
            //   style: textStyle(14).copyWith(color: UiColors.white, height: 1.2),
            // ).paddingSymmetric(horizontal: 35),
            20.height,
            Consumer(builder: (context, ref, w) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: boxDecorationDefault(
                  color: UiColors.error,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("Subscribe".translate(context),
                    style: textStyle(16).copyWith(
                        color: UiColors.white, fontWeight: FontWeight.bold)),
              ).onTap(() async {
                await ref.read(subscribePlanProvider.notifier).becomeASeller(
                    planId: plan.id ?? 0,
                    isDefault: plan.is_default == 1,
                    context: context);
              });
            })
          ],
        ));
  }
}

class AdderPlanWidget extends StatelessWidget {
  const AdderPlanWidget({
    super.key,
    required this.plan,
  });

  final PlanModel plan;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 12, left: 30, right: 30),
        decoration:
            boxDecorationDefault(color: UiColors.darkBlue, boxShadow: []),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                30.width,
                Text(
                  (plan.name ?? "Starter Plan").capitalizeEachWord(),
                  style: textStyle(24).copyWith(color: UiColors.white),
                ),
                plan.discount != null && (plan.discount ?? 0.00) > 0
                    ? Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: UiColors.error,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          "${plan.discount}%",
                          style: textStyle(16).copyWith(color: UiColors.white),
                        ),
                      )
                    : 30.width,
              ],
            ),
            15.height,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                plan.discount != null && (plan.discount ?? 0.00) > 0
                    ? Text(
                        "${(plan.price! * 100) / (100 - plan.discount!)}",
                        style: textStyle(24).copyWith(
                            color: UiColors.white,
                            decoration: TextDecoration.lineThrough),
                      )
                    : SizedBox(),
                12.width,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Text("OMR",
                    //     style: textStyle(12)
                    //         .copyWith(color: UiColors.white)),
                    // 3.width,
                    Text("${plan.price}",
                        style: textStyle(38).copyWith(color: UiColors.white)),
                    3.width,
                    Text("OMR".translate(context),
                        style: textStyle(14).copyWith(color: UiColors.white)),
                  ],
                ),
              ],
            ),
            12.height,
            RichText(
                text: TextSpan(
                    text: "${plan.count} ",
                    style: textStyle(28).copyWith(color: UiColors.white),
                    children: [
                  TextSpan(
                      text: getTranslated("Ad", context),
                      style: textStyle(12).copyWith(color: UiColors.white))
                ])),
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslated("Usage Duration", context),
                    style: textStyle(12).copyWith(color: UiColors.white)),
                3.width,
                RichText(
                    text: TextSpan(
                        text: "${plan.expiryDuration} ",
                        style: textStyle(22).copyWith(color: UiColors.white),
                        children: [
                      TextSpan(
                          text: getTranslated("Days", context),
                          style: textStyle(12).copyWith(color: UiColors.white))
                    ])),
              ],
            ),
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(getTranslated("Expiry Duration", context),
                    style: textStyle(12).copyWith(color: UiColors.white)),
                3.width,
                RichText(
                    text: TextSpan(
                        text: "${plan.duration} ",
                        style: textStyle(22).copyWith(color: UiColors.white),
                        children: [
                      TextSpan(
                          text: getTranslated("Days", context),
                          style: textStyle(12).copyWith(color: UiColors.white))
                    ])),
              ],
            ),
            12.height,
            HtmlWidget(plan.description ?? "",
                textStyle: TextStyle(
                  color: UiColors.white,
                )).paddingSymmetric(horizontal: 35),
            // Text(
            //   "${plan.description ?? ""}".translate(context),
            //   textAlign: TextAlign.justify,
            //   style: textStyle(14).copyWith(color: UiColors.white, height: 1.2),
            // ).paddingSymmetric(horizontal: 35),
            20.height,
            Consumer(builder: (context, ref, w) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: boxDecorationDefault(
                  color: UiColors.error,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text("Buy".translate(context),
                    style: textStyle(16).copyWith(
                        color: UiColors.white, fontWeight: FontWeight.bold)),
              ).onTap(() async {
                await ref.read(subscribePlanProvider.notifier).subscribe(
                    planId: plan.id ?? 0,
                    isDefault: plan.is_default == 1,
                    context: context);
              });
            })
          ],
        ));
  }
}
