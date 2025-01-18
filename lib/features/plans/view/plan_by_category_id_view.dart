import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/plan_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/seller_plans_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/widget/new_plan_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';

class CategoryPlansView extends ConsumerWidget {
  final int categoryId;
  const CategoryPlansView({
    super.key,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "Select Plan".translate(context),
          isBackButtonExist: true,
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: ProviderHelperWidget(
            function: (list) {
              return ListView.builder(
                  itemCount: list.length,
                  padding: const EdgeInsets.all(0),
                  // shrinkWrap: true,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return AdderPlanWidget(
                      plan: list[index],

                      // isSeller: true,
                    );
                  });
            },
            listener:
                ref.watch(planListProvider(categoryId: categoryId, type: 1)),
          ),
        ));
  }
}
