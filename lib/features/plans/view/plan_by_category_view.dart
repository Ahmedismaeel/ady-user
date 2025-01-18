import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/plan_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:nb_utils/nb_utils.dart';

class PlanByCategoryView extends ConsumerWidget {
  final int categoryId;
  const PlanByCategoryView({required this.categoryId, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(title: "Select Plan".translate(context)),
      body: Container(
          child: Column(
        children: [
          12.height,
          SizedBox(
              height: 300, child: PlanListView(categoryId: categoryId, type: 1))
        ],
      )),
    );
  }
}
