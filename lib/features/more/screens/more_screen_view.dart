import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/share_preferance.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/my_ads_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/new_inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/loyaltyPoint/controllers/loyalty_point_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/views_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/screens/guest_track_order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/my_plan_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/my_plan_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/seller_plans_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/controllers/profile_contrroller.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/screens/profile_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/support/screens/support_ticket_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/wallet/controllers/wallet_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/logout_confirm_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/compare/screens/compare_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/contact_us/screens/contact_us_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/screens/coupon_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/html_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/profile_info_section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/more_horizontal_section_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/screens/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/refer_and_earn/screens/refer_and_earn_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/setting/screens/settings_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'faq_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/title_button_widget.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});
  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late bool isGuestMode;
  String? version;
  bool singleVendor = false;

  @override
  void initState() {
    isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    if (Provider.of<AuthController>(context, listen: false).isLoggedIn()) {
      version = Provider.of<SplashController>(context, listen: false)
              .configModel!
              .softwareVersion ??
          'version';
      Provider.of<ProfileController>(context, listen: false)
          .getUserInfo(context);
      if (Provider.of<SplashController>(context, listen: false)
              .configModel!
              .walletStatus ==
          1) {
        Provider.of<WalletController>(context, listen: false)
            .getTransactionList(context, 1, 'all');
      }
      if (Provider.of<SplashController>(context, listen: false)
              .configModel!
              .loyaltyPointStatus ==
          1) {
        Provider.of<LoyaltyPointController>(context, listen: false)
            .getLoyaltyPointList(context, 1);
      }
    }
    singleVendor = Provider.of<SplashController>(context, listen: false)
            .configModel!
            .businessMode ==
        "single";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    var authController = Provider.of<AuthController>(context, listen: false);
    return Scaffold(
      backgroundColor: UiColors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
              floating: true,
              elevation: 0,
              expandedHeight: 160,
              pinned: true,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).highlightColor,
              collapsedHeight: 160,
              flexibleSpace: const ProfileInfoSectionWidget()),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: boxDecorationDefault(
                            boxShadow: [],
                            borderRadius: BorderRadius.circular(0),
                            color: UiColors.bgBlue),
                        padding: const EdgeInsets.only(top: 12),
                        child: const Center(child: MoreHorizontalSection())),

                    if (!isGuestMode)
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          RoundedSection(
                            color: UiColors.white,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 0),
                            decoration: boxDecorationDefault(
                                boxShadow: [],
                                color: UiColors.secondary,
                                borderRadius: BorderRadius.circular(99)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Become A Seller".translate(context),
                                  style: textStyle(16).copyWith(
                                      color: UiColors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  color: UiColors.white,
                                  size: 20,
                                )
                              ],
                            ),
                          ).paddingOnly(top: 12).onTap(() {
                            SellerPlansView(
                              showBackButton: true,
                            ).launch(context);
                          }),
                        ],
                      ),
                    12.height,
                    if (!isGuestMode)
                      Container(
                          decoration: boxDecorationDefault(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: []),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "My Subscription".translate(context),
                                  style: textStyle(16).copyWith(
                                      color: UiColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("Get More Plan".translate(context),
                                        style: textStyle(16).copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: UiColors.darkBlue,
                                            fontWeight: FontWeight.bold))
                                    .onTap(() {
                                  MyPlanView(
                                    showBackButton: true,
                                  ).launch(context);
                                }),
                              ])),
                    if (!isGuestMode)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: ProviderWidget(
                          function: (list) {
                            return MyPlanWidget(
                              list: list,
                            );
                          },
                          loadingShape: MyPlanWidget(
                            list: [PlanModel(), PlanModel(), PlanModel()],
                          ),
                          listener: (ref) => ref.watch(myPlanListProvider),
                        ),
                      ),
                    if (!isGuestMode)
                      Container(
                          decoration: boxDecorationDefault(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: []),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 12),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "My Ads".translate(context),
                                  style: textStyle(16).copyWith(
                                      color: UiColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text("View All Ads".translate(context),
                                    style: textStyle(16).copyWith(
                                        color: UiColors.darkBlue,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold)),
                              ])).onTap(() {
                        MyAdsView().launch(context);
                      }),
                    if (!isGuestMode) const ViewsWidget(),
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(
                    //       Dimensions.paddingSizeDefault,
                    //       Dimensions.paddingSizeDefault,
                    //       Dimensions.paddingSizeDefault,
                    //       0),
                    //   child: Text(
                    //     getTranslated('general', context) ?? '',
                    //     style: textRegular.copyWith(
                    //         fontSize: Dimensions.fontSizeExtraLarge,
                    //         color: Theme.of(context).colorScheme.onPrimary),
                    //   ),
                    // ),
                    16.height,
                    Column(children: [
                      MenuButtonWidget(
                          image: Images.trackOrderIcon,
                          title: getTranslated('TRACK_ORDER', context),
                          navigateTo: const GuestTrackOrderScreen()),
                      if (Provider.of<AuthController>(context, listen: false)
                          .isLoggedIn())
                        MenuButtonWidget(
                            image: Images.user,
                            title: getTranslated('profile', context),
                            navigateTo: const ProfileScreen()),
                      MenuButtonWidget(
                          image: Images.address,
                          title: getTranslated('addresses', context),
                          navigateTo: const AddressListScreen()),
                      MenuButtonWidget(
                          image: Images.coupon,
                          title: getTranslated('coupons', context),
                          navigateTo: const CouponList()),
                      if (!isGuestMode)

                        //   MenuButtonWidget(
                        //       image: Images.refIcon,
                        //       title: getTranslated('refer_and_earn', context),
                        //       isProfile: true,
                        //       navigateTo: const ReferAndEarnScreen()),
                        // MenuButtonWidget(
                        //     image: Images.category,
                        //     title: getTranslated('CATEGORY', context),
                        //     navigateTo: const CategoryScreen()),
                        // if (splashController.configModel!.activeTheme !=
                        //         "default" &&
                        //     authController.isLoggedIn())
                        //   MenuButtonWidget(
                        //       image: Images.compare,
                        //       title: getTranslated('compare_products', context),
                        //       navigateTo: const CompareProductScreen()),
                        MenuButtonWidget(
                            image: Images.notification,
                            title: getTranslated(
                              'notification',
                              context,
                            ),
                            isNotification: true,
                            navigateTo: const NotificationScreen()),
                      MenuButtonWidget(
                          image: Images.settings,
                          title: getTranslated('settings', context),
                          navigateTo: const SettingsScreen())
                    ]),
                    // Padding(
                    //     padding: const EdgeInsets.fromLTRB(
                    //         Dimensions.paddingSizeDefault,
                    //         Dimensions.paddingSizeDefault,
                    //         Dimensions.paddingSizeDefault,
                    //         0),
                    //     child: Text(
                    //         getTranslated('help_and_support', context) ?? '',
                    //         style: textRegular.copyWith(
                    //             fontSize: Dimensions.fontSizeExtraLarge,
                    //             color:
                    //                 Theme.of(context).colorScheme.onPrimary))),
                    Column(children: [
                      singleVendor
                          ? const SizedBox()
                          : MenuButtonWidget(
                              image: Images.chats,
                              title: getTranslated('inbox', context),
                              navigateTo: const InboxScreenNew()),
                      ExpansionTile(
                        shape: Border(),
                        title: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: boxDecorationDefault(
                                color: UiColors.bgBlue,
                                boxShadow: [],
                                borderRadius: BorderRadius.circular(90),
                                border: Border.all(color: UiColors.borderBlue)),
                            child: Row(
                              children: [
                                Image.asset(
                                  Images.support,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.contain,
                                  color: UiColors.darkBlue,
                                ),
                                6.width,
                                Text(
                                  "support".translate(context),
                                  style: textStyle(20)
                                      .copyWith(color: UiColors.darkBlue),
                                ),
                              ],
                            )),
                        children: [
                          MenuButtonWidget(
                              image: Images.callIcon,
                              title: getTranslated('contact_us', context),
                              navigateTo: const ContactUsScreen()),
                          MenuButtonWidget(
                              image: Images.preference,
                              title: getTranslated('support_ticket', context),
                              navigateTo: const SupportTicketScreen()),
                        ],
                      ),

                      ExpansionTile(
                        shape: Border(),
                        title: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: boxDecorationDefault(
                                color: UiColors.bgBlue,
                                boxShadow: [],
                                borderRadius: BorderRadius.circular(90),
                                border: Border.all(color: UiColors.borderBlue)),
                            child: Row(
                              children: [
                                Image.asset(
                                  Images.termCondition,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.contain,
                                  color: UiColors.darkBlue,
                                ),
                                6.width,
                                Text(
                                  "policies".translate(context),
                                  style: textStyle(20)
                                      .copyWith(color: UiColors.darkBlue),
                                ),
                              ],
                            )),
                        children: [
                          MenuButtonWidget(
                              image: Images.termCondition,
                              title: getTranslated('terms_condition', context),
                              navigateTo: HtmlViewScreen(
                                title:
                                    getTranslated('terms_condition', context),
                                url: Provider.of<SplashController>(context,
                                        listen: false)
                                    .configModel!
                                    .termsConditions,
                              )),
                          MenuButtonWidget(
                              image: Images.privacyPolicy,
                              title: getTranslated('privacy_policy', context),
                              navigateTo: HtmlViewScreen(
                                title: getTranslated('privacy_policy', context),
                                url: Provider.of<SplashController>(context,
                                        listen: false)
                                    .configModel!
                                    .privacyPolicy,
                              )),
                          if (Provider.of<SplashController>(context,
                                      listen: false)
                                  .configModel!
                                  .refundPolicy!
                                  .status ==
                              1)
                            MenuButtonWidget(
                                image: Images.termCondition,
                                title: getTranslated('refund_policy', context),
                                navigateTo: HtmlViewScreen(
                                  title:
                                      getTranslated('refund_policy', context),
                                  url: Provider.of<SplashController>(context,
                                          listen: false)
                                      .configModel!
                                      .refundPolicy!
                                      .content,
                                )),
                          if (Provider.of<SplashController>(context,
                                      listen: false)
                                  .configModel!
                                  .returnPolicy!
                                  .status ==
                              1)
                            MenuButtonWidget(
                                image: Images.termCondition,
                                title: getTranslated('return_policy', context),
                                navigateTo: HtmlViewScreen(
                                  title:
                                      getTranslated('return_policy', context),
                                  url: Provider.of<SplashController>(context,
                                          listen: false)
                                      .configModel!
                                      .returnPolicy!
                                      .content,
                                )),
                          if (Provider.of<SplashController>(context,
                                      listen: false)
                                  .configModel!
                                  .cancellationPolicy!
                                  .status ==
                              1)
                            MenuButtonWidget(
                                image: Images.termCondition,
                                title: getTranslated(
                                    'cancellation_policy', context),
                                navigateTo: HtmlViewScreen(
                                  title: getTranslated(
                                      'cancellation_policy', context),
                                  url: Provider.of<SplashController>(context,
                                          listen: false)
                                      .configModel!
                                      .cancellationPolicy!
                                      .content,
                                )),
                        ],
                      ),

                      // MenuButtonWidget(
                      //     image: Images.faq,
                      //     title: getTranslated('faq', context),
                      //     navigateTo: FaqScreen(
                      //       title: getTranslated('faq', context),
                      //     )),
                      12.height,
                      MenuButtonWidget(
                          image: Images.user,
                          title: getTranslated('about_us', context),
                          navigateTo: HtmlViewScreen(
                            title: getTranslated('about_us', context),
                            url: Provider.of<SplashController>(context,
                                    listen: false)
                                .configModel!
                                .aboutUs,
                          ))
                    ]),
                    ListTile(
                        leading: SizedBox(
                            width: 30,
                            child: Image.asset(
                              Images.logOut,
                              color: Theme.of(context).primaryColor,
                            )),
                        title: Text(
                            isGuestMode
                                ? getTranslated('sign_in', context)!
                                : getTranslated('sign_out', context)!,
                            style: titilliumRegular.copyWith(
                                fontSize: Dimensions.fontSizeLarge)),
                        onTap: () {
                          if (isGuestMode) {
                            const AuthScreen().launch(context,
                                isNewTask: true,
                                pageRouteAnimation: PageRouteAnimation.Fade);
                          } else {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (_) =>
                                    const LogoutCustomBottomSheetWidget());
                          }
                        }),
                    Padding(
                        padding: const EdgeInsets.only(
                            bottom: Dimensions.paddingSizeDefault),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                  '${getTranslated('version', context)} ${AppConstants.appVersion}',
                                  style: textRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge,
                                      color: Theme.of(context).hintColor))
                            ]))
                  ]),
            ),
          )
        ],
      ),
    );
  }
}

class RoundedSection extends StatelessWidget {
  final Color color;
  const RoundedSection({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -7,
      child: Column(
        children: [
          Container(
            decoration: boxDecorationDefault(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [],
              color: color,
            ),
            height: 30,
            width: MediaQuery.sizeOf(context).width,
            padding: EdgeInsets.symmetric(
              vertical: 13,
            ),
            child: Row(
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
