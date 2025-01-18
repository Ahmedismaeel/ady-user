import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_app_bar_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/widgets/shipping_details_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/field_couter.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/select_field_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/widgets/dropdown_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/widgets/multi_select_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/view/widgets/text_widget.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class FieldSelectionView extends ConsumerWidget {
  final bool isEdit;
  final FieldWithOrder field;
  const FieldSelectionView({
    super.key,
    required this.field,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext _, WidgetRef ref) {
    return Scaffold(
      body: switch (field.field.type) {
        1 => TextWidget(
            key: UniqueKey(),
            pop: (context, child) => PopScope(
              canPop: false,
              onPopInvoked: (d) async {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
              child: child,
            ),
            field: field,
            appbar: (context) => CustomAppBar(
              title: "${field.field.name}".capitalize(),
              onBackPressed: () {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
            ),
            isEdit: isEdit,
          ),
        2 => DropDownWidget(
            key: UniqueKey(),
            pop: (context, child) => PopScope(
              canPop: false,
              onPopInvoked: (d) async {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  "will ssssssssssssssssssssss".log();
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
              child: child,
            ),
            field: field,
            appbar: (context) => CustomAppBar(
              title: "${field.field.name}".capitalize(),
              onBackPressed: () {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  "back ssssssssssssssssssssss".log();
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
            ),
            isEdit: isEdit,
          ),
        3 => MultiSelectWidget(
            key: UniqueKey(),
            pop: (context, child) => PopScope(
              canPop: false,
              onPopInvoked: (d) async {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
              child: child,
            ),
            field: field,
            appbar: (context) => CustomAppBar(
              title: "${field.field.name}".capitalize(),
              onBackPressed: () {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
            ),
            isEdit: isEdit,
          ),
        4 => TextWidget(
            key: UniqueKey(),
            pop: (context, child) => PopScope(
              canPop: false,
              onPopInvoked: (d) async {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
              child: child,
            ),
            field: field,
            appbar: (context) => CustomAppBar(
              title: "${field.field.name}".capitalize(),
              onBackPressed: () {
                if (isEdit) {
                  SmartDialog.dismiss();
                  return;
                }
                if (ref.watch(fieldCounterProvider) == 0) {
                  ref.read(saveHelperProvider.notifier).clear();
                  Future.delayed(Duration.zero, () {
                    Navigator.pop(context);
                  });
                  return;
                } else {
                  ref.read(fieldCounterProvider.notifier).previousPage();
                }
              },
            ),
            isEdit: isEdit,
          ),
        int() => const Text("int"),
        null => const Text("null")
      },
    );
  }
}
