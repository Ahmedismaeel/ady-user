import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/not_loggedin_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/expired_ads_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/my_ads_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/my_ad_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/controller/assign_to_plan_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/model/plan_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_plan_view.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class MyAdsView extends ConsumerStatefulWidget {
  final bool isBackButtonExist;
  const MyAdsView({
    super.key,
    this.isBackButtonExist = true,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAdsViewState();
}

class _MyAdsViewState extends ConsumerState<MyAdsView> {
  int page = 0;
  setPage(int id) {
    page = id;
    ref.read(myadsHelperProvider.notifier).reset();
    setState(() {});
  }

  int? categoryId;
  setCategory(int? d) {
    categoryId = d;
    ref.read(myadsHelperProvider.notifier).reset();
    setState(() {});
  }

  @override
  void initState() {
    afterBuildCreated(() {
      ref.read(myadsHelperProvider.notifier).reset();
    });
    super.initState();
  }

  int active = 1;
  setActive(int d) {
    active = d;
    ref.read(myadsHelperProvider.notifier).reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(assignToPlanProvider, (previous, next) {
      next.when(() {}, initial: () {}, loading: () {}, success: (s) {
        SmartDialog.show(
          builder: (_) {
            return Container(
              decoration: boxDecorationDefault(),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 40,
                  ),
                  16.height,
                  Text(
                    "Ads Assigned Successfully".translate(context),
                    style: textStyle(16).copyWith(fontWeight: FontWeight.bold),
                  ),
                  32.height,
                  CustomButton(
                    buttonText: "ok".translate(context),
                    onTap: () {
                      SmartDialog.dismiss();
                    },
                  ),
                ],
              ),
            );
          },
        );
      }, failed: (d) {});
    });
    return Scaffold(
      appBar: CustomAppBar(
        title: "My Ads".translate(context),
        isBackButtonExist: widget.isBackButtonExist,
        // showResetIcon: true,
        // reset: Container(
        //   padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        //   margin: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        //   decoration:
        //       boxDecorationDefault(shape: BoxShape.circle, boxShadow: []),
        //   child: Icon(
        //     Icons.more_vert,
        //     color: UiColors.darkBlue,
        //     // size: 30,
        //   ),
        // ).onTap(() {
        //   CustomDialog.myDialog(context,
        //       widget: CustomButton(
        //         buttonText: "Change Plan",
        //         onTap: () {},
        //       ));
        // }),
      ),
      floatingActionButton: ref.watch(myadsHelperProvider).isEmpty ||
              categoryId == null
          ? null
          : InkWell(
              onTap: () async {
                PlanModel? plan = await SelectPlanView(
                  categoryId: categoryId!,
                ).launch(context);
                if (plan != null) {
                  await ref.read(assignToPlanProvider.notifier).send(
                      planId: plan.id ?? 0,
                      productIdList: ref.read(myadsHelperProvider));
                }
              },
              child: Container(
                decoration: boxDecorationDefault(
                    borderRadius: BorderRadius.circular(12),
                    color: UiColors.secondary),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.change_circle_outlined,
                      color: UiColors.white,
                    ),
                    8.width,
                    Text(
                      "Change The Plan".translate(context),
                      style: textStyle(16).copyWith(color: UiColors.white),
                    ),
                  ],
                ),
              ),
            ).paddingBottom(45),
      body: !isLoggedIn
          ? const NotLoggedInWidget()
          : Stack(
              children: [
                page == 3
                    ? ExpiredAdsTab(
                        ref: ref,
                        page: page,
                        active: active,
                        categoryId: categoryId,
                      ).paddingTop(80)
                    : ProviderHelperWidget(
                        function: (list) => list.isEmpty
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  ref.invalidate(myAdsProvider);
                                },
                                child: ListView(
                                  children: [
                                    Lottie.asset("assets/lottie/noData2.json"),
                                  ],
                                ),
                              )
                            : AdList(list: list),
                        loadingShape:
                            AdList(list: [Product(), Product(), Product()]),
                        listener: ref.watch(myAdsProvider((
                          statusId: page == 0
                              ? 1
                              : page == 1
                                  ? 0
                                  : 2,
                          categoryId: categoryId
                        )))).paddingSymmetric(vertical: 60),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: CustomSlidingSegmentedControl<int>(
                          // key: UniqueKey(),
                          padding: 7,
                          fromMax: true,
                          isStretch: true,
                          children: {
                            0: Text(
                              "Active".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 0
                                      ? UiColors.white
                                      : UiColors.medGrey),
                            ),
                            1: Text(
                              "Pending".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 1
                                      ? UiColors.white
                                      : UiColors.medGrey),
                            ),
                            2: Text(
                              "InActive".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 2
                                      ? UiColors.white
                                      : UiColors.medGrey),
                            ),
                            3: Text(
                              "Expired".translate(context),
                              textAlign: TextAlign.center,
                              style: textStyle(15).copyWith(
                                  color: page == 3
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
                          ),
                          onValueChanged: (int value) {
                            print(value);
                            setPage(value);
                          },
                        ),
                      ),
                    ),
                    Container(
                      decoration: boxDecorationDefault(color: UiColors.bgBlue),
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          Row(children: [
                            Flexible(
                              flex: 6,
                              child: ProviderHelperWidget(
                                  function: (categoryList) {
                                    final selectedCategory = categoryId;
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: boxDecorationDefault(
                                                color: selectedCategory == null
                                                    ? UiColors.darkBlue
                                                    : UiColors.white,
                                                // boxShadow: [],
                                                borderRadius:
                                                    BorderRadius.circular(90)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 8),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3),
                                            child: Text(
                                                "all".translate(context),
                                                style: textStyle(14).copyWith(
                                                    color: selectedCategory ==
                                                            null
                                                        ? UiColors.white
                                                        : UiColors.darkBlue)),
                                          ).onTap(() {
                                            setCategory(null);
                                          }),
                                          for (var element in categoryList)
                                            Container(
                                              decoration: boxDecorationDefault(
                                                  color: selectedCategory ==
                                                          element.id
                                                      ? UiColors.darkBlue
                                                      : UiColors.white,
                                                  // boxShadow: [],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90)),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 8),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3),
                                              child: Text("${element.name}",
                                                  style: textStyle(14).copyWith(
                                                      color: selectedCategory ==
                                                              element.id
                                                          ? UiColors.white
                                                          : UiColors.darkBlue)),
                                            ).onTap(() {
                                              setCategory(element.id);
                                            })
                                        ],
                                      ),
                                    );
                                  },
                                  listener: ref.watch(categoryListProvider)),
                            )
                          ]),
                          !widget.isBackButtonExist ? 30.height : 0.height,
                        ],
                      ),
                    )
                  ],
                ),
                page == 3
                    ? Column(
                        children: [
                          53.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                      active == 1
                                          ? Icons.check_box_sharp
                                          : Icons.check_box_outline_blank,
                                      color: UiColors.darkBlue),
                                  3.width,
                                  Text(
                                    "Active".translate(context),
                                  )
                                ],
                              ).onTap(() {
                                setActive(1);
                              }),
                              Row(
                                children: [
                                  Icon(
                                      active == 0
                                          ? Icons.check_box_sharp
                                          : Icons.check_box_outline_blank,
                                      color: UiColors.darkBlue),
                                  3.width,
                                  Text(
                                    "InActive".translate(context),
                                  )
                                ],
                              ).onTap(() {
                                setActive(0);
                              })
                            ],
                          )
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            ),
    );
  }
}

