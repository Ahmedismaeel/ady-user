import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/select_pan_category.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/widget/plan_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:nb_utils/nb_utils.dart';

class MyPlanView extends ConsumerWidget {
  final bool showBackButton;
  const MyPlanView({
    super.key,
    required this.showBackButton,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Plan".translate(context),
        isBackButtonExist: showBackButton,
      ),
      body: SelectPlanCategory(),
      // Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      //   child: RefreshIndicator(
      //     onRefresh: () async {
      //       ref.invalidate(myPlanListProvider);
      //     },
      //     child: ListView(
      //       children: [
      //         // Text("${SharedPreferenceHelper.instance.getToken()}"),
      //         12.height,
      //         Text(
      //           "Current Plans".translate(context),
      //           style: textStyle(16).copyWith(color: UiColors.darkBlue),
      //         ),
      //         12.height,
      //         ProviderHelperWidget(
      //           function: (list) {
      //             return MyPlanWidget(
      //               list: list,
      //             );
      //           },
      //           loadingShape: MyPlanWidget(
      //             list: [PlanModel(), PlanModel(), PlanModel()],
      //           ),
      //           listener: ref.watch(myPlanListProvider),
      //         ),
      //         24.height,
      //         Row(
      //           children: [
      //             Text(
      //               "Buy More Ads for".translate(context),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.black, fontWeight: FontWeight.bold),
      //             ),
      //             3.width,
      //             Text(
      //               categoryById(1),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.darkBlue, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //         12.height,
      //         const SizedBox(
      //           height: 270,
      //           child: PlanListView(
      //             categoryId: 1,
      //             type: 1,
      //           ),
      //         ),
      //         24.height,
      //         Row(
      //           children: [
      //             Text(
      //               "Buy More Ads for".translate(context),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.black, fontWeight: FontWeight.bold),
      //             ),
      //             3.width,
      //             Text(
      //               categoryById(2),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.darkBlue, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //         12.height,
      //         const SizedBox(
      //           height: 270,
      //           child: PlanListView(
      //             categoryId: 2,
      //             type: 1,
      //           ),
      //         ),
      //         24.height,
      //         Row(
      //           children: [
      //             Text(
      //               "Buy More Ads for".translate(context),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.black, fontWeight: FontWeight.bold),
      //             ),
      //             3.width,
      //             Text(
      //               categoryById(3),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.darkBlue, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //         12.height,
      //         const SizedBox(
      //           height: 270,
      //           child: PlanListView(
      //             categoryId: 3,
      //             type: 1,
      //           ),
      //         ),
      //         24.height,
      //         Row(
      //           children: [
      //             Text(
      //               "Buy More Ads for".translate(context),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.black, fontWeight: FontWeight.bold),
      //             ),
      //             3.width,
      //             Text(
      //               categoryById(4),
      //               style: textStyle(16).copyWith(
      //                   color: UiColors.darkBlue, fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //         12.height,
      //         const SizedBox(
      //           height: 270,
      //           child: PlanListView(
      //             categoryId: 4,
      //             type: 1,
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
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
    return SizedBox(
      height: 155,
      child: ListView.builder(
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          final plan = list[index];
          return PlanWidget(plan: plan).paddingOnly(bottom: 12, right: 12);
        },
      ),
    );
  }
}
