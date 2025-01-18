import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_logged_in_bottom_sheet_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/add_details_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/controller/ad_details_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/chat_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/domain/models/product_details_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product_details/widgets/favourite_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/get_add_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/helper/price_converter.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/date_extention.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/text_function.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nb_utils/nb_utils.dart';

class AdvertiserProfileView extends ConsumerStatefulWidget {
  final UserModel user;
  const AdvertiserProfileView({
    super.key,
    required this.user,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AdvertiserProfileViewState();
}

class _AdvertiserProfileViewState extends ConsumerState<AdvertiserProfileView> {
  static const _pageSize = 10;

  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  _fetchPage(int pageKey) async {
    try {
      final filterResponse = await AppConstants.adsByAdvertiser.get(
          fromJson: FilterResponse.fromJson,
          data: {
            "ader_id": widget.user.id,
            "offset": pageKey,
            "limit": _pageSize
          });
      final isLastPage = filterResponse.products.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(filterResponse.products);
      } else {
        final nextPageKey = pageKey + filterResponse.products.length;
        _pagingController.appendPage(filterResponse.products, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: UiColors.white,
        appBar:
            CustomAppBar(title: "${widget.user?.fName} ${widget.user?.lName}"),
        body: ListView(
          children: [
            // 6.height,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
              // margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: boxDecorationDefault(
                  borderRadius: BorderRadius.circular(0),
                  color: UiColors.bgBlue,
                  boxShadow: [],
                  border: Border.all(color: UiColors.borderBlue)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.user?.fName} ${widget.user?.lName}",
                        style: textStyle(16).copyWith(
                            color: UiColors.darkBlue,
                            fontWeight: FontWeight.bold),
                      ),
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
                              height: 80,
                              width: 80,
                              child: CustomImageWidget(
                                  image: "${widget.user.imageFullUrl?.path}"))),
                    ],
                  ),
                  6.height,
                  Row(
                    children: [
                      Icon(
                        Icons.date_range_outlined,
                        size: 20,
                      ),
                      3.width,
                      Text("Member since".translate(context) + ":"),
                      2.width,
                      Text(
                        DateTime.parse("${widget.user.createdAt}")
                            .format()
                            .toString(),
                        style: textStyle(12).copyWith(
                            color: UiColors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  6.height,
                  Row(
                    children: [
                      Icon(
                        Icons.email_outlined,
                        size: 20,
                      ),
                      3.width,
                      Text("Email".translate(context) + ":"),
                      2.width,
                      Text(
                        "${widget.user.email}",
                        style: textStyle(12).copyWith(
                            color: UiColors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  6.height,
                  Row(
                    children: [
                      Icon(
                        Icons.phone_android_outlined,
                        size: 20,
                      ),
                      2.width,
                      Text("Phone".translate(context) + ":"),
                      3.width,
                      Text(
                        "${widget.user.phone}",
                        style: textStyle(12).copyWith(
                            color: UiColors.black,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  6.height,
                ],
              ),
            ),

            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -7,
                  child: Column(
                    children: [
                      Container(
                        decoration: boxDecorationDefault(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [],
                          color: UiColors.white,
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
                ),
                Column(
                  children: [
                    12.height,
                    PagedListView<int, Product>(
                      pagingController: _pagingController,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      builderDelegate: PagedChildBuilderDelegate<Product>(
                        itemBuilder: (context, item, index) => InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdDetails(
                                            productId: item.id,
                                            slug: item.slug,
                                          )));
                            },
                            child: AdWidgetBig(productModel: item)
                                .paddingBottom(8)),
                      ),
                    ).paddingSymmetric(horizontal: 8),
                  ],
                ),
              ],
            ),

            50.height,
          ],
        ));
  }
}

class AdWidgetBig extends ConsumerWidget {
  final Product productModel;
  const AdWidgetBig({super.key, required this.productModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderHelperWidget(
        function: (item) => Container(
              decoration: boxDecorationDefault(border: Border()),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                        itemCount: item.imagesFullUrl?.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) => Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CacheImage(
                                  height: 140,
                                  width: 200,
                                  image: '${item.imagesFullUrl?[index].path}',
                                  radius: 12,
                                ),
                                5.width
                              ],
                            )),
                  ),
                  // 8.height,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          PriceConverter.convertPrice(
                              context, productModel.unitPrice,
                              discountType: productModel.discountType,
                              discount: productModel.discount),
                          style: textStyle(13.72).copyWith(
                              color: UiColors.darkRed,
                              fontWeight: FontWeight.bold)),
                      FavouriteDetailsWidget(
                          backgroundColor: ColorResources.getImageBg(context),
                          productId: productModel!.id)
                    ],
                  ),
                  // 4.height,
                  Text(
                    "${item.name}",
                    style: textStyle(18).copyWith(
                        color: UiColors.black, fontWeight: FontWeight.bold),
                  ),
                  4.height,
                  ProviderHelperWidget(
                      function: (fields) {
                        return Wrap(
                          crossAxisAlignment: WrapCrossAlignment.start,
                          children: [
                            for (var element in fields)
                              Wrap(
                                children: [
                                  Text("${element.fieldName}: "),
                                  for (var it in element.value ?? [])
                                    Text(it + ", ")
                                ],
                              )
                          ],
                        );
                      },
                      listener: ref
                          .watch(getAddFieldListProvider(adId: item.id ?? 0))),
                  4.height,
                  Text("${DateTime.parse(productModel.createdAt!).timeAgo}"),
                  4.height,
                  Row(
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
                                  id: item!.userId,
                                  name:
                                      "${item?.ader?.fName} ${item?.ader?.lName}",
                                  userType: 2,
                                  image: "${item?.ader?.imageFullUrl?.path}",
                                ).launch(context)
                              : showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (_) =>
                                      const NotLoggedInBottomSheetWidget());
                        }),
                      ),
                      8.width,
                      item?.isCall == 2 || item?.isCall == 0
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
                                    ? makePhoneCall("${item?.phone}")
                                    : showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (_) =>
                                            const NotLoggedInBottomSheetWidget());
                              }))
                          : SizedBox.shrink(),
                      8.width,
                      item?.isCall == 2 || item?.isCall == 1
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
                                    ? openWhatsapp("${item?.phone}")
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
                ],
              ),
            ),
        listener: ref.watch(adDetailsProvider(productModel.slug.toString())));
  }
}