class ExpiredAdsTab extends StatefulWidget {
  const ExpiredAdsTab({
    super.key,
    required this.ref,
    required this.page,
    required this.categoryId,
    required this.active,
  });

  final WidgetRef ref;
  final int page;
  final int active;
  final int? categoryId;

  @override
  State<ExpiredAdsTab> createState() => _ExpiredAdsTabState();
}

class _ExpiredAdsTabState extends State<ExpiredAdsTab> {
  @override
  Widget build(BuildContext context) {
    return ProviderHelperWidget(
      function: (list) => list.isEmpty
          ? RefreshIndicator(
              onRefresh: () async {
                widget.ref.invalidate(expiredAdProvider);
              },
              child: ListView(
                children: [
                  Lottie.asset("assets/lottie/noData2.json"),
                ],
              ),
            )
          : AdList(list: list),
      listener: widget.ref.watch(expiredAdProvider(
          (category: widget.categoryId, active: widget.active))),
      loadingShape: AdList(list: [Product(), Product(), Product()]),
    );
  }
}

class AdList extends ConsumerWidget {
  final List<Product> list;
  const AdList({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(myadsHelperProvider);
    return Padding(
      padding: EdgeInsets.all(12),
      child: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(myAdsProvider);
          ref.invalidate(expiredAdProvider);
        },
        child: GridView.builder(
          itemCount: list.length,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            final ad = list[index];
            return Stack(
              children: [
                AdWidget(
                  productModel: ad,
                  canEdit: true,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: boxDecorationDefault(),
                          margin: const EdgeInsets.all(7),
                          child: ref
                                  .read(myadsHelperProvider.notifier)
                                  .isChecked(ad.id ?? 0)
                              ? const Icon(
                                  Icons.check_box,
                                  color: UiColors.darkBlue,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank,
                                  color: UiColors.darkBlue,
                                ),
                        ).onTap(() {
                          ref
                              .read(myadsHelperProvider.notifier)
                              .addProductId(ad.id ?? 0);
                        }),
                      ],
                    ),
                  ],
                )
              ],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 130 / 218,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            crossAxisCount: 2,
          ),
        ),
      ),
    );
  }
}
