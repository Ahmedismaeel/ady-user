import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/dropdown_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/fields_by_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/filter_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/governorate_selection.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/sort_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/widget/wilaya_selection.dart';

import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/field_values_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/helper/cach_image.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterPageWidget extends ConsumerStatefulWidget {
  final bool hideCategory;
  const FilterPageWidget({super.key, this.hideCategory = false});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FilterPageWidgetState();
}

class _FilterPageWidgetState extends ConsumerState<FilterPageWidget> {
  @override
  void initState() {
    afterBuildCreated(() {
      minPrice = TextEditingController(
          text: ref.watch(filterDataProvider).priceMin == 0.00
              ? null
              : "${ref.watch(filterDataProvider).priceMin ?? ""}");
      maxPrice = TextEditingController(
          text: ref.watch(filterDataProvider).priceMax == 0.00
              ? null
              : "${ref.watch(filterDataProvider).priceMax ?? ""}");
      setState(() {});
    });
    super.initState();
  }

  TextEditingController minPrice = TextEditingController();
  TextEditingController maxPrice = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final filter = ref.watch(filterDataProvider);
    dropDown(FieldHelperModel field, FieldHelperModel? nextfield) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.field.name ?? "",
                style: textStyle(18).copyWith(fontWeight: FontWeight.bold),
              ),
              12.height,
              DropDownOption(
                      title: ref
                              .watch(filterDataProvider)
                              .fieldValue[field.field.id]?[0]
                              .value ??
                          "${"Select".translate(context)} ${field.field.name}")
                  .onTap(() {
                SmartDialog.show(
                    alignment: Alignment.bottomCenter,
                    builder: (BuildContext _) {
                      return DropDownValuesSelection(
                        field: field,
                        previousField: nextfield,
                      );
                    });
              })
            ],
          ),
        ).paddingOnly(bottom: 12);
    canShow(FieldHelperModel field) =>
        ref.watch(filterDataProvider).parent[field.order] != null ||
        field.hasParent != true;
    multiSelect(FieldHelperModel field) => Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                field.field.name ?? "",
                style: textStyle(18).copyWith(fontWeight: FontWeight.bold),
              ),
              12.height,
              ProviderHelperWidget(
                  function: (data) {
                    return ListView.builder(
                      itemCount: data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        final value = data[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ref
                                    .read(filterDataProvider.notifier)
                                    .isSelectItem(field, value)
                                ? const Icon(
                                    Icons.check_box,
                                    color: UiColors.darkBlue,
                                  )
                                : const Icon(
                                    Icons.check_box_outline_blank,
                                    color: UiColors.darkBlue,
                                  ),
                            12.width,
                            Text(
                              value.value.toString(),
                              style:
                                  textStyle(16).copyWith(color: UiColors.black),
                            ),
                          ],
                        ).paddingAll(8).onTap(() {
                          ref
                              .read(filterDataProvider.notifier)
                              .updateItemListMulti(field, value);
                        });
                      },
                    );
                  },
                  listener: ref.watch(getfieldValuesProvider(
                      id: field.field.id ?? 0,
                      parentId:
                          ref.watch(filterDataProvider).parent?[field.order])))
            ],
          ),
        );

    ref.watch(governorateHelperProvider);
    ref.watch(wilayatHelperProvider);
    return Scaffold(
      appBar: CustomAppBar(
        title: "filter".translate(context),
        showResetIcon: true,
        reset: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.sort_rounded),
        ).onTap(() {
          SmartDialog.show(
              alignment: Alignment.bottomCenter,
              animationType: SmartAnimationType.fade,
              builder: (BuildContext _) {
                return const SortWidget();
              });
        }),
      ),
      bottomNavigationBar: Container(
        color: UiColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                decoration: boxDecorationDefault(
                    boxShadow: [], color: UiColors.darkGrey),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Clear".translate(context),
                      style: textStyle(16).copyWith(color: UiColors.white),
                    ),
                  ],
                ),
              ).onTap(() {
                ">>>>>>>>>>>>>>>> ${double.tryParse(minPrice.text)} >>>>>>>"
                    .log();
                ">>>>>>>>>>>>>>>> ${double.tryParse(maxPrice.text)} >>>>>>>"
                    .log();

                ref.read(filterDataProvider.notifier).clear();
              }),
            ),
            14.width,
            Flexible(
              flex: 1,
              child: Container(
                decoration: boxDecorationDefault(
                    boxShadow: [], color: UiColors.darkBlue),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Apply Filter".translate(context),
                      style: textStyle(16).copyWith(color: UiColors.white),
                    ),
                  ],
                ),
              ).onTap(() {
                ref
                    .read(filterDataProvider.notifier)
                    .update(priceMin: double.tryParse(minPrice.text) ?? 0.00);
                ref
                    .read(filterDataProvider.notifier)
                    .update(priceMax: double.tryParse(maxPrice.text) ?? 0.00);

                ref.read(filterDataProvider.notifier).getData();
                Navigator.pop(context);
              }),
            )
          ],
        ),
      ),
      body: Container(
        decoration: boxDecorationDefault(),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.height,
            widget.hideCategory
                ? const SizedBox.shrink()
                : Text(
                    "Category".translate(context),
                    style: textStyle(18).copyWith(fontWeight: FontWeight.bold),
                  ),
            widget.hideCategory ? const SizedBox.shrink() : 12.height,
            widget.hideCategory
                ? const SizedBox.shrink()
                : DropDownOption(
                        title: filter.categoryId?.name ??
                            "Select category".translate(context))
                    .onTap(() {
                    SmartDialog.show(
                        alignment: Alignment.bottomCenter,
                        builder: (BuildContext _) {
                          return const CategorySelection();
                        });
                  }),
            widget.hideCategory ? const SizedBox.shrink() : 12.height,
            filter.categoryId == null
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sub Category".translate(context),
                        style:
                            textStyle(18).copyWith(fontWeight: FontWeight.bold),
                      ),
                      12.height,
                      DropDownOption(
                              title: filter.subCategoryId?.name ??
                                  "Select sub category".translate(context))
                          .onTap(() {
                        SmartDialog.show(
                            alignment: Alignment.bottomCenter,
                            builder: (BuildContext _) {
                              return const SubCategorySelection();
                            });
                      }),
                    ],
                  ),
            12.height,
            filter.subCategoryId == null
                ? const SizedBox.shrink()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sub Sub Category".translate(context),
                        style:
                            textStyle(18).copyWith(fontWeight: FontWeight.bold),
                      ),
                      12.height,
                      DropDownOption(
                              title: filter.subSubCategoryId?.name ??
                                  "Select sub sub category".translate(context))
                          .onTap(() {
                        SmartDialog.show(
                            alignment: Alignment.bottomCenter,
                            builder: (BuildContext _) {
                              return const SubSubCategorySelection();
                            });
                      }),
                    ],
                  ),
            12.height,
            // for (var item
            //     in ref.watch(filterDataProvider).fieldValue.entries.toList())
            //   Text("${item.key.field.name}"),
            filter.subCategoryId == null
                ? const SizedBox.shrink()
                : ProviderHelperWidget(
                    function: (fieldList) => ListView.builder(
                          itemCount: fieldList.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext _, int index) {
                            final field = fieldList[index];
                            return field.field.isFilter != 1
                                ? const SizedBox.shrink()
                                : canShow(field)
                                    ? switch (field.field.type) {
                                        1 => const SizedBox.shrink(),
                                        2 => dropDown(
                                            field,
                                            (index + 1) < fieldList.length
                                                ? fieldList[index + 1]
                                                : null),
                                        3 => multiSelect(field),
                                        4 => const SizedBox.shrink(),
                                        int() => throw UnimplementedError(),
                                        null => throw UnimplementedError(),
                                      }
                                    : const SizedBox();
                          },
                        ),
                    listener: ref.watch(fieldsByCateogryProvider(
                        categoryId: filter.subCategoryId?.id ?? 0))),
            Divider(
              color: UiColors.lightGrey,
            ),
            12.height,
            Text(
              "Governorate".translate(context),
              style: textStyle(18).copyWith(fontWeight: FontWeight.bold),
            ),
            12.height,
            DropDownOption(
                    title: ref
                            .read(governorateHelperProvider.notifier)
                            .getName() ??
                        "Select Governorate".translate(context))
                .onTap(() {
              SmartDialog.show(
                  // alignment: Alignment.bottomCenter,
                  animationType: SmartAnimationType.fade,
                  builder: (BuildContext _) {
                    return const GovernorateSelectionWidget();
                  });
            }),
            12.height,
            Text(
              "Wilaya".translate(context),
              style: textStyle(18).copyWith(fontWeight: FontWeight.bold),
            ),
            12.height,
            DropDownOption(
                    title: ref.read(wilayatHelperProvider.notifier).getName() ??
                        "Select Wilaya".translate(context))
                .onTap(() {
              SmartDialog.show(
                  alignment: Alignment.bottomCenter,
                  builder: (BuildContext _) {
                    return WilayaSelectionWidget();
                  });
            }),
            12.height,
            Text(
              "Price".translate(context),
              style: textStyle(18).copyWith(fontWeight: FontWeight.bold),
            ),
            12.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    decoration: boxDecorationDefault(
                        border: Border.all(color: UiColors.borderBlue),
                        boxShadow: [],
                        borderRadius: BorderRadius.circular(10),
                        color: UiColors.bgBlue),
                    child: Row(
                      children: [
                        Text("Min".translate(context)),
                        10.width,
                        Container(
                            width: 70,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: minPrice,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ))
                      ],
                    )),
                Expanded(
                  child: Divider(
                    indent: 10,
                    endIndent: 10,
                    color: UiColors.darkBlue,
                  ),
                ),
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    decoration: boxDecorationDefault(
                        border: Border.all(color: UiColors.borderBlue),
                        boxShadow: [],
                        borderRadius: BorderRadius.circular(10),
                        color: UiColors.bgBlue),
                    child: Row(
                      children: [
                        Text("Max".translate(context)),
                        10.width,
                        Container(
                            width: 70,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              controller: maxPrice,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ))
                      ],
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DropDownValuesSelection extends ConsumerWidget {
  final FieldHelperModel field;
  final FieldHelperModel? previousField;
  const DropDownValuesSelection(
      {super.key, required this.field, required this.previousField});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: boxDecorationDefault(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ProviderHelperWidget(
          function: (list) {
            return ListView.builder(
              itemCount: list.length,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    decoration: boxDecorationDefault(
                        boxShadow: [],
                        color: UiColors.bgBlue,
                        border: Border.all(color: const Color(0xFFE0EFFF))),
                    margin: const EdgeInsets.only(bottom: 9),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          list[index].value.toString(),
                          style:
                              textStyle(17).copyWith(color: UiColors.darkBlue),
                        ),
                      ],
                    )).onTap(() {
                  ref
                      .read(filterDataProvider.notifier)
                      .updateItemList(field, [list[index]], previousField);
                  SmartDialog.dismiss();
                });
              },
            );
          },
          listener: ref.watch(getfieldValuesProvider(
              id: field.field.id ?? 0,
              parentId: ref.watch(filterDataProvider).parent?[field.order]))),
    );
  }
}

