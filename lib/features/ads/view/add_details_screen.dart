import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/view_ad_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/ad_field_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/advertiser_profile_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/controller/ad_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_specification_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_title_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/related_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/shop_info_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/youtube_video_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/shimmers/product_details_shimmer.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/update_ad/controller/edit_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/shop_product_view_list.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:latlong2/latlong.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetails extends StatefulWidget {
  final int? productId;
  final bool canEdit;
  final String? slug;
  final bool isFromWishList;
  const AdDetails(
      {super.key,
      required this.productId,
      required this.slug,
      this.isFromWishList = false,
      this.canEdit = false});

  @override
  State<AdDetails> createState() => _AdDetailsState();
}

class _AdDetailsState extends State<AdDetails>
    with SingleTickerProviderStateMixin {
  Size widgetSize = const Size(100, 400);

  _loadData(BuildContext context) async {
    Provider.of<ProductDetailsController>(context, listen: false)
        .getProductDetails(
            context, widget.productId.toString(), widget.slug.toString());
    Provider.of<ReviewController>(context, listen: false).removePrevReview();
    Provider.of<ProductDetailsController>(context, listen: false)
        .removePrevLink();
    // Provider.of<ReviewController>(context, listen: false)
    //     .getReviewList(widget.productId, widget.slug, context);
    Provider.of<ProductController>(context, listen: false)
        .removePrevRelatedProduct();
    Provider.of<ProductController>(context, listen: false)
        .initRelatedProductList(widget.productId.toString(), context);
    Provider.of<ProductDetailsController>(context, listen: false)
        .getCount(widget.productId.toString(), context);
    Provider.of<ProductDetailsController>(context, listen: false)
        .getSharableLink(widget.slug.toString(), context);
  }

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    Provider.of<ProductDetailsController>(context, listen: false)
        .selectReviewSection(false, isUpdate: false);
    afterBuildCreated(() {
      homeRef.watch(viewAdControllerProvider(id: widget.productId.toString()));
    });
    _loadData(context);
    super.initState();
  }

  late TabController tabController;
  int tab = 0;
  setTab(int i) {
    tab = i;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(title: "Ad Details".translate(context)),
      body: ProviderWidget(
          function: (productDetailsModel) => RefreshIndicator(
                onRefresh: () async {
                  homeRef.invalidate(adDetailsProvider(widget.slug.toString()));
                },
                child: SingleChildScrollView(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    child: Column(children: [
                      ProductImageWidget(
                          isAd: true,
                          canEdit: widget.canEdit,
                          productModel: productDetailsModel),
                      ProductTitleWidget(
                        productModel: productDetailsModel,
                        averageRatting:
                            productDetailsModel?.averageReview ?? "0",
                        isAd: true,
                      ),
                      // 8.height,
                      // SizedBox(
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   child: Center(
                      //     child: CustomSlidingSegmentedControl<int>(
                      //       // key: UniqueKey(),
                      //       padding: 7,
                      //       fromMax: true,
                      //       isStretch: true,
                      //       children: {
                      //         0: Text(
                      //           "Ad Details".translate(context),
                      //           textAlign: TextAlign.center,
                      //           style: textStyle(15).copyWith(
                      //               color: tab == 0
                      //                   ? UiColors.white
                      //                   : UiColors.medGrey),
                      //         ),
                      //         1: Text(
                      //           "description".translate(context),
                      //           textAlign: TextAlign.center,
                      //           style: textStyle(15).copyWith(
                      //               color: tab == 1
                      //                   ? UiColors.white
                      //                   : UiColors.medGrey),
                      //         ),
                      //       },
                      //       decoration: BoxDecoration(
                      //         color: Colors.grey[200],
                      //         borderRadius: BorderRadius.circular(16),
                      //       ),
                      //       thumbDecoration: BoxDecoration(
                      //         color: UiColors.darkBlue,
                      //         borderRadius: BorderRadius.circular(16),
                      //       ),
                      //       onValueChanged: (int value) {
                      //         print(value);
                      //         setTab(value);
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // 12.height,
                      // tab == 0
                      //     ?
                      AdFieldWidget(
                        id: widget.productId ?? 0,
                      ),
                      // : const SizedBox(),
                      // tab == 1
                      //     ?
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (productDetailsModel?.details != null &&
                                  productDetailsModel!.details!.isNotEmpty)
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      top: Dimensions.paddingSizeSmall),
                                  padding: const EdgeInsets.all(
                                      Dimensions.paddingSizeSmall),
                                  child: ProductSpecificationWidget(
                                    productSpecification:
                                        productDetailsModel!.details ?? '',
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      // : SizedBox(),
                      12.height,
                      productDetailsModel?.latitude == null
                          ? const SizedBox.shrink()
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Location".translate(context),
                                  style: textStyle(16).copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: UiColors.black),
                                ).paddingSymmetric(horizontal: 8),
                                // 12.height,
                                MapView(
                                        latitude:
                                            productDetailsModel?.latitude ??
                                                0.00,
                                        longitude:
                                            productDetailsModel?.longitude ??
                                                0.00)
                                    .paddingAll(8),
                              ],
                            ),
                      12.height,
                      Column(
                        children: [
                          (productDetailsModel != null)
                              ? productDetailsModel!.productType == 'ad'
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Seller Information"
                                                .translate(context),
                                            style: textStyle(16).copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: UiColors.black),
                                          ),
                                          12.height,
                                          InkWell(
                                            onTap: () {
                                              if (productDetailsModel?.ader !=
                                                  null) {
                                                AdvertiserProfileView(
                                                  user: productDetailsModel!
                                                      .ader!,
                                                ).launch(context);
                                              } else {}
                                            },
                                            child: AdvertiserWidget(
                                              user: productDetailsModel?.ader,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : ShopInfoWidget(
                                      sellerId: productDetailsModel!.addedBy ==
                                              'seller'
                                          ? productDetailsModel!.userId
                                              .toString()
                                          : "0")
                              : const SizedBox.shrink(),
                          12.height,
                          const SizedBox(
                            height: Dimensions.paddingSizeLarge,
                          ),
                        ],
                      ),
                      (productDetailsModel?.videoUrl != null &&
                              isValidYouTubeUrl(productDetailsModel!.videoUrl!))
                          ? YoutubeVideoWidget(
                              url: productDetailsModel!.videoUrl)
                          : const SizedBox(),
                      _ProductDetailsProductListWidget(
                          scrollController: scrollController),
                    ])),
              ),
          loadingShape: ProductDetailsShimmer(),
          listener: (ref) =>
              ref.watch(adDetailsProvider(widget.slug.toString()))),

      // RefreshIndicator(
      //   onRefresh: () async => _loadData(context),
      //   child: Consumer<ProductDetailsController>(
      //     builder: (context, details, child) {
      //       return SingleChildScrollView(
      //           controller: scrollController,
      //           physics: const BouncingScrollPhysics(),
      //           child: ! isDetails
      //               ? Column(children: [
      //                   ProductImageWidget(
      //                       canEdit: widget.canEdit,
      //                       productModel:  productDetailsModel),
      //                   ProductTitleWidget(
      //                       productModel:  productDetailsModel,
      //                       averageRatting:
      //                            productDetailsModel?.averageReview ??
      //                               "0"),
      //                   8.height,
      //                   Padding(
      //                     padding: const EdgeInsets.symmetric(horizontal: 12),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Expanded(
      //                           child: Column(
      //                             children: [
      //                               Text(
      //                                 "Ad Details".translate(context),
      //                                 style: textStyle(16).copyWith(
      //                                     color: tab == 0
      //                                         ? UiColors.darkBlue
      //                                         : UiColors.medGrey),
      //                               ),
      //                               6.height,
      //                               Container(
      //                                 color: tab == 0
      //                                     ? UiColors.darkBlue
      //                                     : UiColors.lightGrey,
      //                                 margin: const EdgeInsets.symmetric(
      //                                     horizontal: 2),
      //                                 child: Row(
      //                                   mainAxisSize: MainAxisSize.max,
      //                                   children: [2.height],
      //                                 ),
      //                               ),
      //                             ],
      //                           ).onTap(() {
      //                             setTab(0);
      //                           }),
      //                         ),
      //                         Expanded(
      //                           child: Column(
      //                             children: [
      //                               Text(
      //                                 "description".translate(context),
      //                                 style: textStyle(16).copyWith(
      //                                     color: tab == 1
      //                                         ? UiColors.darkBlue
      //                                         : UiColors.medGrey),
      //                               ),
      //                               6.height,
      //                               Container(
      //                                 color: tab == 1
      //                                     ? UiColors.darkBlue
      //                                     : UiColors.lightGrey,
      //                                 margin: const EdgeInsets.symmetric(
      //                                     horizontal: 2),
      //                                 child: Row(
      //                                   mainAxisSize: MainAxisSize.max,
      //                                   children: [2.height],
      //                                 ),
      //                               ),
      //                             ],
      //                           ).onTap(() {
      //                             setTab(1);
      //                           }),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                   12.height,
      //                   tab == 0
      //                       ? AdFieldWidget(
      //                           id: widget.productId ?? 0,
      //                         )
      //                       : const SizedBox(),
      //                   tab == 1
      //                       ? Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             ( productDetailsModel?.details !=
      //                                         null &&
      //                                      productDetailsModel!.details!
      //                                         .isNotEmpty)
      //                                 ? Container(
      //                                     margin: const EdgeInsets.only(
      //                                         top: Dimensions.paddingSizeSmall),
      //                                     padding: const EdgeInsets.all(
      //                                         Dimensions.paddingSizeSmall),
      //                                     child: ProductSpecificationWidget(
      //                                       productSpecification: details
      //                                               .productDetailsModel!
      //                                               .details ??
      //                                           '',
      //                                     ),
      //                                   )
      //                                 : const SizedBox(),
      //                           ],
      //                         )
      //                       : SizedBox(),
      //                   12.height,
      //                    productDetailsModel?.latitude == null
      //                       ? const SizedBox.shrink()
      //                       : Column(
      //                           crossAxisAlignment: CrossAxisAlignment.start,
      //                           children: [
      //                             Text(
      //                               "Location".translate(context),
      //                               style: textStyle(16).copyWith(
      //                                   fontWeight: FontWeight.bold,
      //                                   color: UiColors.black),
      //                             ).paddingSymmetric(horizontal: 8),
      //                             // 12.height,
      //                             MapView(
      //                                     latitude:  productDetailsModel
      //                                             ?.latitude ??
      //                                         0.00,
      //                                     longitude:  productDetailsModel
      //                                             ?.longitude ??
      //                                         0.00)
      //                                 .paddingAll(8),
      //                           ],
      //                         ),
      //                   12.height,
      //                   Column(
      //                     children: [
      //                       ( productDetailsModel != null)
      //                           ?  productDetailsModel!.productType ==
      //                                   'ad'
      //                               ? Padding(
      //                                   padding: const EdgeInsets.all(8.0),
      //                                   child: Column(
      //                                     crossAxisAlignment:
      //                                         CrossAxisAlignment.start,
      //                                     children: [
      //                                       Text(
      //                                         "Seller Information"
      //                                             .translate(context),
      //                                         style: textStyle(16).copyWith(
      //                                             fontWeight: FontWeight.bold,
      //                                             color: UiColors.black),
      //                                       ),
      //                                       12.height,
      //                                       InkWell(
      //                                         onTap: () {
      //                                           if ( productDetailsModel
      //                                                   ?.ader !=
      //                                               null) {
      //                                             AdvertiserProfileView(
      //                                               user: details
      //                                                   .productDetailsModel!
      //                                                   .ader!,
      //                                             ).launch(context);
      //                                           } else {}
      //                                         },
      //                                         child: AdvertiserWidget(
      //                                           user: details
      //                                               .productDetailsModel?.ader,
      //                                         ),
      //                                       ),
      //                                     ],
      //                                   ),
      //                                 )
      //                               : ShopInfoWidget(
      //                                   sellerId:  productDetailsModel!
      //                                               .addedBy ==
      //                                           'seller'
      //                                       ? details
      //                                           .productDetailsModel!.userId
      //                                           .toString()
      //                                       : "0")
      //                           : const SizedBox.shrink(),
      //                       12.height,
      //                       const SizedBox(
      //                         height: Dimensions.paddingSizeLarge,
      //                       ),
      //                     ],
      //                   ),
      //                   ( productDetailsModel?.videoUrl != null &&
      //                            isValidYouTubeUrl(
      //                                productDetailsModel!.videoUrl!))
      //                       ? YoutubeVideoWidget(
      //                           url:  productDetailsModel!.videoUrl)
      //                       : const SizedBox(),
      //                   _ProductDetailsProductListWidget(
      //                       scrollController: scrollController),
      //                 ])
      //               : const ProductDetailsShimmer());
      //     },
      //   ),
      // ),
      bottomNavigationBar: widget.canEdit
          ? ProviderWidget(
              loadingShape: const Center(
                child: CircularProgressIndicator(),
              ),
              function: (productDetailsModel) =>
                  productDetailsModel?.status == 0
                      ? const SizedBox.shrink()
                      : IgnorePointer(
                              child: CustomButton(
                          buttonText: productDetailsModel?.status == 1
                              ? "Deactivate".translate(context)
                              : "Activate".translate(context),
                          onTap: () {},
                        ))
                          .submit(
                              provider: updateAdStatusProvider,
                              onSuccess: (s) {
                                showCustomSnackBar("Success", context,
                                    isError: false);

                                // Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              onFailed: (s) {},
                              onTap: (ref) {
                                homeRef
                                    .read(updateAdStatusProvider.notifier)
                                    .updateStatus(
                                        statusId:
                                            productDetailsModel?.status == 1
                                                ? 2
                                                : 1,
                                        productId: widget.productId!);
                              })
                          .paddingAll(12),
              listener: (ref) =>
                  ref.watch(adDetailsProvider(widget.slug.toString())))
          : ProviderWidget(
              loadingShape: const Center(
                child: CircularProgressIndicator(),
              ),
              function: (productDetailsModel) => Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Flexible(
                          flex: 4,
                          child: Container(
                            decoration: boxDecorationDefault(
                                borderRadius: BorderRadius.circular(4),
                                boxShadow: [],
                                color: UiColors.darkBlue),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(Images.fiMessage,
                                    color: UiColors.white,
                                    height: Dimensions.iconSizeDefault),
                                8.width,
                                Text(
                                  "chat".translate(context),
                                  style: textStyle(16)
                                      .copyWith(color: UiColors.white),
                                ),
                              ],
                            ),
                          ).onTap(() {
                            isLoggedIn
                                ? ChatScreen(
                                    id: productDetailsModel!.userId,
                                    name:
                                        "${productDetailsModel?.ader?.fName} ${productDetailsModel?.ader?.lName}",
                                    userType: 2,
                                    image:
                                        "${productDetailsModel?.ader?.imageFullUrl?.path}",
                                  ).launch(context)
                                : showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (_) =>
                                        const NotLoggedInBottomSheetWidget());
                          }),
                        ),
                        8.width,
                        productDetailsModel?.isCall == 2 ||
                                productDetailsModel?.isCall == 0
                            ? Flexible(
                                flex: 4,
                                child: Container(
                                  decoration: boxDecorationDefault(
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [],
                                      color: UiColors.yello),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(Images.fiCall,
                                          height: Dimensions.iconSizeDefault),
                                      8.width,
                                      Text(
                                        "Call".translate(context),
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.black),
                                      ),
                                    ],
                                  ),
                                ).onTap(() {
                                  "makePhoneCall".log();
                                  isLoggedIn
                                      ? makePhoneCall(
                                          "${productDetailsModel?.phone}")
                                      : showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (_) =>
                                              const NotLoggedInBottomSheetWidget());
                                }))
                            : SizedBox.shrink(),
                        8.width,
                        productDetailsModel?.isCall == 2 ||
                                productDetailsModel?.isCall == 1
                            ? Flexible(
                                flex: 6,
                                child: Container(
                                  decoration: boxDecorationDefault(
                                      borderRadius: BorderRadius.circular(4),
                                      boxShadow: [],
                                      color: UiColors.green),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(Images.fiWhatsapp,
                                          height: Dimensions.iconSizeDefault),
                                      8.width,
                                      Text(
                                        "WhatsApp".translate(context),
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.white),
                                      ),
                                    ],
                                  ),
                                ).onTap(() {
                                  isLoggedIn
                                      ? openWhatsapp(
                                          "${productDetailsModel?.phone}")
                                      : showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (_) =>
                                              const NotLoggedInBottomSheetWidget());
                                }),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
              listener: (ref) =>
                  ref.watch(adDetailsProvider(widget.slug.toString())))

      //  ! isDetails
      // ? BottomCartWidget(product:  productDetailsModel)
      //     : const SizedBox();
      ,
    );
  }
}

