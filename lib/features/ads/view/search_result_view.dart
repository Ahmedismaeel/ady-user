import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_ad_page.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/ad_filter_result.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/map_filter_tap.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/product_service_filter.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class SearchResultView extends ConsumerStatefulWidget {
  final String? searchText;
  final int? pageIndex;
  const SearchResultView({super.key, required this.searchText, this.pageIndex});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchResultViewState();
}

class _SearchResultViewState extends ConsumerState<SearchResultView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    afterBuildCreated(() {
      if (widget.pageIndex != null) {
        setPage(widget.pageIndex ?? 0);
      }
    });

    controller = TextEditingController(text: widget.searchText);
    super.initState();
  }

  TextEditingController controller = TextEditingController();
  int page = 0;
  setPage(int i) {
    page = i;
    setState(() {});
  }

  @override
  void dispose() {
    Future.microtask(() {
      // ref.read(filterDataProvider.notifier).clear();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: Container(
          color: UiColors.bgBlue,
          child: Column(
            children: [
              40.height,
              Row(
                children: [
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * (1 / 9)) - 15,
                      child: const Icon(
                        Icons.arrow_back,
                        size: 22,
                        color: UiColors.darkBlue,
                      )).onTap(() {
                    Navigator.pop(context);
                  }),
                  6.width,
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * (8 / 9)) - 15,
                    child: Hero(
                        tag: "SearchText",
                        child: Container(
                          height: 48,
                          // padding: const EdgeInsets.only(left: 12, right: 7),
                          decoration: boxDecorationDefault(
                              boxShadow: [],
                              borderRadius: BorderRadius.circular(90),
                              border: Border.all(
                                  color: Colors.transparent, //UiColors.primary,
                                  style: BorderStyle.solid,
                                  width: 0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  12.width,
                                  Text(
                                    widget.searchText ?? "",
                                    style: const TextStyle(
                                        fontSize: 16, color: UiColors.darkGrey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: boxDecorationDefault(
                                        color: UiColors.bgBlue,
                                        boxShadow: [],
                                        borderRadius:
                                            BorderRadius.circular(90)),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: const Icon(Icons.search,
                                        size: 20, color: UiColors.primary),
                                  ),
                                  6.width
                                ],
                              )
                            ],
                          ),
                        ).onTap(() async {
                          await Navigator.of(context)
                              .pushReplacement(buildPageRoute(
                            SearchAdPage(searchText: widget.searchText),
                            null,
                            null,
                          ));
                        })

                        // IgnorePointer(
                        //   child: TextField(
                        //     controller: controller,
                        //     decoration: editTextDecoration().copyWith(
                        //       filled: true,
                        //       fillColor: UiColors.white,
                        //       suffixIcon: InkWell(
                        //           onTap: () {
                        //             if (controller.text.isNotEmpty) {
                        //               controller.text.log();
                        //               ref
                        //                   .read(searchHistoryProvider.notifier)
                        //                   .saveText(controller.text);
                        //               SearchResultView(searchText: controller.text)
                        //                   .launch(context);
                        //             }
                        //           },
                        //           child: Container(
                        //             decoration: boxDecorationDefault(
                        //                 color: UiColors.bgBlue,
                        //                 boxShadow: [],
                        //                 borderRadius: BorderRadius.circular(90)),
                        //             margin: const EdgeInsets.symmetric(
                        //                 horizontal: 4, vertical: 4),
                        //             child: const Icon(Icons.search,
                        //                 size: 20, color: UiColors.darkBlue),
                        //           )),
                        //     ),
                        //   ),
                        // ),

                        ),
                  ),
                ],
              ),
            ],
          ).paddingSymmetric(horizontal: 12),
        ),
      ),
      body: Column(
        children: [
          // Container(
          //   color: UiColors.bgBlue,
          //   child: Row(
          //     children: [
          //       Container(
          //         decoration: boxDecorationDefault(
          //             color: UiColors.white,
          //             border: Border.all(color: UiColors.darkBlue),
          //             boxShadow: [],
          //             borderRadius: BorderRadius.circular(90)),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
          //         margin: const EdgeInsets.symmetric(horizontal: 3),
          //         child: Row(
          //           children: [
          //             Text(
          //               "${ref.watch(filterDataProvider).categoryId?.name}",
          //               style: textStyle(12).copyWith(color: UiColors.darkBlue),
          //             ),
          //             1.width,
          //             Icon(
          //               Icons.close,
          //               size: 18,
          //               color: UiColors.darkBlue,
          //             )
          //           ],
          //         ),
          //       ),
          //       12.width,
          //       Container(
          //         decoration: boxDecorationDefault(
          //             color: UiColors.white,
          //             border: Border.all(color: UiColors.darkBlue),
          //             boxShadow: [],
          //             borderRadius: BorderRadius.circular(90)),
          //         padding:
          //             const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          //         margin: const EdgeInsets.symmetric(horizontal: 3),
          //         child: Text(
          //           "${ref.watch(filterDataProvider).subCategoryId?.name}",
          //           style: textStyle(12).copyWith(color: UiColors.darkBlue),
          //         ),
          //       )
          //     ],
          //   ),
          // ),

          CustomSlidingSegmentedControl<int>(
            // key: UniqueKey(),
            padding: 7,
            // fromMax: true,
            isStretch: true,
            initialValue: widget.pageIndex,
            children: {
              0: Text(
                "Ads".translate(context),
                textAlign: TextAlign.center,
                style: textStyle(15).copyWith(
                    color: page == 0 ? UiColors.white : UiColors.medGrey),
              ),
              1: Text(
                "Product".translate(context),
                textAlign: TextAlign.center,
                style: textStyle(15).copyWith(
                    color: page == 1 ? UiColors.white : UiColors.medGrey),
              ),
              2: Text(
                "Service".translate(context),
                textAlign: TextAlign.center,
                style: textStyle(15).copyWith(
                    color: page == 2 ? UiColors.white : UiColors.medGrey),
              ),
              3: Text(
                "Map".translate(context),
                textAlign: TextAlign.center,
                style: textStyle(15).copyWith(
                    color: page == 3 ? UiColors.white : UiColors.medGrey),
              ),
            },
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(16),
            ),
            thumbDecoration: BoxDecoration(
              color: UiColors.darkBlue,
              borderRadius: BorderRadius.circular(16),
            ),
            onValueChanged: (int value) {
              print(value);
              setPage(value);
            },
          ),

          switch (page) {
            0 => Expanded(
                child: AdsFilterWidget(
                  key: UniqueKey(),
                  search: widget.searchText,
                ),
              ),
            1 => Expanded(
                child: ProductFilterWidget(
                  key: UniqueKey(), search: widget.searchText, type: 0,
                  // request: FilterRequest(
                  //     name: widget.searchText, productType: 'physical'),
                ),
              ),
            2 => Expanded(
                child: ProductFilterWidget(
                  key: UniqueKey(), search: widget.searchText, type: 1,
                  // request: FilterRequest(
                  //     name: widget.searchText, productType: 'physical'),
                ),
              ),
            3 => Expanded(child: MapFilterTapView(name: widget.searchText)),
            // TODO: Handle this case.
            int() => const SizedBox.shrink(),
          }
        ],
      ),
    );
  }
}
