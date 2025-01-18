import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/row_button.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/text_function.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class CustomDialog {
  static dialog(BuildContext context, {required Widget widget}) async {
    return await SmartDialog.show(
        // alignment: Alignment.bottomCenter,
        animationType: SmartAnimationType.fade,
        builder: (BuildContext _) {
          return widget;
        });
  }

  static attachDialog(BuildContext context, {required Widget widget}) async {
    return await SmartDialog.showAttach(
        alignment: Alignment.bottomCenter,
        animationType: SmartAnimationType.fade,
        builder: (BuildContext _) {
          return widget;
        },
        targetContext: context);
  }

  static myDialog(BuildContext context, {required Widget widget}) async {
    return await SmartDialog.show(
        alignment: Alignment.bottomCenter,
        builder: (BuildContext _) {
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: boxDecorationDefault(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: widget);
        });
  }

  static successDialog(BuildContext context,
      {required dynamic Function()? okFunction,
      required String successMessage}) async {
    return await SmartDialog.show(
        backDismiss: false,
        clickMaskDismiss: false,
        alignment: Alignment.bottomCenter,
        builder: (BuildContext _) {
          return Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              decoration: boxDecorationDefault(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(14),
                      topRight: Radius.circular(14))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset(
                    "assets/lottie/success.json",
                    width: 90,
                  ),
                  12.height,
                  Text(
                    successMessage,
                    style: CustomStyle.p,
                  ),
                  12.height,
                  RowButton(
                    text: "Ok".translate(context),
                    onTap: okFunction,
                  )
                ],
              ));
        });
  }
}
