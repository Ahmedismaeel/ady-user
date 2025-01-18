import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/select_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/wilaya_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/create_add_view.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectWilayatView extends ConsumerWidget {
  final bool isEdit;
  const SelectWilayatView({
    this.isEdit = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select Wilayat".translate(context),
        onBackPressed: () {
          isEdit ? SmartDialog.dismiss(result: false) : Navigator.pop(context);
        },
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ProviderHelperWidget(
            function: (list) {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) =>
                    SelectItemWidget(
                  value: getLang()
                      ? list[index].name ?? ""
                      : list[index].nameAr ?? "",
                ).paddingAll(2).onTap(() {
                  ref
                      .read(wilayatHelperProvider.notifier)
                      .setWilayat(list[index]);
                  isEdit
                      ? SmartDialog.dismiss(result: true)
                      : CreateAdView().launch(context);
                }),
              );
            },
            listener: ref.watch(wilayaListProvider(0))),
      ),
    );
  }
}
