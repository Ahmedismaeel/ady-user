import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/ad/select_item_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/field_values_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_parent_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/field_value_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/create_add_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_governorate_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class DropDownWidget extends ConsumerWidget {
  final PreferredSizeWidget? Function(BuildContext) appbar;
  final FieldWithOrder field;
  final Widget Function(BuildContext, Widget) pop;
  final bool isEdit;
  const DropDownWidget(
      {super.key,
      required this.field,
      required this.appbar,
      required this.isEdit,
      required this.pop});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = getfieldValuesProvider(
        id: field.field.id ?? 0,
        parentId: ref.watch(parentProvider)[field.order ?? 0]);
    // ref.listen(
    //     provider,
    //     (d, next) => next.when(
    //         data: (List<FieldValueModel> data) {
    //           "Listener ${data.isEmpty}".log();
    //           if (data.isEmpty) {
    //             if (isEdit) {
    //               SmartDialog.dismiss();
    //             }
    //             bool result =
    //                 ref.read(fieldCounterProvider.notifier).nextPage();
    //             if (result == false) {
    //               const SelectGovernorateWidget().launch(context);
    //             }
    //           }
    //         },
    //         error: (Object error, StackTrace stackTrace) {},
    //         loading: () {}));
    return pop(
        context,
        Scaffold(
            appBar: appbar(context),
            bottomSheet: field.field.isRequired != 1
                ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    child: CustomButton(
                      buttonText: "skip".translate(context),
                      backgroundColor: UiColors.bgBlue,
                      textColor: UiColors.darkBlue,
                      onTap: () {
                        if (isEdit) {
                          SmartDialog.dismiss();
                        }
                        bool result =
                            ref.read(fieldCounterProvider.notifier).nextPage();
                        if (result == false) {
                          const SelectGovernorateWidget().launch(context);
                        }
                      },
                    ),
                  )
                : null,
            body: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: ProviderHelperWidget(
                  function: (list) {
                    return list.isEmpty
                        ? Center(
                            child: Lottie.asset("assets/lottie/noData2.json"))
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              final value = list[index];
                              return SelectItemWidget(
                                value: value.value.toString(),
                              ).onTap(() {
                                if (isEdit) {
                                  ref
                                      .read(saveHelperProvider.notifier)
                                      .addValue(
                                          field: field,
                                          values: [value.value.toString()],
                                          parent: value.id);
                                  SmartDialog.dismiss();
                                  return;
                                }

                                ref.read(saveHelperProvider.notifier).addValue(
                                    field: field,
                                    values: [value.value.toString()],
                                    parent: value.id);
                                bool result = ref
                                    .read(fieldCounterProvider.notifier)
                                    .nextPage();
                                if (result == false) {
                                  const SelectGovernorateWidget()
                                      .launch(context);
                                }
                              });
                            });
                  },
                  listener: ref.watch(
                    getfieldValuesProvider(
                        id: field.field.id ?? 0,
                        parentId: ref.watch(parentProvider)[field.order ?? 0]),
                    //           ));
                  ),
                ))));
  }
}
