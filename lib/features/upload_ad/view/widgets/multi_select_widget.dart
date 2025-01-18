import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/show_custom_snakbar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/field_value_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/field_values_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_parent_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_governorate_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class MultiSelectWidget extends ConsumerStatefulWidget {
  final PreferredSizeWidget? Function(BuildContext) appbar;
  final FieldWithOrder field;
  final Widget Function(BuildContext, Widget) pop;
  final bool isEdit;
  const MultiSelectWidget({
    super.key,
    required this.field,
    required this.appbar,
    required this.isEdit,
    required this.pop,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiSelectWidgetState();
}

class _MultiSelectWidgetState extends ConsumerState<MultiSelectWidget> {
  @override
  void initState() {
    afterBuildCreated(() {
      try {
        var list = ref.watch(saveHelperProvider);
        final value =
            list.firstWhere((item) => widget.field.order == item.field?.order);
        setState(() {});
      } catch (e) {}
    });
    super.initState();
  }

  List<String> selectedList = [];
  addOrRemove(FieldValueModel value) {
    try {
      if (selectedList.contains(value.value ?? "")) {
        selectedList.remove(value.value ?? "");
      } else {
        selectedList.add(value.value ?? "");
      }
    } catch (e) {}
    setState(() {});
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final provider = getfieldValuesProvider(
        id: widget.field.field.id ?? 0,
        parentId: ref.watch(parentProvider)[widget.field.order ?? 0]);
    // ref.listen(
    //     provider,
    //     (d, next) => next.when(
    //         data: (List<FieldValueModel> data) {
    //           "Listener ${data.isEmpty}".log();
    //           if (data.isEmpty) {
    //             if (widget.isEdit) {
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
    return widget.pop(
        context,
        Scaffold(
            appBar: widget.appbar(context),
            body: Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: ProviderHelperWidget(
                  function: (list) {
                    return list.isEmpty
                        ? Center(
                            child: Lottie.asset("assets/lottie/noData2.json"))
                        : ListView.builder(
                            itemCount: list.length,
                            itemBuilder: (BuildContext context, int index) {
                              final value = list[index];
                              return Container(
                                  // decoration: boxDecorationDefault(),
                                  margin: const EdgeInsets.only(bottom: 9),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 9),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      selectedList.contains(value.value ?? "")
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
                                        style: textStyle(16)
                                            .copyWith(color: UiColors.black),
                                      ),
                                    ],
                                  )).onTap(() {
                                addOrRemove(value);
                              });
                            },
                          );
                  },
                  listener: ref.watch(provider)),
            ),
            bottomSheet: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  widget.field.field.isRequired != 1
                      ? CustomButton(
                          buttonText: "skip".translate(context),
                          backgroundColor: UiColors.bgBlue,
                          textColor: UiColors.darkBlue,
                          onTap: () {
                            if (widget.isEdit) {
                              SmartDialog.dismiss();
                            }
                            bool result = ref
                                .read(fieldCounterProvider.notifier)
                                .nextPage();
                            if (result == false) {
                              SelectGovernorateWidget().launch(context);
                            }
                          },
                        )
                      : SizedBox.shrink(),
                  8.height,
                  CustomButton(
                    buttonText:
                        widget.isEdit ? "update" : "NEXT".translate(context),
                    onTap: () {
                      if (selectedList.isEmpty) {
                        showCustomSnackBar(
                            "Please select at lease one option", context);
                        return;
                      }
                      if (widget.isEdit) {
                        ref.read(saveHelperProvider.notifier).addValue(
                            field: widget.field, values: selectedList);
                        SmartDialog.dismiss();
                        return;
                      }

                      ref
                          .read(saveHelperProvider.notifier)
                          .addValue(field: widget.field, values: selectedList);

                      bool result =
                          ref.read(fieldCounterProvider.notifier).nextPage();
                      if (result == false) {
                        SelectGovernorateWidget().launch(context);
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
