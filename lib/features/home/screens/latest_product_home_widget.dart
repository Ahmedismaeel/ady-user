import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/controller/latest_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/latest_page_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

enum BaseCategory { auto, realState, service, product, eProduct, eService }

class LatestSection extends ConsumerWidget {
  final BaseCategory type;
  final String title;
  const LatestSection({
    super.key,
    required this.title,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: textStyle(20).copyWith(
                  color: UiColors.darkBlue, fontWeight: FontWeight.normal),
            ).onTap(() async {
              final token = await FirebaseMessaging.instance.getToken();
              "${token}".log();
            }),
            Text(
              "View All".translate(context),
              style: textStyle(14).copyWith(
                  color: UiColors.darkBlue, fontWeight: FontWeight.bold),
            ).onTap(() {
              ref.read(filterDataProvider.notifier).clear();
              LatestPage(
                type: type,
              ).launch(context);
            })
          ],
        ),
        12.height,
        SizedBox(
            height: 270,
            //  BaseCategory.eProduct == type || BaseCategory.eService == type
            //     ? 186
            //     : 140,
            child: ProviderHelperWidget(
                function: (response) {
                  final products = response.products;
                  return Container(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        products.isEmpty
                            ? Lottie.asset("assets/lottie/noData2.json")
                            : ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemCount: products.length ?? 0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  final product = products[index];

                                  return SizedBox(
                                      width: 160,
                                      //  BaseCategory.eProduct == type ||
                                      //         BaseCategory.eService == type
                                      //     ? 140
                                      //     : 300,
                                      // height: 200,
                                      child: switch (type) {
                                        // TODO: Handle this case.
                                        BaseCategory.auto => AdWidget(
                                            productModel: product,
                                          ),
                                        // TODO: Handle this case.
                                        BaseCategory.realState => AdWidget(
                                            productModel: product,
                                          ),
                                        // TODO: Handle this case.
                                        BaseCategory.service => AdWidget(
                                            productModel: product,
                                          ),
                                        // TODO: Handle this case.
                                        BaseCategory.product => AdWidget(
                                            productModel: product,
                                          ),
                                        // TODO: Handle this case.
                                        BaseCategory.eProduct => ProductWidget(
                                            productModel: product,
                                            productNameLine: 1,
                                          ),
                                        // TODO: Handle this case.
                                        BaseCategory.eService => ProductWidget(
                                            productModel: product,
                                            productNameLine: 1,
                                          ),
                                      });
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return 12.width;
                                },
                              ),
                        // (products.length ?? 0) >= 10
                        (BaseCategory.eProduct == type ||
                                BaseCategory.eService == type)
                            ? 12.width
                            : 0.width,
                        (products.length ?? 0) >= 10
                            ? Container(
                                width: 100,
                                height: (BaseCategory.eProduct == type ||
                                        BaseCategory.eService == type)
                                    ? 186
                                    : 140,
                                margin: (BaseCategory.eProduct == type ||
                                        BaseCategory.eService == type)
                                    ? null
                                    : const EdgeInsets.all(
                                        Dimensions.paddingSizeExtraSmall),
                                decoration: boxDecorationDefault(
                                    boxShadow: [], color: UiColors.darkBlue),
                                child: Center(
                                  child: Text(
                                    "View All".translate(context),
                                    style: textStyle(20)
                                        .copyWith(color: UiColors.white),
                                  ),
                                ),
                              ).onTap(() {
                                ref.read(filterDataProvider.notifier).clear();
                                LatestPage(
                                  type: type,
                                ).launch(context);
                              })
                            : const SizedBox.shrink()
                      ],
                    ),
                  );
                },
                listener: switch (type) {
                  BaseCategory.auto => ref.watch(latestAutoAdsProvider),
                  BaseCategory.realState =>
                    ref.watch(latestRealStateAdsProvider),
                  BaseCategory.service => ref.watch(latestServiceAdsProvider),
                  BaseCategory.product => ref.watch(latestProductAdsProvider),
                  BaseCategory.eProduct => ref.watch(latestProductProvider),
                  BaseCategory.eService => ref.watch(latestServiceProvider),
                })),
      ],
    );
  }
}
