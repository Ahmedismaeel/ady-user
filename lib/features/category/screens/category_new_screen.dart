import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/product_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_reponse.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_ad_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_result_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/controllers/ad_filter_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/helper/bottom_sheet.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/screens/sub_sub_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/chat/screens/inbox_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/models/navigation_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/controller/latest_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/screens/latest_product_home_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/home/widgets/search_home_page_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/screens/more_screen_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_ad_category.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/images.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_image_widget.dart';
import 'package:url_launcher/url_launcher.dart';

final categoryProvider = StateProvider<CategoryModel?>((ref) {
  return null;
});

class CategoryNewScreen extends ConsumerStatefulWidget {
  const CategoryNewScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CategoryNewScreenState();
}

class _CategoryNewScreenState extends ConsumerState<CategoryNewScreen> {
  int page = 0;
  setPage(int p) {
    page = p;
    setState(() {});
  }

  @override
  void initState() {
    afterBuildCreated(() {
      // setTheme(widget.category.color!.fromHex());
    });
    super.initState();
  }

  @override
  void dispose() {
    Future.microtask(() {
      resetTheme();
    });
    resetTheme();
    "dispose".log();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: widget.category.color!.fromHex(),
      // bottomNavigationBar: Stack(
      //   clipBehavior: Clip.none,
      //   children: [
      //     Container(
      //         height: 68,
      //         decoration: BoxDecoration(
      //           borderRadius: const BorderRadius.vertical(
      //               top: Radius.circular(Dimensions.paddingSizeLarge)),
      //           // color: Theme.of(context).cardColor,
      //           // color: Colors.transparent,
      //           boxShadow: [
      //             BoxShadow(
      //                 offset: const Offset(1, 1),
      //                 blurRadius: 2,
      //                 spreadRadius: 1,
      //                 color: Theme.of(context).primaryColor.withOpacity(.125))
      //           ],
      //         ),
      //         child: Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: getBottomWidget(screens: [
      //               NavigationModel(
      //                   name: 'home'.translate(context),
      //                   icon: Images.homeImage,
      //                   screen: HomeWidget(
      //                     category: ref.watch(categoryProvider)!,
      //                   )),
      //               NavigationModel(
      //                   name: 'inbox'.translate(context),
      //                   icon: Images.officeImage,
      //                   screen: const InboxScreen(isBackButtonExist: true),
      //                   showCartIcon: true),
      //               NavigationModel(
      //                   name: 'account'.translate(context),
      //                   icon: Images.moreImage,
      //                   screen: const MoreScreen()),
      //             ], pageIndex: page, setPage: setPage))),
      //     Positioned(
      //       bottom: 12,
      //       right: 12,
      //       left: 12,
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Row(
      //             children: [
      //               4.width,
      //               Container(
      //                 width: 47,
      //                 height: 47,
      //                 decoration: boxDecorationDefault(
      //                     boxShadow: [],
      //                     // shape: BoxShape.circle,
      //                     color: Colors.transparent,
      //                     image: const DecorationImage(
      //                         image: AssetImage("assets/images/add.png"))),
      //                 child: const Center(
      //                   child: Icon(
      //                     Icons.add,
      //                     size: 27,
      //                     color: UiColors.white,
      //                   ),
      //                 ),
      //               ).onTap(() {
      //                 const SelectAddCategory().launch(context,
      //                     pageRouteAnimation: PageRouteAnimation.Fade);
      //               })
      //             ],
      //           ),
      //           2.height,
      //           Text(
      //             "Create Ad".translate(context),
      //             textAlign: TextAlign.center,
      //             style: textStyle(12).copyWith(fontWeight: FontWeight.bold),
      //           ),
      //           10.height,
      //         ],
      //       ),
      //     )
      //   ],
      // ),

      body: [
        NavigationModel(
            name: 'home'.translate(context),
            icon: Images.homeImage,
            screen: HomeWidget(
              category: ref.watch(categoryProvider)!,
            )),
        NavigationModel(
            name: 'inbox'.translate(context),
            icon: Images.officeImage,
            screen: const InboxScreen(isBackButtonExist: true),
            showCartIcon: true),
        NavigationModel(
            name: 'account'.translate(context),
            icon: Images.moreImage,
            screen: const MoreScreen()),
      ][page]
          .screen,
    );
  }
}