class AdvertiserWidget extends StatelessWidget {
  final UserModel? user;
  const AdvertiserWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 13),
      decoration: boxDecorationDefault(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [],
          border: Border.all(color: UiColors.borderBlue)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          width: .5,
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(.125))),
                  height: 56,
                  width: 56,
                  child:
                      CustomImageWidget(image: "${user?.imageFullUrl?.path}"))),
          9.width,
          Column(
            children: [
              Text(
                "${user?.fName} ${user?.lName}",
                style: textStyle(16).copyWith(fontWeight: FontWeight.bold),
              ),
              3.height,
              Text(
                "View Profile".translate(context),
                style: textStyle(
                  16,
                ).copyWith(
                  fontWeight: FontWeight.bold,
                  color: UiColors.darkBlue,
                  decoration: TextDecoration.underline,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class MapView extends StatelessWidget {
  final double latitude;
  final double longitude;
  const MapView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            height: 156,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(latitude, longitude),
                initialZoom: 8,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.intelligentprojects.adyuser',
                ),
              ],
            ),
          ),
        ),
        Container(
          decoration: boxDecorationDefault(
              boxShadow: [], color: Colors.white.withOpacity(0.2)),
          height: 156,
          child: Column(
            children: [
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: boxDecorationDefault(
                        boxShadow: [],
                        color: Color(0xFFF0F7FF),
                        border: Border.all(color: Color(0xFF014bac)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Open Location".translate(context),
                      style:
                          titilliumRegular.copyWith(color: Color(0xFF014bac)),
                    ),
                  ).onTap(() {
                    openMap(latitude, longitude);
                  }),
                ],
              ),
              Spacer()
            ],
          ),
        )
      ],
    );
  }
}

