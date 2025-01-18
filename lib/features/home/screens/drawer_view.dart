import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/address/screens/address_list_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/screens/auth_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/compare/screens/compare_product_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/coupon/screens/coupon_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/logout_confirm_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/widgets/title_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/notification/screens/notification_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/order_details/screens/guest_track_order_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/profile/screens/profile_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/refer_and_earn/screens/refer_and_earn_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/setting/screens/settings_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    var authController = Provider.of<AuthController>(context, listen: false);
    var isGuestMode =
        !Provider.of<AuthController>(context, listen: false).isLoggedIn();
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: boxDecorationDefault(
          color: UiColors.white,
          borderRadius: BorderRadius.only(
              topRight: getLang() ? Radius.circular(12) : Radius.circular(0),
              bottomRight: getLang() ? Radius.circular(12) : Radius.circular(0),
              topLeft: getLang() ? Radius.circular(0) : Radius.circular(12),
              bottomLeft:
                  getLang() ? Radius.circular(0) : Radius.circular(12))),
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              50.height,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: UiColors.darkBlue,
                ),
              ).onTap(() {
                context.openEndDrawer();
              })
            ],
          ),
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
            // if (!isGuestMode)
            //   MenuButtonWidget(
            //       image: Images.refIcon,
            //       title: getTranslated('refer_and_earn', context),
            //       isProfile: true,
            //       navigateTo: const ReferAndEarnScreen()),
            // MenuButtonWidget(
            //     image: Images.category,
            //     title: getTranslated('CATEGORY', context),
            //     navigateTo: const CategoryScreen()),
            // if (splashController.configModel!.activeTheme != "default" &&
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
                navigateTo: const SettingsScreen()),
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
                        builder: (_) => const LogoutCustomBottomSheetWidget());
                  }
                }),
            Padding(
                padding: const EdgeInsets.only(
                    bottom: Dimensions.paddingSizeDefault),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                      '${getTranslated('version', context)} ${AppConstants.appVersion}',
                      style: textRegular.copyWith(
                          fontSize: Dimensions.fontSizeLarge,
                          color: Theme.of(context).hintColor))
                ]))
          ]),
        ],
      ),
    );
  }
}