class HomeWidget extends StatefulWidget {
  final CategoryModel category;
  const HomeWidget({super.key, required this.category});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Color getColor() {
    switch (widget.category.id) {
      case 1:
        return const Color(0xFFFFCC01);
      case 2:
        return const Color(0xFF00A60B);
      case 3:
        return UiColors.darkBlue;
      case 4:
        return UiColors.darkRed;
      default:
        return widget.category.color!.fromHex();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.white,
      appBar: CustomAppBar(
        title: "${widget.category.name}",
        textColor: widget.category.id == 1 ? Colors.black : Colors.white,
        backGroundColor: getColor(),
      ),
      body: Consumer(builder: (_, ref, w) {
        return Container(
          // color: Colors.white.withOpacity(0.7),
          color: UiColors.white,
          // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              ref.invalidate(latestAutoAdsProvider);

              ref.invalidate(latestRealStateAdsProvider);
              ref.invalidate(latestServiceAdsProvider);
              ref.invalidate(latestProductAdsProvider);
              ref.invalidate(latestProductProvider);
              ref.invalidate(latestServiceProvider);
              await Future.delayed(const Duration(seconds: 1));

              // return true;
            },
            child: ListView(
              children: [
                12.height,
                InkWell(
                  onTap: () {
                    ref
                        .read(filterDataProvider.notifier)
                        .updateCategory(widget.category);
                    const SearchAdPage().launch(context,
                        pageRouteAnimation: PageRouteAnimation.Fade);
                  },
                  child: Hero(
                      tag: "SearchText",
                      child: Material(
                          child: SearchHomePageWidget(
                        backgroundColor: Colors.white,
                        color: getColor(),
                      ))),
                ).paddingBottom(0),
                // Container(
                //   height: 40,
                //   // padding: const EdgeInsets.only(left: 12, right: 3),
                //   decoration: boxDecorationDefault(
                //       boxShadow: [],
                //       borderRadius: BorderRadius.circular(999),
                //       border: Border.all(
                //           color: getColor(),
                //           style: BorderStyle.solid,
                //           width: 2)),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         children: [
                //           12.width,
                //           Text(
                //             "search".translate(context),
                //             style: const TextStyle(fontSize: 16),
                //           ),
                //         ],
                //       ),
                //       Row(
                //         children: [
                //           Container(
                //             decoration: boxDecorationDefault(
                //                 color: getColor(), //UiColors.darkBlue,
                //                 boxShadow: [],
                //                 borderRadius: BorderRadius.circular(90)),
                //             padding: const EdgeInsets.symmetric(
                //                 horizontal: 8, vertical: 8),
                //             child: const Icon(Icons.search,
                //                 size: 16, color: UiColors.white),
                //           ),
                //           3.width
                //         ],
                //       )
                //     ],
                //   ),
                // ).onTap(() {
                //   ref
                //       .read(filterDataProvider.notifier)
                //       .updateCategory(widget.category);
                //   const SearchAdPage().launch(context,
                //       pageRouteAnimation: PageRouteAnimation.Fade);
                // }),
                12.height,
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  child: Column(
                    children: [
                      widget.category.images.isEmpty
                          ? const SizedBox.shrink()
                          : SizedBox(
                              height: MediaQuery.of(context).size.width * 0.33,
                              width: MediaQuery.of(context).size.width,
                              child: CarouselSlider.builder(
                                options: CarouselOptions(
                                    aspectRatio: 343 / 136,
                                    viewportFraction: 0.8,
                                    autoPlay: true,
                                    pauseAutoPlayOnTouch: true,
                                    pauseAutoPlayOnManualNavigate: true,
                                    pauseAutoPlayInFiniteScroll: true,
                                    enlargeFactor: .2,
                                    enlargeCenterPage: true,
                                    disableCenter: true,
                                    onPageChanged: (index, reason) {}),
                                itemCount: widget.category.images.length,
                                itemBuilder: (context, index, _) {
                                  return InkWell(
                                      onTap: () async {
                                        try {
                                          !await launchUrl(Uri.parse(widget
                                                  .category.images[index].url ??
                                              ""));
                                        } catch (e) {
                                          toast("Invalid Url");
                                        }
                                      },
                                      child: Container(
                                        decoration: boxDecorationDefault(
                                          boxShadow: [],
                                          // border: Border.all(
                                          //   width: 2,
                                          //   color: getColor(),
                                          // ),
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.paddingSizeSmall),
                                        ),
                                        padding: const EdgeInsets.all(0),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.paddingSizeSmall -
                                                    2),
                                            child: CustomImageWidget(
                                                image: widget.category
                                                        .images[index].path ??
                                                    "")),
                                      ));
                                },
                              ),
                            ),
                      12.height,
                      SubCategoryWidget(
                        category: widget.category,
                        key: UniqueKey(),
                      ),
                      12.height,
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        decoration: boxDecorationDefault(),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 220,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Discover".translate(context) +
                                            " " +
                                            "${widget.category.name}" +
                                            " " +
                                            "On Map".translate(context),
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.darkBlue),
                                      ),
                                      4.height,
                                      Text(
                                        "Explore visually for better"
                                                .translate(context) +
                                            " " +
                                            "${widget.category.name}" +
                                            " " +
                                            "search experience"
                                                .translate(context),
                                        style: textStyle(12)
                                            .copyWith(color: UiColors.medGrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  Images.fiMap,
                                  width: 70,
                                )
                              ],
                            ),
                            12.height,
                            CustomButton(
                              backgroundColor: getColor(),
                              buttonText: 'Show Nearby'.translate(context),
                              onTap: () {
                                ref
                                    .read(filterDataProvider.notifier)
                                    .updateCategory(widget.category);
                                const SearchResultView(
                                  pageIndex: 3,
                                  searchText: null,
                                ).launch(context,
                                    pageRouteAnimation:
                                        PageRouteAnimation.Fade);
                              },
                            ).paddingSymmetric(horizontal: 20),
                          ],
                        ),
                      ),
                      18.height,
                      switch (widget.category.id!) {
                        3 => LatestSection(
                            key: UniqueKey(),
                            type: BaseCategory.eProduct,
                            title: "Latest Products".translate(context),
                          ).paddingBottom(12),
                        4 => LatestSection(
                            key: UniqueKey(),
                            type: BaseCategory.eService,
                            title: "Latest Products".translate(context),
                          ).paddingBottom(12),
                        int() => const SizedBox.shrink(),
                      },
                      12.height,
                      LatestSection(
                        key: UniqueKey(),
                        type: switch (widget.category.id!) {
                          1 => BaseCategory.auto,
                          2 => BaseCategory.realState,
                          3 => BaseCategory.product,
                          4 => BaseCategory.service,
                          int() => throw UnimplementedError(),
                        },
                        title: "Latest Ads".translate(context),
                      ),
                      20.height,
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}

