import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/domain/models/seller_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/best_selling_widget.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/controllers/coupon_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_filter_dialog_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/search_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/overview_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/shop_info_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/shop_product_view_list.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class TopSellerProductScreen extends StatefulWidget {
  final int? sellerId;

  final bool fromMore;

  const TopSellerProductScreen(
      {super.key, this.sellerId, this.fromMore = false});

  @override
  State<TopSellerProductScreen> createState() => _TopSellerProductScreenState();
}

class _TopSellerProductScreenState extends State<TopSellerProductScreen>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  TextEditingController searchController = TextEditingController();
  bool vacationIsOn = false;
  TabController? _tabController;
  int selectedIndex = 0;

  void _load() async {
    await Provider.of<SellerProductController>(context, listen: false)
        .getSellerProductList(widget.sellerId.toString(), 1, "");
    await Provider.of<ShopController>(Get.context!, listen: false)
        .getSellerInfo(widget.sellerId.toString());
    await Provider.of<SellerProductController>(Get.context!, listen: false)
        .getSellerWiseBestSellingProductList(widget.sellerId.toString(), 1);
    await Provider.of<SellerProductController>(Get.context!, listen: false)
        .getSellerWiseFeaturedProductList(widget.sellerId.toString(), 1);
    await Provider.of<SellerProductController>(Get.context!, listen: false)
        .getSellerWiseRecommandedProductList(widget.sellerId.toString(), 1);
    await Provider.of<CouponController>(Get.context!, listen: false)
        .getSellerWiseCouponList(widget.sellerId!, 1);
    await Provider.of<CategoryController>(Get.context!, listen: false)
        .getSellerWiseCategoryList(widget.sellerId!);
    await Provider.of<BrandController>(Get.context!, listen: false)
        .getSellerWiseBrandList(widget.sellerId!);
  }

  @override
  void initState() {
    super.initState();
    if (widget.fromMore) {
      Provider.of<ShopController>(context, listen: false)
          .setMenuItemIndex(1, notify: false);
    } else {
      Provider.of<ShopController>(context, listen: false)
          .setMenuItemIndex(0, notify: false);
    }

    searchController.clear();
    _load();
    if (widget.fromMore) {
      _tabController = TabController(length: 3, initialIndex: 1, vsync: this);
    } else {
      _tabController = TabController(length: 3, initialIndex: 0, vsync: this);
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.vacationEndDate != null) {
    //   DateTime vacationDate = DateTime.parse(widget.vacationEndDate!);
    //   DateTime vacationStartDate = DateTime.parse(widget.vacationStartDate!);
    //   final today = DateTime.now();
    //   final difference = vacationDate.difference(today).inDays;
    //   final startDate = vacationStartDate.difference(today).inDays;

    //   if (difference >= 0 && widget.vacationStatus! && startDate <= 0) {
    //     vacationIsOn = true;
    //   } else {
    //     vacationIsOn = false;
    //   }
    // }

    return PopScope(
      canPop: true,
      onPopInvoked: (value) {
        Provider.of<SellerProductController>(context, listen: false)
            .clearSellerProducts();
        Provider.of<CategoryController>(Get.context!, listen: false)
            .emptyCategory();
        Provider.of<CategoryController>(Get.context!, listen: false)
            .getCategoryList(true);
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar(
            title: Provider.of<ShopController>(context, listen: true)
                    .sellerInfoModel
                    ?.seller
                    ?.shop
                    ?.name ??
                "Shop",
            showActionButton: true,
            showResetIcon: true,
            reset: Icon(Icons.share_outlined,
                    size: 24, color: Theme.of(context).primaryColor)
                .onTap(() {
              Share.share(
                  '${getTranslated('hey', context)}! ${getTranslated('check_out_this', context)} ${getTranslated('at', context)} ${AppConstants.baseUrl}?id=${widget.sellerId}&type=shop');
            }).paddingSymmetric(horizontal: 12),
          ),
          body: Consumer<ShopController>(builder: (context, sellerProvider, _) {
            return CustomScrollView(controller: _scrollController, slivers: [
              SliverToBoxAdapter(
                  child: Column(
                children: [
                  ShopInfoWidget(
                      crNumber:
                          "${sellerProvider.sellerInfoModel?.seller?.shop?.crNumber ?? ""}",
                      socialMedia:
                          "${sellerProvider.sellerInfoModel?.seller?.shop?.socialMedia ?? ""}",
                      description:
                          "${sellerProvider.sellerInfoModel?.seller?.shop?.description ?? ""}",
                      vacationIsOn: vacationIsOn,
                      sellerName:
                          sellerProvider.sellerInfoModel?.seller?.shop?.name ??
                              "",
                      sellerId: widget.sellerId!,
                      banner: sellerProvider
                              .sellerInfoModel?.seller?.shop?.banner ??
                          '',
                      shopImage:
                          sellerProvider.sellerInfoModel?.seller?.shop?.image ??
                              '',
                      temporaryClose: sellerProvider
                              .sellerInfoModel?.seller?.shop?.temporaryClose ??
                          false),
                ],
              )),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                      height: sellerProvider.shopMenuIndex == 1 ||
                              sellerProvider.shopMenuIndex == 2
                          ? 110
                          : 50,
                      child: Container(
                          color: Theme.of(context).canvasColor,
                          child: Column(children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //   child: Container(
                                  //     height: 40,
                                  //     color: Theme.of(context).canvasColor,
                                  //     child: TabBar(
                                  //       // physics:
                                  //       //     const NeverScrollableScrollPhysics(),
                                  //       // isScrollable: true,
                                  //       dividerColor: Colors.transparent,
                                  //       // padding: const EdgeInsets.all(0),
                                  //       controller: _tabController,
                                  //       labelColor:
                                  //           Theme.of(context).primaryColor,
                                  //       unselectedLabelColor:
                                  //           Theme.of(context).hintColor,
                                  //       indicatorColor:
                                  //           Theme.of(context).primaryColor,
                                  //       indicatorWeight: 1,
                                  //       onTap: (value) {
                                  //         sellerProvider
                                  //             .setMenuItemIndex(value);
                                  //         searchController.clear();
                                  //       },
                                  //       indicatorPadding:
                                  //           const EdgeInsets.symmetric(
                                  //               horizontal: Dimensions
                                  //                   .paddingSizeDefault),
                                  //       unselectedLabelStyle:
                                  //           textRegular.copyWith(
                                  //               fontSize: 14,
                                  //               fontWeight: FontWeight.w400),
                                  //       labelStyle: textRegular.copyWith(
                                  //           fontSize: 14,
                                  //           fontWeight: FontWeight.w700),
                                  //       tabs: [
                                  //         Tab(
                                  //             text: getTranslated(
                                  //                 "overview", context)),
                                  //         Tab(
                                  //             text: getTranslated(
                                  //                 "all_products", context)),
                                  //         Tab(
                                  //           text: "best_selling"
                                  //               .translate(context),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),

                                  Expanded(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child:
                                            CustomSlidingSegmentedControl<int>(
                                          // key: UniqueKey(),
                                          padding: 7,
                                          fromMax: true,
                                          children: {
                                            0: Text(
                                              "overview".translate(context),
                                              textAlign: TextAlign.center,
                                              style: textStyle(15).copyWith(
                                                  color: sellerProvider
                                                              .shopMenuIndex ==
                                                          0
                                                      ? UiColors.white
                                                      : UiColors.medGrey),
                                            ),
                                            1: Text(
                                              categoryById(3),
                                              textAlign: TextAlign.center,
                                              style: textStyle(15).copyWith(
                                                  color: sellerProvider
                                                              .shopMenuIndex ==
                                                          1
                                                      ? UiColors.white
                                                      : UiColors.medGrey),
                                            ),
                                            2: Text(
                                              categoryById(4),
                                              textAlign: TextAlign.center,
                                              style: textStyle(15).copyWith(
                                                  color: sellerProvider
                                                              .shopMenuIndex ==
                                                          2
                                                      ? UiColors.white
                                                      : UiColors.medGrey),
                                            ),
                                          },
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(16),
                                          ),
                                          thumbDecoration: BoxDecoration(
                                            color: UiColors.darkBlue,
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            boxShadow: [
                                              // BoxShadow(
                                              //   color: Colors.black.withOpacity(.3),
                                              //   blurRadius: 4.0,
                                              //   spreadRadius: 1.0,
                                              //   offset: const Offset(
                                              //     0.0,
                                              //     2.0,
                                              //   ),
                                              // ),
                                            ],
                                          ),
                                          onValueChanged: (int value) {
                                            print(value);
                                            sellerProvider
                                                .setMenuItemIndex(value);
                                            // setPage(value);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),

                                  // if (sellerProvider.shopMenuIndex == 1)
                                  //   Padding(
                                  //       padding: EdgeInsets.only(
                                  //           right: Provider.of<LocalizationController>(context,
                                  //                       listen: false)
                                  //                   .isLtr
                                  //               ? Dimensions.paddingSizeDefault
                                  //               : 0,
                                  //           left: Provider.of<LocalizationController>(
                                  //                       context,
                                  //                       listen: false)
                                  //                   .isLtr
                                  //               ? 0
                                  //               : Dimensions
                                  //                   .paddingSizeDefault),
                                  //       child: InkWell(
                                  //           onTap: () => showModalBottomSheet(
                                  //               context: context,
                                  //               isScrollControlled: true,
                                  //               backgroundColor: Colors.transparent,
                                  //               builder: (c) => ProductFilterDialog(sellerId: widget.sellerId!)),
                                  //           child: Container(decoration: BoxDecoration(color: Provider.of<ThemeController>(context, listen: false).darkTheme ? Colors.white : Theme.of(context).cardColor, border: Border.all(color: Theme.of(context).primaryColor.withOpacity(.5)), borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)), width: 30, height: 30, child: Padding(padding: const EdgeInsets.all(5.0), child: Image.asset(Images.filterImage)))))
                                ]),
                            if (sellerProvider.shopMenuIndex == 1 ||
                                sellerProvider.shopMenuIndex == 2)
                              Container(
                                  color: Theme.of(context).canvasColor,
                                  child: SearchWidget(
                                      hintText:
                                          getTranslated('search_hint', context),
                                      sellerId: widget.sellerId!))
                          ])))),
              SliverToBoxAdapter(
                child: switch (sellerProvider.shopMenuIndex) {
                  0 => ShopOverviewScreen(
                      sellerId: widget.sellerId!,
                      scrollController: _scrollController,
                    ),

                  // 0 => BestSellingWidget(
                  //     shopId: widget.sellerId!,
                  //   ),
                  1 => Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeSmall,
                          0),
                      child: ShopProductViewList(
                          key: UniqueKey(),
                          categoryId: 3,
                          scrollController: _scrollController,
                          sellerId: widget.sellerId!)),
                  2 => Padding(
                      padding: const EdgeInsets.fromLTRB(
                          Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeSmall,
                          Dimensions.paddingSizeSmall,
                          0),
                      child: ShopProductViewList(
                          key: UniqueKey(),
                          categoryId: 4,
                          scrollController: _scrollController,
                          sellerId: widget.sellerId!)),

                  // TODO: Handle this case.
                  int() => SizedBox(),
                },
              )
            ]);
          })),
    );
  }
}
