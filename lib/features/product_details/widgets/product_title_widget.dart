import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_directionality_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/rating_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/color_helper.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/helper/product_helper.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProductTitleWidget extends StatelessWidget {
  final ProductDetailsModel? productModel;
  final String? averageRatting;
  final bool isAd;
  const ProductTitleWidget(
      {super.key,
      required this.productModel,
      this.averageRatting,
      required this.isAd});

  @override
  Widget build(BuildContext context) {
    ({double? end, double? start})? priceRange =
        ProductHelper.getProductPriceRange(productModel);
    double? startingPrice = priceRange.start;
    double? endingPrice = priceRange.end;

    return productModel != null
        ? Container(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.homePagePadding),
            child: Consumer<ProductDetailsController>(
              builder: (context, details, child) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(productModel!.name ?? '',
                              style: textStyle(16)
                                  .copyWith(fontWeight: FontWeight.bold),
                              maxLines: 2),
                          Row(
                            children: [
                              FavouriteDetailsWidget(
                                  backgroundColor:
                                      ColorResources.getImageBg(context),
                                  productId: productModel!.id),
                              12.width,
                              Icon(Icons.share_outlined,
                                      size: 28,
                                      color: Theme.of(context).primaryColor)
                                  .onTap(() {
                                Share.share(
                                    '${getTranslated('hey', context)}! ${getTranslated('check_out_this', context)} ${productModel!.name} ${getTranslated('at', context)} ${AppConstants.baseUrl}?id=${productModel!.id}&type=${isAd ? "ad" : "product"}&slug=${productModel?.slug}');
                              })
                            ],
                          ),
                        ],
                      ),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomDirectionalityWidget(
                              child: Text(
                                  '${startingPrice != null ? PriceConverter.convertPrice(context, startingPrice, discount: productModel!.discount, discountType: productModel!.discountType) : ''}'
                                  '${endingPrice != null ? ' - ${PriceConverter.convertPrice(context, endingPrice, discount: productModel!.discount, discountType: productModel!.discountType)}' : ''}',
                                  style: textStyle(20).copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: UiColors.darkBlue)),
                            ),
                            if (productModel!.discount != null &&
                                productModel!.discount! > 0) ...[
                              const SizedBox(
                                  width: Dimensions.paddingSizeSmall),
                              CustomDirectionalityWidget(
                                child: Text(
                                    '${PriceConverter.convertPrice(context, startingPrice)}'
                                    '${endingPrice != null ? ' - ${PriceConverter.convertPrice(context, endingPrice)}' : ''}',
                                    style: titilliumRegular.copyWith(
                                        color: Theme.of(context).hintColor,
                                        decoration:
                                            TextDecoration.lineThrough)),
                              ),
                            ],
                          ]),
                      const SizedBox(height: Dimensions.paddingSizeDefault),
                      Row(children: [
                        isAd
                            ? SizedBox()
                            : RatingBar(
                                rating: productModel!.reviews != null
                                    ? productModel!.reviews!.isNotEmpty
                                        ? double.parse(averageRatting!)
                                        : 0.0
                                    : 0.0),
                        Text('(${productModel?.reviewsCount})')
                      ]),
                      isAd
                          ? SizedBox()
                          : const SizedBox(height: Dimensions.paddingSizeSmall),
                      isAd || productModel?.categoryId == 4
                          ? SizedBox() // stock
                          : (productModel?.currentStock ?? 0.00) < 10
                              ? Row(children: [
                                  Text.rich(TextSpan(children: [
                                    TextSpan(
                                        text:
                                            '${productModel?.currentStock ?? 0} ',
                                        style: textMedium.copyWith(
                                            color: UiColors.error,
                                            fontSize:
                                                Dimensions.fontSizeDefault)),
                                    TextSpan(
                                        text:
                                            '${getTranslated('in_stock', context)} ',
                                        style: textRegular.copyWith(
                                          fontSize: Dimensions.fontSizeDefault,
                                        ))
                                  ])),
                                  // Text.rich(TextSpan(children: [
                                  //   TextSpan(
                                  //       text:
                                  //           '${reviewController.reviewList != null ? reviewController.reviewList!.length : 0} ',
                                  //       style: textMedium.copyWith(
                                  //           color: Provider.of<ThemeController>(context,
                                  //                       listen: false)
                                  //                   .darkTheme
                                  //               ? Theme.of(context).hintColor
                                  //               : Theme.of(context).primaryColor,
                                  //           fontSize: Dimensions.fontSizeDefault)),
                                  //   TextSpan(
                                  //       text: '${getTranslated('reviews', context)} | ',
                                  //       style: textRegular.copyWith(
                                  //         fontSize: Dimensions.fontSizeDefault,
                                  //       ))
                                  // ])),
                                  // Text.rich(TextSpan(children: [
                                  //   TextSpan(
                                  //       text: '${details.orderCount} ',
                                  //       style: textMedium.copyWith(
                                  //           color: Provider.of<ThemeController>(context,
                                  //                       listen: false)
                                  //                   .darkTheme
                                  //               ? Theme.of(context).hintColor
                                  //               : Theme.of(context).primaryColor,
                                  //           fontSize: Dimensions.fontSizeDefault)),
                                  //   TextSpan(
                                  //       text: '${getTranslated('orders', context)} | ',
                                  //       style: textRegular.copyWith(
                                  //         fontSize: Dimensions.fontSizeDefault,
                                  //       ))
                                  // ])),
                                  // Text.rich(TextSpan(children: [
                                  //   TextSpan(
                                  //       text: '${details.wishCount} ',
                                  //       style: textMedium.copyWith(
                                  //           color: Provider.of<ThemeController>(context,
                                  //                       listen: false)
                                  //                   .darkTheme
                                  //               ? Theme.of(context).hintColor
                                  //               : Theme.of(context).primaryColor,
                                  //           fontSize: Dimensions.fontSizeDefault)),
                                  //   TextSpan(
                                  //       text:
                                  //           '${getTranslated('wish_listed', context)}',
                                  //       style: textRegular.copyWith(
                                  //         fontSize: Dimensions.fontSizeDefault,
                                  //       ))
                                  // ])),
                                ])
                              : SizedBox(),
                      const SizedBox(height: Dimensions.paddingSizeSmall),
                      productModel!.colors != null &&
                              productModel!.colors!.isNotEmpty
                          ? Row(children: [
                              Text(
                                  '${getTranslated('select_variant', context)} : ',
                                  style: titilliumRegular.copyWith(
                                      fontSize: Dimensions.fontSizeLarge)),
                              Expanded(
                                  child: SizedBox(
                                      height: 40,
                                      child: ListView.builder(
                                        itemCount: productModel!.colors!.length,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Center(
                                              child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius
                                                          .circular(Dimensions
                                                              .paddingSizeExtraSmall)),
                                                  child: Padding(
                                                      padding: const EdgeInsets
                                                          .all(Dimensions
                                                              .paddingSizeExtraSmall),
                                                      child: Container(
                                                        height: 20,
                                                        width: 20,
                                                        padding: const EdgeInsets
                                                            .all(Dimensions
                                                                .paddingSizeExtraSmall),
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorHelper
                                                              .hexCodeToColor(
                                                                  productModel
                                                                      ?.colors?[
                                                                          index]
                                                                      .code),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                      ))));
                                        },
                                      ))),
                            ])
                          : const SizedBox(),
                      productModel!.colors != null &&
                              productModel!.colors!.isNotEmpty
                          ? const SizedBox(height: Dimensions.paddingSizeSmall)
                          : const SizedBox(),
                      productModel!.choiceOptions != null &&
                              productModel!.choiceOptions!.isNotEmpty
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: productModel!.choiceOptions!.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          '${getTranslated('available', context)} ${productModel!.choiceOptions![index].title} :',
                                          style: titilliumRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeLarge)),
                                      const SizedBox(
                                          width:
                                              Dimensions.paddingSizeExtraSmall),
                                      Expanded(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: SizedBox(
                                                  height: 40,
                                                  child: ListView.builder(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      shrinkWrap: true,
                                                      itemCount: productModel!
                                                          .choiceOptions![index]
                                                          .options!
                                                          .length,
                                                      itemBuilder:
                                                          (context, i) {
                                                        return Center(
                                                            child: Padding(
                                                                padding: const EdgeInsets.only(
                                                                    right: Dimensions
                                                                        .paddingSizeDefault),
                                                                child: Text(
                                                                    productModel!
                                                                        .choiceOptions![
                                                                            index]
                                                                        .options![
                                                                            i]
                                                                        .trim(),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: textRegular.copyWith(
                                                                        fontSize:
                                                                            Dimensions.fontSizeLarge,
                                                                        color: Provider.of<ThemeController>(context, listen: false).darkTheme ? const Color(0xFFFFFFFF) : Theme.of(context).primaryColor))));
                                                      })))),
                                    ]);
                              },
                            )
                          : const SizedBox(),
                    ]);
              },
            ),
          )
        : const SizedBox();
  }
}
