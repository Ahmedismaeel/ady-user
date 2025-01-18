import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/select_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/governorate_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_wilayat_view.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectGovernorateWidget extends ConsumerWidget {
  final bool isEdit;
  const SelectGovernorateWidget({
    this.isEdit = false,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Select Governorate".translate(context),
        onBackPressed: () {
          isEdit
              ? SmartDialog.dismiss()
              : Future.delayed(Duration.zero, () {
                  Navigator.pop(context);
                });
        },
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: ProviderHelperWidget(
            function: (list) {
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) =>
                    SelectItemWidget(
                  value: getLang()
                      ? list[index].name ?? ""
                      : list[index].nameAr ?? "",
                ).onTap(() async {
                  ref.read(governorateHelperProvider.notifier).set(list[index]);

                  if (isEdit) {
                    final isSelected = await SmartDialog.show(
                        animationType: SmartAnimationType.fade,
                        builder: (BuildContext context) {
                          return SelectWilayatView(
                            isEdit: true,
                          );
                        });
                    if (isSelected) {
                      SmartDialog.dismiss();
                    }
                  } else {
                    SelectWilayatView().launch(context);
                  }
                }).paddingAll(3),
              );
            },
            listener: ref.watch(governorateListProvider)),
      ),
    );
  }
}
