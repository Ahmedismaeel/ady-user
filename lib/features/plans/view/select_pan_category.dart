import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widgets/category_home_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/plan_by_category_id_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectPlanCategory extends ConsumerWidget {
  const SelectPlanCategory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ProviderHelperWidget(
          function: (list) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return CategoryBaseWidget(
                  category: list[index],
                ).paddingOnly(bottom: 12).onTap(() {
                  CategoryPlansView(
                    categoryId: list[index].id ?? 0,
                  ).launch(
                    context,
                  );
                });
              },
            );
          },
          listener: ref.watch(categoryListProvider)),
    );
  }
}
