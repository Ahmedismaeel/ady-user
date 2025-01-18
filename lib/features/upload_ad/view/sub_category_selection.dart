import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/selected_cateogry_provider.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/category_fields_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/sub_sub_category_selection.dart';
// import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_ad_category.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/helper/text_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class SubCategoryListWidget extends ConsumerWidget {
  final List<SubCategory> list;
  const SubCategoryListWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select SubCategory".translate(context),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext _, int index) {
            final category = list[index];
            return Container(
              decoration: boxDecorationDefault(),
              child: Row(
                children: [
                  CacheImage(
                      height: 80,
                      width: 80,
                      image: category.iconFullUrl?.path ?? "",
                      radius: 12),
                  12.width,
                  Text(category.name.s)
                ],
              ),
            ).paddingBottom(8).onTap(() async {
              ref.read(subcategoryIdProvider.notifier).setCategoryId(category);
              SmartDialog.showLoading();
              await ref.watch(getCategoryFieldsProvider.future);
              SmartDialog.dismiss();
              SubSubCategoryListWidget(
                list: category.subSubCategories ?? [],
              ).launch(context);
            });
          },
        ),
      ),
    );
  }
}
