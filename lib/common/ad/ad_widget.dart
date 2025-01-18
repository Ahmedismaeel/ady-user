import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/add_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AdWidget extends StatelessWidget {
  final Product productModel;
  final int productNameLine;
  final bool canEdit;
  const AdWidget(
      {super.key,
      required this.productModel,
      this.productNameLine = 2,
      this.canEdit = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        AdDetails(
          productId: productModel.id,
          slug: productModel.slug,
          canEdit: canEdit,
        ).launch(context);
      },
      child: Container(
          // margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Theme.of(context).cardColor,
            color: UiColors.white,
            border: Border.all(color: UiColors.borderBlue),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).primaryColor.withOpacity(0.05),
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(9, 5),
              )
            ],
          ),
          child: Stack(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              LayoutBuilder(
                  builder: (context, boxConstraint) => ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radiusDefault),
                          topRight: Radius.circular(Dimensions.radiusDefault),
                        ),
                        child: Stack(
                          children: [
                            CustomImageWidget(
                              image: '${productModel.thumbnailFullUrl?.path}',
                              fit: BoxFit.cover,
                              height: boxConstraint.maxWidth,
                              width: boxConstraint.maxWidth,
                            ),
                            if (productModel.currentStock! == 0 &&
                                productModel.productType == 'physical') ...[
                              Container(
                                height: boxConstraint.maxWidth * 0.82,
                                width: boxConstraint.maxWidth,
                                color: Colors.black.withOpacity(0.4),
                              ),
                              // Positioned.fill(
                              //     child: Align(
                              //   alignment: Alignment.bottomCenter,
                              //   child: Container(
                              //     width: boxConstraint.maxWidth,
                              //     decoration: BoxDecoration(
                              //         color: Theme.of(context)
                              //             .colorScheme
                              //             .error
                              //             .withOpacity(0.4),
                              //         borderRadius: const BorderRadius.only(
                              //           topLeft: Radius.circular(
                              //               Dimensions.radiusSmall),
                              //           topRight: Radius.circular(
                              //               Dimensions.radiusSmall),
                              //         )),
                              //     child: Text(
                              //       getTranslated('out_of_stock', context) ?? '',
                              //       style: textBold.copyWith(
                              //           color: Colors.white,
                              //           fontSize: Dimensions.fontSizeSmall),
                              //       textAlign: TextAlign.center,
                              //     ),
                              //   ),
                              // )),
                            ],
                          ],
                        ),
                      )),

              // Product Details
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  // if (ratting > 0)
                  //   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //     const Icon(Icons.star_rate_rounded,
                  //         color: Colors.orange, size: 20),
                  //     Padding(
                  //       padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  //       child: Text(ratting.toStringAsFixed(1),
                  //           style: textRegular.copyWith(
                  //               fontSize: Dimensions.fontSizeDefault)),
                  //     ),
                  //     Text('(${productModel.reviewCount.toString()})',
                  //         style: textRegular.copyWith(
                  //             fontSize: Dimensions.fontSizeSmall,
                  //             color: Theme.of(context).hintColor))
                  //   ]),

                  Text(productModel.name ?? '',
                      textAlign: TextAlign.start,
                      style: textStyle(14).copyWith(
                          color: UiColors.darkGrey,
                          fontWeight: FontWeight.bold),
                      maxLines: productNameLine,
                      overflow: TextOverflow.ellipsis),

                  // productModel.discount != null && productModel.discount! > 0
                  //     ? Text(
                  //         PriceConverter.convertPrice(
                  //             context, productModel.unitPrice),
                  //         style: titleRegular.copyWith(
                  //             color: Theme.of(context).hintColor,
                  //             decoration: TextDecoration.lineThrough,
                  //             fontSize: Dimensions.fontSizeSmall))
                  //     : const SizedBox.shrink(),

                  4.height,
                  Text(
                    DateTime.parse(productModel.createdAt!).timeAgo,
                    style: textStyle(11)
                        .copyWith(color: Theme.of(context).hintColor),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  !canEdit
                      ? SizedBox()
                      : Text(
                          "${productModel.views}" +
                              " " +
                              "Views".translate(context),
                          style:
                              textStyle(12).copyWith(color: UiColors.medGrey),
                          textAlign: TextAlign.center,
                        ),
                  !canEdit
                      ? SizedBox()
                      : const SizedBox(
                          height: Dimensions.paddingSizeExtraSmall),
                ],
              ).paddingSymmetric(horizontal: 8),
            ]),

            // Off

            // productModel.discount! > 0
            //     ? Positioned(
            //         top: 10,
            //         left: 10,
            //         child: Container(
            //             // transform: Matrix4.translationValues(-1, 0, 0),
            //             padding: const EdgeInsets.symmetric(
            //                 horizontal: Dimensions.paddingSizeSmall, vertical: 7),
            //             decoration: BoxDecoration(
            //                 color: Theme.of(context).primaryColor,
            //                 borderRadius: BorderRadius.circular(3)),
            //             child: Center(
            //                 child: Directionality(
            //               textDirection: TextDirection.ltr,
            //               child: Text(
            //                 PriceConverter.percentageCalculation(
            //                     context,
            //                     productModel.unitPrice,
            //                     productModel.discount,
            //                     productModel.discountType),
            //                 style: textStyle(12).copyWith(
            //                     color: Colors.white,
            //                     fontSize: Dimensions.fontSizeSmall),
            //                 textAlign: TextAlign.center,
            //               ),
            //             ))))
            //     : const SizedBox.shrink(),

            Positioned(
              // top: 0,
              // right: 0,
              bottom: 0,
              left: 0,
              child: Container(
                // decoration: boxDecorationDefault(
                //     color: UiColors.borderBlue,
                //     boxShadow: [],
                //     borderRadius: const BorderRadius.only(
                //         bottomLeft: Radius.circular(10),
                //         topRight: Radius.circular(10))),
                child: FavouriteButtonWidget(
                  backgroundColor: ColorResources.getImageBg(context),
                  productId: productModel.id,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: Column(
                  children: [
                    productModel.discount != null && productModel.discount! > 0
                        ? Text(
                            PriceConverter.convertPrice(
                                context, productModel.unitPrice),
                            style: titleRegular.copyWith(
                                color: Theme.of(context).hintColor,
                                decoration: TextDecoration.lineThrough,
                                fontSize: Dimensions.fontSizeSmall))
                        : const SizedBox.shrink(),
                    4.height,
                    Text(
                        PriceConverter.convertPrice(
                            context, productModel.unitPrice,
                            discountType: productModel.discountType,
                            discount: productModel.discount),
                        style: textStyle(13.72).copyWith(
                            color: UiColors.darkBlue,
                            fontWeight: FontWeight.bold)),
                  ],
                ).paddingOnly(bottom: 8, right: 8, left: 8))
          ])),

      // Container(
      //   margin: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
      //   decoration: BoxDecoration(
      //       borderRadius: BorderRadius.circular(10),
      //       border: Border.all(color: UiColors.borderBlue),
      //       color: UiColors.white
      //       // boxShadow: [
      //       //   BoxShadow(
      //       //     color: Theme.of(context).primaryColor.withOpacity(0.05),
      //       //     spreadRadius: 0,
      //       //     blurRadius: 10,
      //       //     offset: const Offset(9, 5),
      //       //   )
      //       // ],
      //       ),
      //   child: ClipRRect(
      //     borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      //     child: Row(children: [
      //       Flexible(
      //         flex: 1,
      //         child: Stack(
      //           children: [
      //             CustomImageWidget(
      //               image: '${productModel.thumbnailFullUrl?.path}',
      //               fit: BoxFit.cover,
      //               height: 130,
      //               width: 164,
      //             ),
      //             SizedBox(
      //               width: 164,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   Container(
      //                     decoration: boxDecorationDefault(
      //                         color: UiColors.borderBlue,
      //                         boxShadow: [],
      //                         borderRadius: getLang()
      //                             ? BorderRadius.only(
      //                                 bottomLeft: Radius.circular(10))
      //                             : BorderRadius.only(
      //                                 bottomRight: Radius.circular(10))),
      //                     child: FavouriteButtonWidget(
      //                       backgroundColor: ColorResources.getImageBg(context),
      //                       productId: productModel.id,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             )
      //           ],
      //         ),
      //       ),

      //       // Product Details
      //       Flexible(
      //         flex: 1,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: [
      //             Row(),
      //             Padding(
      //                 padding: const EdgeInsets.symmetric(
      //                     vertical: 5.0,
      //                     horizontal: Dimensions.paddingSizeSmall),
      //                 child: Text(productModel.name ?? '',
      //                     textAlign: TextAlign.center,
      //                     style:
      //                         textStyle(14).copyWith(color: UiColors.darkGrey),
      //                     maxLines: productNameLine,
      //                     overflow: TextOverflow.ellipsis)),
      //             12.height,
      //             Text(
      //                 PriceConverter.convertPrice(
      //                     context, productModel.unitPrice,
      //                     discountType: productModel.discountType,
      //                     discount: productModel.discount),
      //                 style: textStyle(16).copyWith(
      //                     color: UiColors.darkBlue,
      //                     fontWeight: FontWeight.bold)),
      //             12.height,
      //             Text(
      //               "Updated at".translate(context) +
      //                   " " +
      //                   " ${DateTime.tryParse(productModel.createdAt ?? "")?.format()}",
      //               style: textStyle(12).copyWith(color: UiColors.medGrey),
      //               textAlign: TextAlign.center,
      //             ),
      //             3.height,
      //             Text(
      //               "${productModel.views}" + " " + "Views".translate(context),
      //               style: textStyle(12).copyWith(color: UiColors.medGrey),
      //               textAlign: TextAlign.center,
      //             )
      //           ],
      //         ),
      //       ),
      //     ]),
      //   ),
      // ),
    );
  }
}
