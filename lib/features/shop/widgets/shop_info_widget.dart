import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/controllers/chat_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/domain/models/seller_model.dart';
// import 'package:flutter_sixvalley_ecommerce/features/shop/domain/models/seller_info_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/splash/controllers/splash_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/responsive_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/controllers/shop_controller.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ShopInfoWidget extends StatelessWidget {
  final bool vacationIsOn;
  final bool temporaryClose;
  final String sellerName;
  final int sellerId;
  final String banner;
  final String shopImage;
  final String? crNumber;
  final String? socialMedia;
  final String? description;
  const ShopInfoWidget({
    super.key,
    this.crNumber,
    this.socialMedia,
    this.description,
    required this.vacationIsOn,
    required this.sellerName,
    required this.sellerId,
    required this.banner,
    required this.shopImage,
    required this.temporaryClose,
  });

  @override
  Widget build(BuildContext context) {
    var splashController =
        Provider.of<SplashController>(context, listen: false);
    return Column(
      children: [
        CustomImageWidget(
          image: sellerId == 0
              ? splashController.configModel!.companyLogo?.path ?? ''
              : banner,
          placeholder: Images.placeholder_3x1,
          width: MediaQuery.of(context).size.width,
          height: ResponsiveHelper.isTab(context) ? 250 : 120,
        ),
        Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: Container(
            transform: Matrix4.translationValues(0, -20, 0),
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall,
                vertical: Dimensions.paddingSizeDefault),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).cardColor,
                boxShadow: Provider.of<ThemeController>(context, listen: false)
                        .darkTheme
                    ? null
                    : [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 5)
                      ]),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Stack(children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).highlightColor,
                        boxShadow:
                            Provider.of<ThemeController>(context, listen: false)
                                    .darkTheme
                                ? null
                                : [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 5)
                                  ]),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            Dimensions.paddingSizeExtraSmall),
                        child: CustomImageWidget(
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            image: sellerId == 0
                                ? splashController
                                        .configModel!.companyFavIcon?.path ??
                                    ''
                                : shopImage))),
                if (temporaryClose || vacationIsOn)
                  Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(.5),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(Dimensions.paddingSizeExtraSmall)),
                      )),
                temporaryClose
                    ? Positioned(
                        top: 0,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Align(
                            alignment: Alignment.center,
                            child: Center(
                                child: Text(
                                    getTranslated('temporary_closed', context)!
                                        .replaceAll(' ', '\n'),
                                    textAlign: TextAlign.center,
                                    style: textRegular.copyWith(
                                        color: Colors.white,
                                        fontSize:
                                            Dimensions.fontSizeExtraSmall)))))
                    : vacationIsOn
                        ? Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Align(
                                alignment: Alignment.center,
                                child: Center(
                                    child: Text(
                                        getTranslated(
                                            'close_for_now', context)!,
                                        textAlign: TextAlign.center,
                                        style: textRegular.copyWith(
                                            color: Colors.white,
                                            fontSize: Dimensions
                                                .fontSizeExtraSmall)))))
                        : const SizedBox()
              ]),
              const SizedBox(width: Dimensions.paddingSizeSmall),
              Expanded(
                child: Consumer<ShopController>(
                    builder: (context, sellerProvider, _) {
                  String ratting = sellerProvider.sellerInfoModel != null &&
                          sellerProvider.sellerInfoModel!.avgRating != null
                      ? sellerProvider.sellerInfoModel!.avgRating.toString()
                      : "0";

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(
                            sellerName ?? "",
                            style: textMedium.copyWith(
                                fontSize: Dimensions.fontSizeLarge),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.all(Dimensions.paddingSizeSmall),
                          child: InkWell(
                              onTap: () {
                                if (vacationIsOn || temporaryClose) {
                                  showCustomSnackBar(
                                      "${getTranslated("this_shop_is_close_now", context)}",
                                      context);
                                } else {
                                  if (!Provider.of<AuthController>(context,
                                          listen: false)
                                      .isLoggedIn()) {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (_) =>
                                            const NotLoggedInBottomSheetWidget());
                                  } else {
                                    Provider.of<ChatController>(context,
                                            listen: false)
                                        .setUserTypeIndex(context, 1);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => ChatScreen(
                                                id: sellerId,
                                                name: sellerName,
                                                userType: 1)));
                                  }
                                }
                              },
                              child: Image.asset(Images.chatImage,
                                  height: ResponsiveHelper.isTab(context)
                                      ? Dimensions.iconSizeLarge
                                      : Dimensions.iconSizeDefault)),
                        )
                      ]),
                      sellerProvider.sellerInfoModel != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Icon(Icons.star_rate_rounded,
                                                color: Colors.orange),
                                            Text(
                                                double.parse(ratting)
                                                    .toStringAsFixed(1),
                                                style: textRegular),
                                            if (sellerProvider.sellerInfoModel!
                                                        .minimumOrderAmount !=
                                                    null &&
                                                sellerProvider.sellerInfoModel!
                                                        .minimumOrderAmount! >
                                                    0)
                                              Padding(
                                                padding: const EdgeInsets
                                                    .symmetric(
                                                    horizontal: Dimensions
                                                        .paddingSizeExtraSmall),
                                                child: Text(
                                                  '|',
                                                  style: textRegular.copyWith(
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                ),
                                              ),
                                            if (sellerProvider.sellerInfoModel!
                                                        .minimumOrderAmount !=
                                                    null &&
                                                sellerProvider.sellerInfoModel!
                                                        .minimumOrderAmount! >
                                                    0)
                                              Text(
                                                  '${sellerProvider.sellerInfoModel!.totalReview} ${getTranslated('reviews', context)}',
                                                  style: titleRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis)
                                          ]),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(Icons.info_outline,
                                                size: 20,
                                                color: UiColors.darkBlue),
                                            5.width,
                                            Text(
                                              "More Information"
                                                  .translate(context),
                                              style: textStyle(13).copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ).onTap(() {
                                        SmartDialog.show(
                                            builder: (BuildContext context) =>
                                                MoreInformationWidget(
                                                    seller: sellerProvider
                                                        .sellerInfoModel
                                                        ?.seller,
                                                    sellerName: sellerName,
                                                    description: description,
                                                    socialMedia: socialMedia));
                                      })
                                    ],
                                  ),
                                  const SizedBox(
                                      height: Dimensions.paddingSizeSmall),
                                  Row(children: [
                                    (sellerProvider.sellerInfoModel!
                                                    .minimumOrderAmount !=
                                                null &&
                                            sellerProvider.sellerInfoModel!
                                                    .minimumOrderAmount! >
                                                0)
                                        ? Text(
                                            '${PriceConverter.convertPrice(context, sellerProvider.sellerInfoModel!.minimumOrderAmount)} '
                                            '${getTranslated('minimum_order', context)}',
                                            style: titleRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        : Text(
                                            '${sellerProvider.sellerInfoModel!.totalReview} ${getTranslated('reviews', context)}',
                                            style: titleRegular.copyWith(
                                                fontSize:
                                                    Dimensions.fontSizeSmall,
                                                color: Theme.of(context)
                                                    .primaryColor),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.paddingSizeExtraSmall),
                                      child: Text(
                                        '|',
                                        style: textRegular.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ),
                                    Text(
                                        '${sellerProvider.sellerInfoModel!.totalProduct} ${getTranslated('products', context)}',
                                        style: titleRegular.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                            color:
                                                Theme.of(context).primaryColor),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis)
                                  ]),
                                ])
                          : const SizedBox(),
                    ],
                  );
                }),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class MoreInformationWidget extends StatelessWidget {
  const MoreInformationWidget({
    super.key,
    required this.sellerName,
    required this.description,
    required this.socialMedia,
    this.seller,
  });
  final dynamic? seller;
  final String sellerName;
  final String? description;
  final String? socialMedia;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 22),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Shop information",
            style: textStyle(18).copyWith(),
          ),
          const Divider(
            color: UiColors.medGrey,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shop Name".translate(context) + ":",
                style: textStyle(16).copyWith(color: UiColors.darkBlue),
              ),
              Text("${sellerName}"),
            ],
          ),
          // 4.height,
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       "Seller Name".translate(context) + ":",
          //       style: textStyle(16).copyWith(color: UiColors.darkBlue),
          //     ),
          //     Row(
          //       children: [
          //         Text("${seller?.fName} "),
          //         Text("${seller?.lName}"),
          //       ],
          //     ),
          //   ],
          // ),
          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phone Number".translate(context) + ":",
                style: textStyle(16).copyWith(color: UiColors.darkBlue),
              ),
              Text("${seller?.phone}"),
            ],
          ),
          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "description".translate(context) + ":",
                style: textStyle(16).copyWith(color: UiColors.darkBlue),
              ),
            ],
          ),
          Text("${description}"),
          4.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Social Media URL".translate(context) + ":",
                style: textStyle(16).copyWith(color: UiColors.darkBlue),
              ),
            ],
          ),
          Text(
            "${socialMedia}",
            style: textStyle(14).copyWith(
                color: UiColors.darkBlue,
                decorationStyle: TextDecorationStyle.wavy,
                decoration: TextDecoration.underline),
          ).onTap(() async {
            try {
              await launchUrl(Uri.parse("${socialMedia}"));
            } catch (e) {}
          }),
        ],
      ),
    );
  }
}
