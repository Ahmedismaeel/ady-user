import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/controller/ad_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/controllers/seller_product_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/controllers/product_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/bottom_cart_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_specification_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/product_title_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/promise_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/related_product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/review_and_specification_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/shop_info_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/youtube_video_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/controllers/review_controller.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/review/widgets/review_section.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/screens/shop_screen.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/title_row_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/shop/widgets/shop_product_view_list.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final int? productId;
  final String? slug;
  final bool isFromWishList;
  final String? productType;
  const ProductDetails(
      {super.key,
      required this.productId,
      required this.slug,
      this.isFromWishList = false,
      required this.productType});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Size widgetSize = const Size(100, 400);

  _loadData(BuildContext context) async {
    Provider.of<ProductDetailsController>(context, listen: false)
        .getProductDetails(
            context, widget.productId.toString(), widget.slug.toString());
    Provider.of<ReviewController>(context, listen: false).removePrevReview();
    Provider.of<ProductDetailsController>(context, listen: false)
        .removePrevLink();
    Provider.of<ReviewController>(context, listen: false)
        .getReviewList(widget.productId, widget.slug, context);
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
    Provider.of<ProductDetailsController>(context, listen: false)
        .selectReviewSection(false, isUpdate: false);
    _loadData(context);
    super.initState();
  }

  bool isReview = false;
  setIsReview(_) {
    isReview = _;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Scaffold(
        appBar: CustomAppBar(
            title: Provider.of<ProductDetailsController>(context, listen: true)
                        .productDetailsModel
                        ?.categoryId ==
                    4
                ? getTranslated('service_details', context)
                : getTranslated('product_details', context)),
        body: ProviderWidget(
            loadingShape: const Center(
              child: CircularProgressIndicator(),
            ),
            function: (productDetailsModel) => RefreshIndicator(
                onRefresh: () async => _loadData(context),
                child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        ProductImageWidget(
                          productModel: productDetailsModel,
                          isAd: false,
                        ),
                        Column(
                          children: [
                            ProductTitleWidget(
                              productModel: productDetailsModel,
                              averageRatting:
                                  productDetailsModel?.averageReview ?? "0",
                              isAd: false,
                            ),
                            // ReviewAndSpecificationSectionWidget(
                            //   setReview: (_) {
                            //     setIsReview(_);
                            //   },
                            //   isReview: isReview,
                            // ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: CustomSlidingSegmentedControl<int>(
                                  // key: UniqueKey(),
                                  padding: 7,
                                  fromMax: true,
                                  children: {
                                    0: Text(
                                      "specification".translate(context),
                                      textAlign: TextAlign.center,
                                      style: textStyle(15).copyWith(
                                          color: !isReview
                                              ? UiColors.white
                                              : UiColors.medGrey),
                                    ),
                                    1: Text(
                                      "reviews".translate(context),
                                      textAlign: TextAlign.center,
                                      style: textStyle(15).copyWith(
                                          color: isReview
                                              ? UiColors.white
                                              : UiColors.medGrey),
                                    ),
                                  },
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  thumbDecoration: BoxDecoration(
                                    color: UiColors.darkBlue,
                                    borderRadius: BorderRadius.circular(16),
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
                                    setIsReview(value == 1);
                                    // setPage(value);
                                  },
                                ),
                              ),
                            ),
                            isReview
                                ? Column(children: [
                                    ReviewSection(
                                        productDetailsModel:
                                            productDetailsModel),
                                    _ProductDetailsProductListWidget(
                                        scrollController: scrollController),
                                  ])
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      (productDetailsModel?.details != null &&
                                              productDetailsModel
                                                      ?.details?.isNotEmpty ==
                                                  true)
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  top: Dimensions
                                                      .paddingSizeSmall),
                                              padding: const EdgeInsets.all(
                                                  Dimensions.paddingSizeSmall),
                                              child: ProductSpecificationWidget(
                                                productSpecification:
                                                    productDetailsModel
                                                            ?.details ??
                                                        '',
                                              ),
                                            )
                                          : const SizedBox(),
                                      (productDetailsModel?.videoUrl != null &&
                                              isValidYouTubeUrl(
                                                  productDetailsModel
                                                          ?.videoUrl ??
                                                      ""))
                                          ? YoutubeVideoWidget(
                                              url: productDetailsModel
                                                      ?.videoUrl ??
                                                  "")
                                          : const SizedBox(),
                                      (productDetailsModel != null)
                                          ? ShopInfoWidget(
                                              sellerId: productDetailsModel
                                                          ?.addedBy ==
                                                      'seller'
                                                  ? productDetailsModel?.userId
                                                          .toString() ??
                                                      "0"
                                                  : "0")
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: Dimensions.paddingSizeLarge,
                                      ),
                                      // Container(
                                      //     padding: const EdgeInsets.only(
                                      //         top: Dimensions.paddingSizeLarge,
                                      //         bottom: Dimensions
                                      //             .paddingSizeDefault),
                                      //     decoration: BoxDecoration(
                                      //         color:
                                      //             Theme.of(context).cardColor),
                                      //     child: const PromiseWidget()),
                                      _ProductDetailsProductListWidget(
                                          scrollController: scrollController),
                                    ],
                                  ),
                          ],
                        ),
                      ],
                    ))),
            listener: (ref) =>
                ref.watch(adDetailsProvider(widget.slug.toString()))),
        bottomNavigationBar: ProviderWidget(
            function: (productDetailsModel) =>
                BottomCartWidget(product: productDetailsModel),
            listener: (ref) =>
                ref.watch(adDetailsProvider(widget.slug.toString()))));
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
            builder: (_c, sellerProductController, _) {
          return (sellerProductController.sellerProduct != null &&
                  sellerProductController.sellerProduct?.products != null &&
                  sellerProductController.sellerProduct?.products?.isNotEmpty ==
                      true)
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: Dimensions.paddingSizeDefault),
                      child: TitleRowWidget(
                        title: getTranslated('more_from_the_shop', context),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => TopSellerProductScreen(
                                        // crNumber:
                                        //     "${productDetailsController.productDetailsModel?.seller?.shop?.crNumber}",
                                        // socialMedia:
                                        //     "${productDetailsController.productDetailsModel?.seller?.shop?.socialMedia}",
                                        // description:
                                        //     "${productDetailsController.productDetailsModel?.seller?.shop?.description}",
                                        fromMore: true,
                                        sellerId: productDetailsController
                                            .productDetailsModel?.seller?.id,
                                        // temporaryClose: productDetailsController
                                        //     .productDetailsModel
                                        //     ?.seller
                                        //     ?.shop
                                        //     ?.temporaryClose,
                                        // vacationStatus: productDetailsController
                                        //         .productDetailsModel
                                        //         ?.seller
                                        //         ?.shop
                                        //         ?.vacationStatus ??
                                        //     false,
                                        // vacationEndDate:
                                        //     productDetailsController
                                        //         .productDetailsModel
                                        //         ?.seller
                                        //         ?.shop
                                        //         ?.vacationEndDate,
                                        // vacationStartDate:
                                        //     productDetailsController
                                        //         .productDetailsModel
                                        //         ?.seller
                                        //         ?.shop
                                        //         ?.vacationStartDate,
                                        // name: productDetailsController
                                        //     .productDetailsModel
                                        //     ?.seller
                                        //     ?.shop
                                        //     ?.name,
                                        // banner: productDetailsController
                                        //     .productDetailsModel
                                        //     ?.seller
                                        //     ?.shop
                                        //     ?.bannerFullUrl
                                        //     ?.path,
                                        // image: productDetailsController
                                        //     .productDetailsModel
                                        //     ?.seller
                                        //     ?.shop
                                        //     ?.imageFullUrl
                                        //     ?.path,
                                      )));
                        },
                      ),
                    ),
                  ],
                )
              : const SizedBox();
        }),
        Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            child: ShopProductViewList(
                scrollController: scrollController,
                sellerId:
                    productDetailsController.productDetailsModel?.userId ?? 0)),
        Consumer<ProductController>(builder: (context, productController, _) {
          return (productController.relatedProductList != null &&
                  productController.relatedProductList?.isNotEmpty == true)
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
