import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/filter_page_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/sort_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_new_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/latest_product_home_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class LatestPage extends ConsumerStatefulWidget {
  final BaseCategory type;
  const LatestPage({super.key, required this.type});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LatestPageState();
}

class _LatestPageState extends ConsumerState<LatestPage> {
  static const _pageSize = 10;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    afterBuildCreated(() {
      ref
          .read(filterDataProvider.notifier)
          .updateCategory(switch (widget.type) {
            // TODO: Handle this case.
            BaseCategory.auto =>
              ref.watch(categoryListProvider).asData!.value[2],
            // TODO: Handle this case.
            BaseCategory.realState =>
              ref.watch(categoryListProvider).asData!.value[3],
            // TODO: Handle this case.
            BaseCategory.service =>
              ref.watch(categoryListProvider).asData!.value[1],
            // TODO: Handle this case.
            BaseCategory.product =>
              ref.watch(categoryListProvider).asData!.value[0],
            // TODO: Handle this case.
            BaseCategory.eProduct =>
              ref.watch(categoryListProvider).asData!.value[0],
            // TODO: Handle this case.
            BaseCategory.eService =>
              ref.watch(categoryListProvider).asData!.value[1],
          });
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    super.initState();
  }

  FilterRequest getBody() {
    switch (widget.type) {
      case BaseCategory.auto:
        return FilterRequest(categoryId: 1, productType: ['ad']);
      case BaseCategory.realState:
        return FilterRequest(categoryId: 2, productType: ['ad']);
      case BaseCategory.product:
        return FilterRequest(categoryId: 3, productType: ['ad']);
      case BaseCategory.service:
        return FilterRequest(categoryId: 4, productType: ['ad']);

      case BaseCategory.eProduct:
        return FilterRequest(
            categoryId: 3, productType: ["physical", "digital"]);
      case BaseCategory.eService:
        return FilterRequest(
            categoryId: 4, productType: ["physical", "digital"]);
    }
  }

  _fetchPage(int pageKey) async {
    "${ref.read(filterDataProvider.notifier).getData().copyWith(productType: getBody().productType, categoryId: getBody().categoryId, governorateId: ref.watch(governorateHelperProvider)?.id, wilyaId: ref.watch(wilayatHelperProvider)?.id, limit: _pageSize, offset: pageKey)}"
        .log();
    try {
      final filterResponse = await AppConstants.searchAd.get(
          fromJson: FilterResponse.fromJson,
          data: ref.read(filterDataProvider.notifier).getData().copyWith(
              productType: getBody().productType,
              categoryId: getBody().categoryId,
              governorateId: ref.watch(governorateHelperProvider)?.id,
              wilyaId: ref.watch(wilayatHelperProvider)?.id,
              limit: _pageSize,
              offset: pageKey));
      // final filterResponse = await AppConstants.searchAd.get(
      //     fromJson: FilterResponse.fromJson,
      //     data: getBody().copyWith(limit: _pageSize, offset: pageKey));
      final isLastPage = filterResponse.products.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(filterResponse.products);
      } else {
        final nextPageKey = pageKey + filterResponse.products.length;
        _pagingController.appendPage(filterResponse.products, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: switch (widget.type) {
            BaseCategory.auto => "Latest Ad’s for Auto".translate(context),
            BaseCategory.realState =>
              "Latest Ad’s for Real Estate".translate(context),
            BaseCategory.service =>
              "Latest Ad’s for Service".translate(context),
            BaseCategory.product =>
              "Latest Ad’s for products".translate(context),
            BaseCategory.eProduct => "Latest Products".translate(context),
            BaseCategory.eService => "Latest Service".translate(context),
          },
          showResetIcon: true,
          reset: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.filter_alt_outlined,
                  color: UiColors.darkBlue,
                ).onTap(() async {
                  await const FilterPageWidget(
                    hideCategory: true,
                  ).launch(context,
                      pageRouteAnimation: PageRouteAnimation.Fade);
                  _pagingController.refresh();
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.sort,
                  color: UiColors.darkBlue,
                ).onTap(() async {
                  await SmartDialog.show(
                      alignment: Alignment.bottomCenter,
                      animationType: SmartAnimationType.fade,
                      builder: (BuildContext _) {
                        return const SortWidget();
                      });
                  _pagingController.refresh();
                }),
              )
            ],
          )),
      body: BaseCategory.eProduct == widget.type ||
              BaseCategory.eService == widget.type
          ? Container(
              color: UiColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: ListView(
                children: [
                  PagedGridView<int, Product>(
                    showNewPageProgressIndicatorAsGridChild: false,
                    showNewPageErrorIndicatorAsGridChild: false,
                    showNoMoreItemsIndicatorAsGridChild: false,
                    pagingController: _pagingController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 130 / 218,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (context, item, index) => ProductWidget(
                              productModel: item,
                              productNameLine: 1,
                            ),
                        noItemsFoundIndicatorBuilder: (context) =>
                            Lottie.asset("assets/lottie/noData2.json")),
                  ),
                  50.height
                ],
              ),
            )
          : Container(
              color: UiColors.white,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: ListView(
                children: [
                  PagedGridView<int, Product>(
                    showNewPageProgressIndicatorAsGridChild: false,
                    showNewPageErrorIndicatorAsGridChild: false,
                    showNoMoreItemsIndicatorAsGridChild: false,
                    pagingController: _pagingController,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 130 / 218,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 5,
                      crossAxisCount: 2,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (context, item, index) =>
                            AdWidget(productModel: item),
                        noItemsFoundIndicatorBuilder: (context) =>
                            Lottie.asset("assets/lottie/noData2.json")),
                  ),
                  // PagedListView<int, Product>(
                  //   pagingController: _pagingController,
                  //   shrinkWrap: true,
                  //   physics: const NeverScrollableScrollPhysics(),
                  //   builderDelegate: PagedChildBuilderDelegate<Product>(
                  //       itemBuilder: (context, item, index) =>
                  //           AdWidget(productModel: item).paddingBottom(8),
                  //       noItemsFoundIndicatorBuilder: (context) =>
                  //           Lottie.asset("assets/lottie/noData2.json")),
                  // ),
                  50.height
                ],
              ),
            ),
    );
  }
}
