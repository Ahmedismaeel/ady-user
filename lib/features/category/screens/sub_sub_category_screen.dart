import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_result_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class SubSubCategoryScreen extends StatelessWidget {
  final SubCategory subCategory;
  const SubSubCategoryScreen({super.key, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "${subCategory.name}"),
      body: Consumer(builder: (context, ref, w) {
        return Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: GridView.builder(
              itemBuilder: (BuildContext context, int index) {
                final subSub = subCategory?.subSubCategories?[index];
                return Container(
                  decoration: boxDecorationDefault(color: UiColors.white),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
                  // margin:
                  //     const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 60,
                                child: Text('${subSub?.name}',
                                    style:
                                        textStyle(16).copyWith(height: 1.3))),
                            CacheImage(
                              image: "${subSub?.iconFullUrl?.path}",
                              width: 65,
                              height: 65,
                              radius: 10,
                            ),
                          ],
                        ),
                        2.height,
                      ],
                    ).onTap(() {
                      // SubSubCategoryScreen(
                      //   subCategory: sub!,
                      // ).launch(context,
                      //     pageRouteAnimation: PageRouteAnimation.Fade);

                      ref
                          .read(filterDataProvider.notifier)
                          .updateSubSubCategory(subSub);
                      const SearchResultView(
                        // pageIndex: 2,
                        searchText: null,
                      ).launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                    }),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isTab(context) ? 3 : 2,
                crossAxisSpacing: 7,
                mainAxisSpacing: 12,
                childAspectRatio: (1.84 / 1),
              ),
              itemCount: subCategory.subSubCategories?.length ?? 0,
              padding: const EdgeInsets.all(0),
            ));
      }),
    );
  }
}
