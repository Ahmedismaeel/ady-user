import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/ad_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/add_list_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/view/search_ad_page.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:nb_utils/nb_utils.dart';

class AdHomeView extends ConsumerWidget {
  final bool isBackButtonExist;
  const AdHomeView({
    super.key,
    required this.isBackButtonExist,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Ad Home'.translate(context),
        isBackButtonExist: isBackButtonExist,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ListView(
          children: [
            Hero(
              tag: "SearchText",
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: boxDecorationDefault(),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text("Search"), Icon(Icons.search)],
                ),
              ).onTap(() {
                const SearchAdPage().launch(context);
              }),
            ),
            12.height,
            ProviderHelperWidget(
                function: (list) {
                  return ListView.builder(
                      itemCount: list.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext _, int index) =>
                          AdWidget(productModel: list[index])
                              .paddingBottom(12)
                              .withTooltip(
                                  msg: "${list[index].name} click single "));
                },
                listener: ref.watch(getAdListProvider()))
          ],
        ),
      ),
    );
  }
}