class SubCategorySelection extends ConsumerWidget {
  const SubCategorySelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: boxDecorationDefault(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ListView.builder(
        itemCount:
            ref.watch(filterDataProvider).categoryId?.subCategories?.length ??
                0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final subCategory =
              ref.watch(filterDataProvider).categoryId?.subCategories![index];
          return Container(
            decoration: boxDecorationDefault(),
            child: Row(
              children: [
                CacheImage(
                    height: 80,
                    width: 80,
                    image: subCategory?.icon ?? "",
                    radius: 12),
                12.width,
                Text(subCategory?.name.toString() ?? "")
              ],
            ),
          ).paddingBottom(8).onTap(() {
            ref
                .read(filterDataProvider.notifier)
                .updateSubCategory(subCategory);
            SmartDialog.dismiss();
          });
        },
      ),
    );
  }
}

class SubSubCategorySelection extends ConsumerWidget {
  const SubSubCategorySelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: boxDecorationDefault(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: ListView.builder(
        itemCount: ref
                .watch(filterDataProvider)
                .subCategoryId
                ?.subSubCategories
                ?.length ??
            0,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          final subCategory = ref
              .watch(filterDataProvider)
              .subCategoryId
              ?.subSubCategories![index];
          return Container(
            decoration: boxDecorationDefault(),
            child: Row(
              children: [
                CacheImage(
                    height: 80,
                    width: 80,
                    image: subCategory?.icon ?? "",
                    radius: 12),
                12.width,
                Text(subCategory?.name.toString() ?? "")
              ],
            ),
          ).paddingBottom(8).onTap(() {
            ref
                .read(filterDataProvider.notifier)
                .updateSubSubCategory(subCategory);
            SmartDialog.dismiss();
          });
        },
      ),
    );
  }
}

class CategorySelection extends ConsumerWidget {
  const CategorySelection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderHelperWidget(
        function: (list) {
          return Container(
            decoration: boxDecorationDefault(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12))),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: ListView.builder(
              itemCount: list.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: boxDecorationDefault(),
                  child: Row(
                    children: [
                      CacheImage(
                          height: 80,
                          width: 80,
                          image: list[index].imageFullUrl?.path ?? "",
                          radius: 12),
                      12.width,
                      Text(list[index].name.toString())
                    ],
                  ),
                ).paddingBottom(8).onTap(() {
                  ref
                      .read(filterDataProvider.notifier)
                      .updateCategory(list[index]);
                  SmartDialog.dismiss();
                });
              },
            ),
          );
        },
        listener: ref.watch(categoryListProvider));
  }
}
