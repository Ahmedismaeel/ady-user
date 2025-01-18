import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/my_plan_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/plan_by_category_id_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/plan_by_category_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectPlanView extends ConsumerWidget {
  final int categoryId;
  const SelectPlanView({super.key, required this.categoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PlanModel> getListByCategory(List<PlanModel> list) {
      try {
        final byCategoryList = list
            .where((element) =>
                (element.categoryId == categoryId || element.categoryId == 0)
                    ? true
                    : false)
            .toList();
        return byCategoryList;
      } catch (e) {
        return [];
      }
    }

    return Scaffold(
      floatingActionButton: Container(
        decoration: boxDecorationDefault(
            borderRadius: BorderRadius.circular(12), color: UiColors.secondary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              size: 30,
              color: UiColors.white,
            ),
            // Text(
            //   "Subscribe New Plan",
            //   style: textStyle(16).copyWith(color: UiColors.white),
            // ),
          ],
        ),
      ).onTap(() async {
        await CategoryPlansView(
          categoryId: categoryId,
        ).launch(context);

        ref.invalidate(myPlanListProvider);
        // CustomDialog.dialog(context,
        //     widget: Container(
        //       height: context.height() * 0.4,
        //       child: PlanListView(
        //         categoryId: categoryId,
        //         type: 1,
        //       ),
        //     ));
      }),
      appBar: CustomAppBar(title: "Select Plan".translate(context)),
      body: ProviderHelperWidget(
        function: (list) {
          return MyPlanWidget(
            list: getListByCategory(list),
          );
        },
        loadingShape: MyPlanWidget(
          list: [PlanModel(), PlanModel(), PlanModel()],
        ),
        listener: ref.watch(myPlanListProvider),
      ),
    );
  }
}

class MyPlanWidget extends StatelessWidget {
  final List<PlanModel> list;
  const MyPlanWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (BuildContext context, int index) {
        final plan = list[index];
        return Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration:
                boxDecorationDefault(color: UiColors.darkBlue, boxShadow: []),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "${plan.name ?? "Starter Plan"}",
                            style:
                                textStyle(20).copyWith(color: UiColors.white),
                          ),
                        ],
                      ),
                      12.height,
                      SizedBox(
                        width: 120,
                        // height: 10,
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
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "${(plan.count ?? 0.00)}/${((plan.totalCount ?? 15) == 0 ? 15 : (plan.totalCount ?? 15))}",
                            style:
                                textStyle(16).copyWith(color: UiColors.white),
                          ),
                        ],
                      ),
                      7.height,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Ads Remaining",
                            style:
                                textStyle(16).copyWith(color: UiColors.white),
                          ),
                        ],
                      )
                    ],
                  )
                  // 12.height,
                ])).onTap(() {
          Navigator.pop(context, plan);
        });
      },
    );
  }
}