class _ProductDetailsProductListWidget extends StatelessWidget {
  const _ProductDetailsProductListWidget({
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductDetailsController>(
        builder: (context, productDetailsController, _) {
      return Column(children: [
        Consumer<SellerProductController>(
            builder: (context, sellerProductController, _) {
          return (sellerProductController.sellerProduct != null &&
                  sellerProductController.sellerProduct!.products != null &&
                  sellerProductController.sellerProduct!.products!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeDefault),
                  child: TitleRowWidget(
                    title: getTranslated('more_from_the_shop', context),
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => TopSellerProductScreen(
                      //               fromMore: true,
                      //               sellerId: productDetailsController
                      //                   .productDetailsModel?.seller?.id,
                      //               temporaryClose: productDetailsController
                      //                   .productDetailsModel
                      //                   ?.seller
                      //                   ?.shop
                      //                   ?.temporaryClose,
                      //               vacationStatus: productDetailsController
                      //                       .productDetailsModel
                      //                       ?.seller
                      //                       ?.shop
                      //                       ?.vacationStatus ??
                      //                   false,
                      //               vacationEndDate: productDetailsController
                      //                   .productDetailsModel
                      //                   ?.seller
                      //                   ?.shop
                      //                   ?.vacationEndDate,
                      //               vacationStartDate: productDetailsController
                      //                   .productDetailsModel
                      //                   ?.seller
                      //                   ?.shop
                      //                   ?.vacationStartDate,
                      //               name: productDetailsController
                      //                   .productDetailsModel
                      //                   ?.seller
                      //                   ?.shop
                      //                   ?.name,
                      //               banner: productDetailsController
                      //                   .productDetailsModel
                      //                   ?.seller
                      //                   ?.shop
                      //                   ?.bannerFullUrl
                      //                   ?.path,
                      //               image: productDetailsController
                      //                   .productDetailsModel
                      //                   ?.seller
                      //                   ?.shop
                      //                   ?.imageFullUrl
                      //                   ?.path,
                      //             )));
                    },
                  ),
                )
              : const SizedBox();
        }),
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: ShopProductViewList(
                scrollController: scrollController,
                sellerId:
                    productDetailsController.productDetailsModel!.userId!)),
        Consumer<ProductController>(builder: (context, productController, _) {
          return (productController.relatedProductList != null &&
                  productController.relatedProductList!.isNotEmpty)
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Dimensions.paddingSizeExtraSmall),
                  child: TitleRowWidget(
                      title: getTranslated('related_products', context),
                      isDetailsPage: true))
              : const SizedBox();
        }),
        const SizedBox(height: 5),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
          child: RelatedProductWidget(),
        ),
        const SizedBox(height: Dimensions.paddingSizeSmall),
      ]);
    });
  }
}

Future<void> makePhoneCall(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> openWhatsapp(String phoneNumber) async {
  if (!await launchUrl(Uri(scheme: 'https', path: "wa.me/$phoneNumber"))) {
    throw Exception('Could not launch https://wa.me/$phoneNumber');
  }
}

Future<void> openMap(latitude, longitude) async {
  if (!await launchUrl(Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${latitude},${longitude}'))) {
    throw Exception('Could not launch Url');
  }
}
