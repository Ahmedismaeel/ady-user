import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/more/controller/views_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ViewsWidget extends ConsumerWidget {
  const ViewsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderHelperWidget(
        function: (data) {
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
            decoration: boxDecorationDefault(
                boxShadow: [],
                color: UiColors.darkBlue,
                borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      " ${data.clicks} " + "Clicks".translate(context),
                      style: textStyle(20).copyWith(color: UiColors.white),
                    )
                  ],
                ),
                // Text(
                //   "in last 24 hours",
                //   style: textStyle(14).copyWith(color: UiColors.white),
                // ),
                24.height,
                Text(
                  "You have".translate(context) +
                      " ${data.count} " +
                      "running ads".translate(context),
                  style: textStyle(16).copyWith(color: UiColors.white),
                )
              ],
            ),
          );
        },
        listener: ref.watch(viewsProvider));
  }
}
