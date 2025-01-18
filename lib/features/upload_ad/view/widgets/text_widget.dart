import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_textfield_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/create_add_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/select_governorate_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

class TextWidget extends ConsumerStatefulWidget {
  final PreferredSizeWidget? Function(BuildContext) appbar;
  final FieldWithOrder field;
  final Widget Function(BuildContext, Widget) pop;
  final bool isEdit;

  const TextWidget(
      {super.key,
      required this.field,
      required this.appbar,
      required this.isEdit,
      required this.pop});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends ConsumerState<TextWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    afterBuildCreated(() {
      try {
        var list = ref.watch(saveHelperProvider);
        final value =
            list.firstWhere((item) => widget.field.order == item.field?.order);
        controller = TextEditingController(text: value.values[0]);
        setState(() {});
      } catch (e) {}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.pop(
        context,
        Scaffold(
          appBar: widget.appbar(context),
          body: Container(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      child: CustomTextFieldWidget(
                          titleText: "${widget.field.field.name}",
                          inputType: widget.field.field.type == 1
                              ? TextInputType.text
                              : TextInputType.number,
                          controller: controller,
                          validator: (value) {
                            return value?.isNotEmpty == true
                                ? null
                                : "${widget.field.field.name}${"must_not_be_empty".translate(context)}";
                          })),
                ],
              ),
            ),
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
                  buttonText: widget.isEdit
                      ? "update".translate(context)
                      : "NEXT".translate(context),
                  onTap: () {
                    hideKeyboard(context);
                    if (formKey.currentState?.validate() == false) {
                      return;
                    }
                    if (widget.isEdit) {
                      ref.read(saveHelperProvider.notifier).addValue(
                          field: widget.field, values: [controller.text]);
                      SmartDialog.dismiss();
                      return;
                    }
                    ref.read(saveHelperProvider.notifier).addValue(
                        field: widget.field, values: [controller.text]);

                    bool result =
                        ref.read(fieldCounterProvider.notifier).nextPage();
                    if (result == false) {
                      SelectGovernorateWidget().launch(context);
                    }
                  },
                )
              ],
            ),
          ),
        ));
  }
}
