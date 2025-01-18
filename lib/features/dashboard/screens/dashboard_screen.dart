import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/ad_home.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/add_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/my_ads_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/cart/screens/cart_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/new_inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/models/navigation_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/painter.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/widgets/dashboard_menu_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/deal/controllers/flash_deal_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/my_plan_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/plan_list_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/screens/product_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/create_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_ad_category.dart';
import 'package:flutter_sixvalley_ecommerce/features/wishlist/controllers/wishlist_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/network_info.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/widgets/app_exit_card_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/aster_theme_home_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/fashion_theme_home_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/home_screens.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/more_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/order/screens/order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:geolocator/geolocator.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({
    super.key,
  });
  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _pageIndex = 0;
  late List<NavigationModel> _screens;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();
  final PageStorageBucket bucket = PageStorageBucket();

  bool singleVendor = false;

  @override
  void initState() {
    super.initState();
    afterBuildCreated(() async {
      LocationPermission permission = await Geolocator.requestPermission();
      Position data = await Geolocator.getCurrentPosition();
      homeRef
          .read(locationAdProvider.notifier)
          .save(latitude: data.latitude, longitude: data.longitude);

      final appLinks = AppLinks();
      final sub = appLinks.uriLinkStream.listen((uri) {
        if (uri != null) {
          print('Received URI: $uri');
          final url = Uri.parse("$uri");
          final type = url.queryParameters['type'];
          final slug = url.queryParameters['slug'];
          final id = url.queryParameters['id'];
          // showCustomSnackBar('Received URI: $uri', context);
          // showCustomSnackBar(
          //     'type: $type, slug: $slug, id: $id, uri: $uri, url: $url',
          //     context);
          switch (type) {
            case "ad":
              AdDetails(
                productId: int.parse(id ?? "0"),
                slug: slug,
              ).launch(context);
              break;
            case "shop":
              TopSellerProductScreen(sellerId: int.parse(id ?? "0"))
                  .launch(context);
              break;
            case "product":
              ProductDetails(
                      productId: int.parse(id ?? "0"),
                      slug: slug,
                      productType: null)
                  .launch(context);
              break;
            default:
          }
          ;
        } else {}
      });
      await Provider.of<AuthController>(Get.context ?? context, listen: false)
          .updateToken(Get.context ?? context);
    });

    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      Provider.of<WishListController>(context, listen: false).getWishList();
      Provider.of<ChatController>(context, listen: false)
          .getChatList(1, reload: false, userType: 0);
      Provider.of<ChatController>(context, listen: false)
          .getChatList(1, reload: false, userType: 1);
    }

    final SplashController splashController =
        Provider.of<SplashController>(context, listen: false);
    singleVendor = splashController.configModel?.businessMode == "single";
    Provider.of<FlashDealController>(context, listen: false)
        .getFlashDealList(true, true);

    // if (splashController.configModel!.activeTheme == "default") {
    HomePage.loadData(false);
    // } else if (splashController.configModel!.activeTheme == "theme_aster") {
    //   AsterThemeHomeScreen.loadData(false);
    // } else {
    //   FashionThemeHomePage.loadData(false);
    // }

    _screens = [
      NavigationModel(
          name: 'home',
          icon: Images.fiHomeButton,
          screen:
              //  (splashController.configModel!.activeTheme == "default")
              //     ?
              const HomePage()
          // : (splashController.configModel!.activeTheme == "theme_aster")
          //     ? const AsterThemeHomeScreen()
          //     : const FashionThemeHomePage(),
          ),
      // NavigationModel(
      //     name: 'Ads',
      //     icon: Images.messageImage,
      //     screen: const AdHomeView(
      //       isBackButtonExist: false,
      //     )),
      NavigationModel(
        name: 'inbox'.translate(context),
        icon: Images.fiMessage,
        screen: const InboxScreenNew(isBackButtonExist: false),
        // showCartIcon: true
      ),
      NavigationModel(
          name: 'My Ads'.translate(context),
          icon: Images.fiStar,
          screen: const MyAdsView(isBackButtonExist: false)),
      NavigationModel(
          name: 'account'.translate(context),
          icon: Images.fiPerson,
          screen: const MoreScreen()),
    ];

    // Padding(padding: const EdgeInsets.only(right: 12.0),
    //   child: IconButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
    //     icon: Stack(clipBehavior: Clip.none, children: [
    //
    //       Image.asset(Images.cartArrowDownImage, height: Dimensions.iconSizeDefault,
    //           width: Dimensions.iconSizeDefault, color: ColorResources.getPrimary(context)),
    //
    //       Positioned(top: -4, right: -4,
    //           child: Consumer<CartController>(builder: (context, cart, child) {
    //             return CircleAvatar(radius: ResponsiveHelper.isTab(context)? 10 :  7, backgroundColor: ColorResources.red,
    //                 child: Text(cart.cartList.length.toString(),
    //                     style: titilliumSemiBold.copyWith(color: ColorResources.white,
    //                         fontSize: Dimensions.fontSizeExtraSmall)));})),
    //     ]),
    //   ),
    // ),

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (val) async {
          if (_pageIndex != 0) {
            _setPage(0);
            return;
          } else {
            await Future.delayed(const Duration(milliseconds: 150));
            showModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: Get.context!,
                builder: (_) => const AppExitCard());
          }
          return;
        },
        child: Scaffold(
            key: _scaffoldKey,
            body:
                PageStorage(bucket: bucket, child: _screens[_pageIndex].screen),
            bottomNavigationBar: Stack(
              alignment: AlignmentDirectional.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                    height: 68,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(Dimensions.paddingSizeLarge)),
                      color: Theme.of(context).cardColor,
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                            spreadRadius: 1,
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(.125))
                      ],
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _getBottomWidget(singleVendor))),
                Positioned(
                  bottom: 12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              4.width,
                              Container(
                                width: 70,
                                height: 70,
                                decoration: boxDecorationDefault(
                                    boxShadow: [],
                                    // shape: BoxShape.circle,
                                    color: Colors.transparent,
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/add.png"))),
                              ).onTap(() {
                                isLoggedIn
                                    ? const SelectAddCategory().launch(context,
                                        pageRouteAnimation:
                                            PageRouteAnimation.Fade)
                                    : showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (_) =>
                                            const NotLoggedInBottomSheetWidget());
                              })
                            ],
                          ),
                          2.height,
                          Center(
                            child: Text(
                              "Create Ad".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(12)
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ),
                          10.height,
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )));
  }

  void _setPage(int pageIndex) {
    setState(() {
      if (pageIndex == 1 && _pageIndex != 1) {
        Provider.of<ChatController>(context, listen: false)
            .setUserTypeIndex(context, 0);
        Provider.of<ChatController>(context, listen: false)
            .resetIsSearchComplete();
      }
      _pageIndex = pageIndex;
    });
  }

  List<Widget> _getBottomWidget(bool isSingleVendor) {
    List<Widget> list = [
      Expanded(
        child: CustomMenuWidget(
            isSelected: _pageIndex == 0,
            name: _screens[0].name,
            icon: _screens[0].icon,
            showCartCount: _screens[0].showCartIcon ?? false,
            onTap: () => _setPage(0)),
      ),
      Expanded(
        child: CustomMenuWidget(
            isSelected: _pageIndex == 1,
            name: _screens[1].name,
            icon: _screens[1].icon,
            showCartCount: _screens[1].showCartIcon ?? false,
            onTap: () => _setPage(1)),
      ),
      Column(
        children: [52.width],
      ),
      Expanded(
        child: CustomMenuWidget(
            isSelected: _pageIndex == 2,
            name: _screens[2].name,
            icon: _screens[2].icon,
            showCartCount: _screens[2].showCartIcon ?? false,
            onTap: () => _setPage(2)),
      ),
      Expanded(
        child: CustomMenuWidget(
            isSelected: _pageIndex == 3,
            name: _screens[3].name,
            icon: _screens[3].icon,
            showCartCount: _screens[3].showCartIcon ?? false,
            onTap: () => _setPage(3)),
      )
    ];
    // for (int index = 0; index < _screens.length; index++) {
    //   list.add(Expanded(
    //       child: CustomMenuWidget(
    //           isSelected: _pageIndex == index,
    //           name: _screens[index].name,
    //           icon: _screens[index].icon,
    //           showCartCount: _screens[index].showCartIcon ?? false,
    //           onTap: () => _setPage(index))));
    // }
    return list;
  }
}
