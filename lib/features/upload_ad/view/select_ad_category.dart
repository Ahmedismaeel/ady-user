import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widgets/category_home_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/create_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/selected_cateogry_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_parent_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_plan_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/sub_category_selection.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';

import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectAddCategory extends ConsumerStatefulWidget {
  const SelectAddCategory({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SelectAddCategoryState();
}

class _SelectAddCategoryState extends ConsumerState<SelectAddCategory> {
  @override
  void initState() {
    afterBuildCreated(() async {
      LocationPermission permission = await Geolocator.requestPermission();
      Position data = await Geolocator.getCurrentPosition();

      ref
          .read(locationAdProvider.notifier)
          .save(latitude: data.latitude, longitude: data.longitude);
      ref.read(saveHelperProvider.notifier).clear();
      ref.read(parentProvider.notifier).clear();
      ref.read(fieldCounterProvider.notifier).reset();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select Your Category".translate(context),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ProviderHelperWidget(
            function: (list) {
              return CategoryListWidget(list: list);
            },
            loadingShape:
                CategoryListWidget(list: [CategoryModel(), CategoryModel()]),
            listener: ref.watch(categoryListProvider)),
      ),
    );
  }
}

class CategoryListWidget extends ConsumerWidget {
  final List<CategoryModel> list;
  const CategoryListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context, ref) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (BuildContext _, int index) {
        final category = list[index];
        return CategoryBaseWidget(
          category: category,
        ).paddingBottom(8).onTap(() async {
          ref.read(categoryIdProvider.notifier).setCategoryId(category);
          // final plan = await SelectPlanView(
          //         categoryId: ref.watch(categoryIdProvider).id ?? 0)
          //     .launch(context);

          // PlanModel? plan = await Navigator.of(context).push(MaterialPageRoute(
          //     builder: (BuildContext context) => SelectPlanView(
          //         categoryId: ref.watch(categoryIdProvider).id ?? 0)));
          // if (plan != null) {
          //   "${plan.toJson()}".log();
          //
          //   ref.read(planSelectionProvider.notifier).save(plan.id ?? 0);

            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SubCategoryListWidget(
                      list: category.subCategories ?? [],
                    )));
          // }
          //else {
          //   showCustomSnackBar('Please select a plan first', context,
          //       isToaster: true);
          // }
        });
      },
    );
  }
}
