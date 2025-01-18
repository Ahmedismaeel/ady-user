import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/sort_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class SortWidget extends ConsumerWidget {
  const SortWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: boxDecorationDefault(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SortItemWidget(
            isSelected: ref.watch(sortProvider) == 1,
            title: "Newest".translate(context),
          ).onTap(() {
            ref.read(sortProvider.notifier).set(1);
          }),
          12.height,
          SortItemWidget(
            isSelected: ref.watch(sortProvider) == 2,
            title: "Oldest".translate(context),
          ).onTap(() {
            ref.read(sortProvider.notifier).set(2);
          }),
          12.height,
          SortItemWidget(
            isSelected: ref.watch(sortProvider) == 3,
            title: "Near By".translate(context),
          ).onTap(() {
            ref.read(sortProvider.notifier).set(3);
          }),
          12.height,
          SortItemWidget(
            isSelected: ref.watch(sortProvider) == 4,
            title: "Min Price".translate(context),
          ).onTap(() {
            ref.read(sortProvider.notifier).set(4);
          }),
          12.height,
          SortItemWidget(
            isSelected: ref.watch(sortProvider) == 5,
            title: "Max Price".translate(context),
          ).onTap(() {
            ref.read(sortProvider.notifier).set(5);
          }),
        ],
      ).paddingAll(12),
    );
  }
}

class SortItemWidget extends StatelessWidget {
  final bool isSelected;
  final String title;
  const SortItemWidget({
    super.key,
    required this.isSelected,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: boxDecorationDefault(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [],
          border: Border.all(
              color: isSelected ? UiColors.darkBlue : UiColors.lightGrey)),
      child: Row(
        children: [
          isSelected
              ? Icon(
                  Icons.radio_button_checked,
                  color: UiColors.darkBlue,
                )
              : Icon(
                  Icons.radio_button_off,
                  color: UiColors.darkBlue,
                ),
          12.width,
          Text(
            title,
            style: textStyle(16).copyWith(color: UiColors.darkBlue),
          ),
        ],
      ),
    );
  }
}
