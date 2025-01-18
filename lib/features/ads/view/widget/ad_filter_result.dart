import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/add_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/filter_page_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class AdsFilterWidget extends ConsumerStatefulWidget {
  final String? search;
  const AdsFilterWidget({super.key, required this.search});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdsFilterWidgetState();
}

class _AdsFilterWidgetState extends ConsumerState<AdsFilterWidget> {
  static const _pageSize = 10;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  _fetchPage(int pageKey) async {
    try {
      final filterResponse = await AppConstants.searchAd.get(
          fromJson: FilterResponse.fromJson,
          data: ref.read(filterDataProvider.notifier).getData().copyWith(
              productType: ['ad'],
              name: widget.search,
              governorateId: ref.watch(governorateHelperProvider)?.id,
              wilyaId: ref.watch(wilayatHelperProvider)?.id,
              limit: _pageSize,
              offset: pageKey));
      final isLastPage = filterResponse.products.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(filterResponse.products);
      } else {
        final nextPageKey = pageKey + filterResponse.products.length;
        _pagingController.appendPage(filterResponse.products, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
      // ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> $error".log();
    }
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Container(
            color: UiColors.white,
            padding: const EdgeInsets.only(top: 60, right: 12, left: 12),
            child: ListView(
              children: [
                // Text("${_pagingController.itemList?.length}"),
                // _pagingController.itemList?.isEmpty == true ||
                //         _pagingController.itemList == null
                //     ? Lottie.asset("assets/lottie/noData2.json")
                //     :
                // PagedListView<int, Product>(
                //   pagingController: _pagingController,
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   builderDelegate: PagedChildBuilderDelegate<Product>(
                //       itemBuilder: (context, item, index) =>
                //           AdWidget(productModel: item).paddingBottom(2),
                //       noItemsFoundIndicatorBuilder: (context) =>
                //           Lottie.asset("assets/lottie/noData2.json")),
                // ),
                PagedGridView<int, Product>(
                  showNewPageProgressIndicatorAsGridChild: false,
                  showNewPageErrorIndicatorAsGridChild: false,
                  showNoMoreItemsIndicatorAsGridChild: false,
                  pagingController: _pagingController,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 120 / 200,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    crossAxisCount: 2,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  builderDelegate: PagedChildBuilderDelegate<Product>(
                      itemBuilder: (context, item, index) => AdWidget(
                            productModel: item,
                            productNameLine: 1,
                          ),
                      noItemsFoundIndicatorBuilder: (context) =>
                          Lottie.asset("assets/lottie/noData2.json")),
                ),
                50.height
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: boxDecorationDefault(
                    color: Colors.transparent, boxShadow: []),
                padding: const EdgeInsets.all(8.0),
                child: Row(children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                      // color:
                      //           borderColor: Color(0xFF009444),
                      //           textColor: Color(0xFF009444),
                      decoration: boxDecorationDefault(
                          color: UiColors.extraLightGrey,
                          boxShadow: [],
                          borderRadius: BorderRadius.circular(90)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 9),
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.filter_alt,
                              size: 20, color: UiColors.darkGrey),
                          2.width,
                          Text(
                            "filter".translate(context),
                            style: textStyle(14)
                                .copyWith(color: UiColors.darkGrey),
                          ),
                          2.width
                        ],
                      ).paddingRight(2),
                    ).onTap(() async {
                      await const FilterPageWidget().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade);
                      _pagingController.refresh();
                    }),
                  ),
                  Flexible(
                    flex: 6,
                    child: ProviderHelperWidget(
                        function: (categoryList) {
                          final selectedCategory =
                              ref.watch(filterDataProvider).categoryId;
                          return SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  decoration: boxDecorationDefault(
                                      color: selectedCategory == null
                                          ? UiColors.darkBlue
                                          : UiColors.extraLightGrey,
                                      // boxShadow: [],
                                      borderRadius: BorderRadius.circular(90)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 11),
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 3),
                                  child: Text("all".translate(context),
                                      style: textStyle(14).copyWith(
                                          color: selectedCategory == null
                                              ? UiColors.white
                                              : UiColors.medGrey)),
                                ).onTap(() {
                                  ref
                                      .read(filterDataProvider.notifier)
                                      .updateCategory(null);
                                  _pagingController.refresh();
                                }),
                                for (var element in categoryList)
                                  Container(
                                    decoration: boxDecorationDefault(
                                        color:
                                            selectedCategory?.id == element.id
                                                ? UiColors.darkBlue
                                                : UiColors.extraLightGrey,
                                        // boxShadow: [],
                                        borderRadius:
                                            BorderRadius.circular(90)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 11),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: Text("${element.name}",
                                        style: textStyle(14).copyWith(
                                            color: selectedCategory?.id ==
                                                    element.id
                                                ? UiColors.white
                                                : UiColors.medGrey)),
                                  ).onTap(() {
                                    ref
                                        .read(filterDataProvider.notifier)
                                        .updateCategory(element);
                                    _pagingController.refresh();
                                  })
                              ],
                            ),
                          );
                        },
                        listener: ref.watch(categoryListProvider)),
                  )
                ]),
              )
            ],
          )
        ],
      );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