class LatestAdsSection extends ConsumerStatefulWidget {
  const LatestAdsSection({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LatestAdsSectionState();
}

class _LatestAdsSectionState extends ConsumerState<LatestAdsSection> {
  List<Product> products = [];
  @override
  void initState() {
    afterBuildCreated(() async {
      try {
        final response = await AppConstants.searchAd
            .get(fromJson: FilterResponse.fromJson, data: {
          "category_id": widget.category.id,
          "product_type": ['ad'],
          "offset": 0,
          "limit": 10,
        });
        ">>>>>>>>>>>>>>>>>>>> ${response.totalSize}".log();
        setState(() {
          products = response.products;
        });
      } catch (e) {}
    });
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: products.length,
          // shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 8),
              height: 100,
              width: 137,
              child: ProductWidget(
                productModel: products[index],
              ),
            );
          },
        ));
  }
}

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({
    super.key,
    required this.category,
  });

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, w) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   "Sub Categories",
          //   style: textStyle(18),
          // ),
          // 8.height,
          Container(
              height: (category.subCategories?.length ?? 0) != 0 ? 250 : 0,
              child: GridView.count(
                  crossAxisCount: 2,
                  scrollDirection: Axis.horizontal,
                  children: List.generate(
                    category.subCategories?.length ?? 0,
                    (index) {
                      final sub = category.subCategories?[index];
                      return Container(
                        decoration: boxDecorationDefault(color: UiColors.white),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 9, vertical: 9),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text('${sub?.name}', style: textStyle(14)),
                              ],
                            ),
                            12.height,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CacheImage(
                                  image: "${sub?.iconFullUrl?.path}",
                                  width: 70,
                                  height: 70,
                                  radius: 10,
                                ),
                              ],
                            ),
                            2.height,
                          ],
                        ).onTap(() {
                          ref
                              .read(filterDataProvider.notifier)
                              .updateCategory(category);
                          ref
                              .read(filterDataProvider.notifier)
                              .updateSubCategory(sub);
                          (sub?.subSubCategories?.length ?? 0) > 0
                              ? SubSubCategoryScreen(
                                  subCategory: sub!,
                                ).launch(context,
                                  pageRouteAnimation: PageRouteAnimation.Fade)
                              : const SearchResultView(
                                  // pageIndex: 2,
                                  searchText: null,
                                ).launch(context,
                                  pageRouteAnimation: PageRouteAnimation.Fade);
                        }),
                      );
                    },
                  )))
        ],
      );
    });
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 12, right: 7),
      decoration: boxDecorationDefault(
          boxShadow: [],
          borderRadius: BorderRadius.circular(90),
          border: Border.all(
              color: UiColors.primary, style: BorderStyle.solid, width: 0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Search ",
            style: TextStyle(fontSize: 16),
          ),
          Container(
            decoration: boxDecorationDefault(
                color: UiColors.bgBlue,
                boxShadow: [],
                borderRadius: BorderRadius.circular(90)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: const Icon(Icons.search, size: 20, color: UiColors.primary),
          ).onTap(() {
            // FilterPageWidget().launch(context,
            //     pageRouteAnimation: PageRouteAnimation.Fade);
          })
        ],
      ),
    );
  }
}
