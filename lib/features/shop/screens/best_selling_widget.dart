import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nb_utils/nb_utils.dart';

final shopBestSellingProvider = FutureProvider.family
    .autoDispose<FilterResponse, int>((ref, int shopId) async {
  return await AppConstants.bestSellingVendor(shopId)
      .get(fromJson: FilterResponse.fromJson);
});

class BestSellingWidget extends ConsumerWidget {
  final int shopId;
  const BestSellingWidget({super.key, required this.shopId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderHelperWidget(
        function: (data) => GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: ResponsiveHelper.isTab(context) ? 3 : 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: (1 / 1.68),
              ),
              itemCount: data.products.length,
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(productModel: data.products[index])
                    .paddingAll(4);
              },
            ).paddingAll(12),
        listener: ref.watch(shopBestSellingProvider(shopId)));
  }
}
