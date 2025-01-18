import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/controllers/address_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_ad_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/controllers/banner_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/banner/widgets/banners_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/brand/controllers/brand_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/controllers/cart_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/screens/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/widgets/category_home_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/featured_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/controller/latest_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/drawer_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/latest_product_home_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/announcement_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/search_home_page_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/controllers/notification_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/screens/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/domain/models/config_model.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static Future<void> loadData(bool reload) async {
    await Provider.of<FlashDealController>(Get.context!, listen: false)
        .getFlashDealList(reload, false);
    await Provider.of<ShopController>(Get.context!, listen: false)
        .getTopSellerList(reload, 1, type: "top");
    Provider.of<BannerController>(Get.context!, listen: false)
        .getBannerList(reload);
    Provider.of<CategoryController>(Get.context!, listen: false)
        .getCategoryList(reload);
    Provider.of<AddressController>(Get.context!, listen: false)
        .getAddressList();
    await Provider.of<CartController>(Get.context!, listen: false)
        .getCartData(Get.context!);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getHomeCategoryProductList(reload);
    // await Provider.of<BrandController>(Get.context!, listen: false)
    //     .getBrandList(reload);
    await Provider.of<ProductController>(Get.context!, listen: false)
        .getLatestProductList(1, reload: reload);
    // await Provider.of<ProductController>(Get.context!, listen: false)
    //     .getFeaturedProductList('1', reload: reload);
    // await Provider.of<FeaturedDealController>(Get.context!, listen: false)
    //     .getFeaturedDealList(reload);
    // await Provider.of<ProductController>(Get.context!, listen: false)
    //     .getLProductList('1', reload: reload);
    // await Provider.of<ProductController>(Get.context!, listen: false)
    //     .getRecommendedProduct();
    await Provider.of<NotificationController>(Get.context!, listen: false)
        .getNotificationList(1);
    if (Provider.of<AuthController>(Get.context!, listen: false).isLoggedIn()) {
      await Provider.of<ProfileController>(Get.context!, listen: false)
          .getUserInfo(Get.context!);
    }
  }
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    singleVendor = Provider.of<SplashController>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final ConfigModel? configModel =
        Provider.of<SplashController>(context, listen: false).configModel;

    List<String?> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context),
      getTranslated('discounted_product', context)
    ];

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: UiColors.bgBlue,
      resizeToAvoidBottomInset: false,
      // drawer: DrawerView(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await HomePage.loadData(true);
            homeRef.invalidate(latestAutoAdsProvider);
            homeRef.invalidate(latestRealStateAdsProvider);
            homeRef.invalidate(latestServiceAdsProvider);
            homeRef.invalidate(latestProductAdsProvider);
            homeRef.invalidate(latestProductProvider);
            homeRef.invalidate(latestServiceProvider);
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                leadingWidth: 150,
                leading: Container(
                  // color: UiColors.bgRed,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // 12.height,
                      Text(
                        "Welcome".translate(context),
                        style: textStyle(14).copyWith(color: UiColors.black),
                      ),
                      2.height,
                      Consumer<ProfileController>(
                          builder: (context, profile, _) {
                        return Text(
                            Provider.of<AuthController>(Get.context!,
                                        listen: false)
                                    .isLoggedIn()
                                ? '${profile.userInfoModel?.fName ?? ''} ${profile.userInfoModel?.lName ?? ''}'
                                : 'Guest',
                            style: textStyle(16).copyWith(
                                color: UiColors.darkBlue,
                                fontWeight: FontWeight.normal));
                      }),
                    ],
                  ),
                ),
                // leading: Padding(
                //   padding: const EdgeInsets.all(13),
                //   child: Image.asset(
                //     Images.fiMenu,
                //     width: 24,
                //     height: 24,
                //   ).onTap(() {
                //     // "test".log();
                //     // Scaffold.of(context).openDrawer();
                //     scaffoldKey.currentState?.openDrawer();
                //   }),
                // ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          Images.fiShoppingCart,
                          width: 24,
                        ).onTap(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const CartScreen()));
                          // CartScreen().launch(context);
                        }),
                        Positioned(
                            top: -7,
                            right: -7,
                            child: Consumer<CartController>(
                                builder: (context, cart, child) {
                              return CircleAvatar(
                                  radius: 8,
                                  backgroundColor: ColorResources.red,
                                  child: Text(
                                      Provider.of<CartController>(context,
                                              listen: false)
                                          .cartList
                                          .length
                                          .toString(),
                                      style: titilliumSemiBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall)));
                            }))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          Images.fiNotification,
                          width: 30,
                        ).onTap(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const NotificationScreen()));
                          // CartScreen().launch(context);
                        }),
                        Positioned(
                            top: -5,
                            right: -5,
                            child: Consumer<NotificationController>(builder:
                                (context, notificationController, child) {
                              return CircleAvatar(
                                  radius: 8,
                                  backgroundColor: ColorResources.red,
                                  child: Text(
                                      notificationController.notificationModel
                                              ?.newNotificationItem
                                              .toString() ??
                                          '0',
                                      style: titilliumSemiBold.copyWith(
                                          color: Theme.of(context).cardColor,
                                          fontSize:
                                              Dimensions.fontSizeExtraSmall)));
                            }))
                      ],
                    ),
                  ),
                ],
                floating: true,
                elevation: 0,
                centerTitle: true,
                automaticallyImplyLeading: false,
                backgroundColor: UiColors.bgBlue,
                title: Image.asset(
                  Images.fiLogoColored,
                  height: 46,
                  width: 46,
                ).onTap(() async {
                  final token = await FirebaseMessaging.instance.getToken();
                  "${token}".log();
                  print("${token}");
                }),
              ),
              SliverToBoxAdapter(
                child: Provider.of<SplashController>(context, listen: false)
                            .configModel!
                            .announcement!
                            .status ==
                        '1'
                    ? Consumer<SplashController>(
                        builder: (context, announcement, _) {
                        return (announcement.configModel!.announcement!
                                        .announcement !=
                                    null &&
                                announcement.onOff)
                            ? AnnouncementWidget(
                                announcement:
                                    announcement.configModel!.announcement)
                            : const SizedBox();
                      })
                    : const SizedBox(),
              ),
              SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverDelegate(
                    child: InkWell(
                      onTap: () => SearchAdPage().launch(context,
                          pageRouteAnimation: PageRouteAnimation.Fade),
                      child: const Hero(
                          tag: "SearchText",
                          child: Material(child: SearchHomePageWidget())),
                    ).paddingBottom(0),
                  )),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.height,
                    const BannersWidget(),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),
                    Container(
                        decoration: boxDecorationDefault(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: []),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CategoryHomeList(),
                            12.height,
                            LatestSection(
                              type: BaseCategory.eProduct,
                              title: "Latest Products".translate(context),
                            ),
                            12.height,
                            LatestSection(
                              title: "Latest Service".translate(context),
                              type: BaseCategory.eService,
                            ),
                            12.height,
                            LatestSection(
                                type: BaseCategory.product,
                                title: "Latest Ad’s for products"
                                    .translate(context)),
                            12.height,
                            LatestSection(
                              type: BaseCategory.service,
                              title:
                                  "Latest Ad’s for Service".translate(context),
                            ),
                            12.height,
                            LatestSection(
                              type: BaseCategory.auto,
                              title: "Latest Ad’s for Auto".translate(context),
                            ),
                            12.height,
                            LatestSection(
                              type: BaseCategory.realState,
                              title: "Latest Ad’s for Real Estate"
                                  .translate(context),
                            ),
                            50.height
                          ],
                        )),

                    // const CategoryListWidget(isHomePage: true),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),
                    // Consumer<FlashDealController>(
                    //     builder: (context, megaDeal, child) {
                    //   return megaDeal.flashDeal == null
                    //       ? const FlashDealShimmer()
                    //       : megaDeal.flashDealList.isNotEmpty
                    //           ? Column(children: [
                    //               Padding(
                    //                 padding: const EdgeInsets.symmetric(
                    //                     horizontal:
                    //                         Dimensions.paddingSizeDefault),
                    //                 child: TitleRowWidget(
                    //                   title:
                    //                       getTranslated('flash_deal', context)
                    //                           ?.toUpperCase(),
                    //                   eventDuration: megaDeal.flashDeal != null
                    //                       ? megaDeal.duration
                    //                       : null,
                    //                   onTap: () {
                    //                     Navigator.push(
                    //                         context,
                    //                         MaterialPageRoute(
                    //                             builder: (_) =>
                    //                                 const FlashDealScreenView()));
                    //                   },
                    //                   isFlash: true,
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                   height: Dimensions.paddingSizeSmall),
                    //               Text(
                    //                   getTranslated(
                    //                           'hurry_up_the_offer_is_limited_grab_while_it_lasts',
                    //                           context) ??
                    //                       '',
                    //                   style: textRegular.copyWith(
                    //                       color: Provider.of<ThemeController>(
                    //                                   context,
                    //                                   listen: false)
                    //                               .darkTheme
                    //                           ? Theme.of(context).hintColor
                    //                           : Theme.of(context).primaryColor,
                    //                       fontSize:
                    //                           Dimensions.fontSizeDefault)),
                    //               const SizedBox(
                    //                   height: Dimensions.paddingSizeSmall),
                    //               const FlashDealsListWidget()
                    //             ])
                    //           : const SizedBox.shrink();
                    // }),
                    // const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    // Consumer<FeaturedDealController>(
                    //     builder: (context, featuredDealProvider, child) {
                    //   return featuredDealProvider.featuredDealProductList !=
                    //           null
                    //       ? featuredDealProvider
                    //               .featuredDealProductList!.isNotEmpty
                    //           ? Column(
                    //               children: [
                    //                 Stack(children: [
                    //                   Container(
                    //                     width:
                    //                         MediaQuery.of(context).size.width,
                    //                     height: 150,
                    //                     color: Theme.of(context)
                    //                         .colorScheme
                    //                         .onTertiary,
                    //                   ),
                    //                   Column(children: [
                    //                     Padding(
                    //                       padding: const EdgeInsets.symmetric(
                    //                           vertical: Dimensions
                    //                               .paddingSizeDefault),
                    //                       child: TitleRowWidget(
                    //                         title:
                    //                             '${getTranslated('featured_deals', context)}',
                    //                         onTap: () => Navigator.push(
                    //                             context,
                    //                             MaterialPageRoute(
                    //                                 builder: (_) =>
                    //                                     const FeaturedDealScreenView())),
                    //                       ),
                    //                     ),
                    //                     const FeaturedDealsListWidget(),
                    //                   ]),
                    //                 ]),
                    //                 const SizedBox(
                    //                     height: Dimensions.paddingSizeDefault),
                    //               ],
                    //             )
                    //           : const SizedBox.shrink()
                    //       : const FindWhatYouNeedShimmer();
                    // }),
                    // Consumer<BannerController>(
                    //     builder: (context, footerBannerProvider, child) {
                    //   return footerBannerProvider.footerBannerList != null &&
                    //           footerBannerProvider.footerBannerList!.isNotEmpty
                    //       ? Padding(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: Dimensions.paddingSizeDefault),
                    //           child: SingleBannersWidget(
                    //               bannerModel: footerBannerProvider
                    //                   .footerBannerList?[0]))
                    //       : const SizedBox();
                    // }),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),
                    // const FeaturedProductWidget(),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),
                    // singleVendor
                    //     ? const SizedBox()
                    //     : Consumer<ShopController>(
                    //         builder: (context, topSellerProvider, child) {
                    //         return (topSellerProvider.sellerModel != null &&
                    //                 (topSellerProvider.sellerModel!.sellers !=
                    //                         null &&
                    //                     topSellerProvider
                    //                         .sellerModel!.sellers!.isNotEmpty))
                    //             ? TitleRowWidget(
                    //                 title: getTranslated('top_seller', context),
                    //                 onTap: () => Navigator.push(
                    //                     context,
                    //                     MaterialPageRoute(
                    //                         builder: (_) =>
                    //                             const AllTopSellerScreen(
                    //                               title: 'top_stores',
                    //                             ))))
                    //             : const SizedBox();
                    //       }),
                    // singleVendor
                    //     ? const SizedBox(height: 0)
                    //     : const SizedBox(height: Dimensions.paddingSizeSmall),
                    // singleVendor
                    //     ? const SizedBox()
                    //     : Consumer<ShopController>(
                    //         builder: (context, topSellerProvider, child) {
                    //         return (topSellerProvider.sellerModel != null &&
                    //                 (topSellerProvider.sellerModel!.sellers !=
                    //                         null &&
                    //                     topSellerProvider
                    //                         .sellerModel!.sellers!.isNotEmpty))
                    //             ? Padding(
                    //                 padding: const EdgeInsets.only(
                    //                     bottom: Dimensions.paddingSizeDefault),
                    //                 child: SizedBox(
                    //                     height: ResponsiveHelper.isTab(context)
                    //                         ? 170
                    //                         : 165,
                    //                     child: TopSellerView(
                    //                       isHomePage: true,
                    //                       scrollController: _scrollController,
                    //                     )))
                    //             : const SizedBox();
                    //       }),
                    // const Padding(
                    //     padding: EdgeInsets.only(
                    //         bottom: Dimensions.paddingSizeDefault),
                    //     child: RecommendedProductWidget()),
                    // const Padding(
                    //     padding: EdgeInsets.only(
                    //         bottom: Dimensions.paddingSizeDefault),
                    //     child: LatestProductListWidget()),
                    // if (configModel?.brandSetting == "1")
                    //   TitleRowWidget(
                    //     title: getTranslated('brand', context),
                    //     onTap: () => Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (_) => const BrandsView())),
                    //   ),
                    // SizedBox(
                    //     height: configModel?.brandSetting == "1"
                    //         ? Dimensions.paddingSizeSmall
                    //         : 0),
                    // if (configModel!.brandSetting == "1") ...[
                    //   const BrandListWidget(isHomePage: true),
                    //   const SizedBox(height: Dimensions.paddingSizeDefault),
                    // ],
                    // const HomeCategoryProductWidget(isHomePage: true),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),
                    // const FooterBannerSliderWidget(),
                    // const SizedBox(height: Dimensions.paddingSizeDefault),
                    // Consumer<ProductController>(
                    //     builder: (ctx, prodProvider, child) {
                    //   return Container(
                    //       decoration: BoxDecoration(
                    //           color: Theme.of(context)
                    //               .colorScheme
                    //               .onSecondaryContainer),
                    //       child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Padding(
                    //                 padding: const EdgeInsets.fromLTRB(
                    //                     Dimensions.paddingSizeDefault,
                    //                     0,
                    //                     Dimensions.paddingSizeSmall,
                    //                     0),
                    //                 child: Row(children: [
                    //                   Expanded(
                    //                       child: Text(
                    //                           prodProvider.title == 'xyz'
                    //                               ? getTranslated(
                    //                                   'new_arrival', context)!
                    //                               : prodProvider.title!,
                    //                           style: titleHeader)),
                    //                   prodProvider.latestProductList != null
                    //                       ? PopupMenuButton(
                    //                           padding: const EdgeInsets.all(0),
                    //                           itemBuilder: (context) {
                    //                             return [
                    //                               PopupMenuItem(
                    //                                 value:
                    //                                     ProductType.newArrival,
                    //                                 child: Text(
                    //                                     getTranslated(
                    //                                             'new_arrival',
                    //                                             context) ??
                    //                                         '',
                    //                                     style: textRegular
                    //                                         .copyWith(
                    //                                       color: prodProvider
                    //                                                   .productType ==
                    //                                               ProductType
                    //                                                   .newArrival
                    //                                           ? Theme.of(
                    //                                                   context)
                    //                                               .primaryColor
                    //                                           : Theme.of(
                    //                                                   context)
                    //                                               .textTheme
                    //                                               .bodyLarge
                    //                                               ?.color,
                    //                                     )),
                    //                               ),
                    //                               PopupMenuItem(
                    //                                 value:
                    //                                     ProductType.topProduct,
                    //                                 child: Text(
                    //                                     getTranslated(
                    //                                             'top_product',
                    //                                             context) ??
                    //                                         '',
                    //                                     style: textRegular
                    //                                         .copyWith(
                    //                                       color: prodProvider
                    //                                                   .productType ==
                    //                                               ProductType
                    //                                                   .topProduct
                    //                                           ? Theme.of(
                    //                                                   context)
                    //                                               .primaryColor
                    //                                           : Theme.of(
                    //                                                   context)
                    //                                               .textTheme
                    //                                               .bodyLarge
                    //                                               ?.color,
                    //                                     )),
                    //                               ),
                    //                               PopupMenuItem(
                    //                                 value:
                    //                                     ProductType.bestSelling,
                    //                                 child: Text(
                    //                                     getTranslated(
                    //                                             'best_selling',
                    //                                             context) ??
                    //                                         '',
                    //                                     style: textRegular
                    //                                         .copyWith(
                    //                                       color: prodProvider
                    //                                                   .productType ==
                    //                                               ProductType
                    //                                                   .bestSelling
                    //                                           ? Theme.of(
                    //                                                   context)
                    //                                               .primaryColor
                    //                                           : Theme.of(
                    //                                                   context)
                    //                                               .textTheme
                    //                                               .bodyLarge
                    //                                               ?.color,
                    //                                     )),
                    //                               ),
                    //                               PopupMenuItem(
                    //                                 value: ProductType
                    //                                     .discountedProduct,
                    //                                 child: Text(
                    //                                     getTranslated(
                    //                                             'discounted_product',
                    //                                             context) ??
                    //                                         '',
                    //                                     style: textRegular
                    //                                         .copyWith(
                    //                                       color: prodProvider
                    //                                                   .productType ==
                    //                                               ProductType
                    //                                                   .discountedProduct
                    //                                           ? Theme.of(
                    //                                                   context)
                    //                                               .primaryColor
                    //                                           : Theme.of(
                    //                                                   context)
                    //                                               .textTheme
                    //                                               .bodyLarge
                    //                                               ?.color,
                    //                                     )),
                    //                               ),
                    //                             ];
                    //                           },
                    //                           shape: RoundedRectangleBorder(
                    //                               borderRadius: BorderRadius
                    //                                   .circular(Dimensions
                    //                                       .paddingSizeSmall)),
                    //                           child: Padding(
                    //                               padding: const EdgeInsets
                    //                                   .fromLTRB(
                    //                                   Dimensions
                    //                                       .paddingSizeExtraSmall,
                    //                                   Dimensions
                    //                                       .paddingSizeSmall,
                    //                                   Dimensions
                    //                                       .paddingSizeExtraSmall,
                    //                                   Dimensions
                    //                                       .paddingSizeSmall),
                    //                               child: Image.asset(
                    //                                   Images.dropdown,
                    //                                   scale: 3)),
                    //                           onSelected: (ProductType value) {
                    //                             if (value ==
                    //                                 ProductType.newArrival) {
                    //                               Provider.of<ProductController>(
                    //                                       context,
                    //                                       listen: false)
                    //                                   .changeTypeOfProduct(
                    //                                       value, types[0]);
                    //                             } else if (value ==
                    //                                 ProductType.topProduct) {
                    //                               Provider.of<ProductController>(
                    //                                       context,
                    //                                       listen: false)
                    //                                   .changeTypeOfProduct(
                    //                                       value, types[1]);
                    //                             } else if (value ==
                    //                                 ProductType.bestSelling) {
                    //                               Provider.of<ProductController>(
                    //                                       context,
                    //                                       listen: false)
                    //                                   .changeTypeOfProduct(
                    //                                       value, types[2]);
                    //                             } else if (value ==
                    //                                 ProductType
                    //                                     .discountedProduct) {
                    //                               Provider.of<ProductController>(
                    //                                       context,
                    //                                       listen: false)
                    //                                   .changeTypeOfProduct(
                    //                                       value, types[3]);
                    //                             }
                    //                             Provider.of<ProductController>(
                    //                                     context,
                    //                                     listen: false)
                    //                                 .getLatestProductList(1,
                    //                                     reload: true);
                    //                           },
                    //                         )
                    //                       : const SizedBox()
                    //                 ])),
                    //             Padding(
                    //               padding: const EdgeInsets.symmetric(
                    //                   horizontal: Dimensions.paddingSizeSmall),
                    //               child: ProductListWidget(
                    //                   isHomePage: false,
                    //                   productType: ProductType.newArrival,
                    //                   scrollController: _scrollController),
                    //             ),
                    //             const SizedBox(
                    //                 height: Dimensions.homePagePadding)
                    //           ]));
                    // }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  SliverDelegate({required this.child, this.height = 70});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height ||
        oldDelegate.minExtent != height ||
        child != oldDelegate.child;
  }
}
