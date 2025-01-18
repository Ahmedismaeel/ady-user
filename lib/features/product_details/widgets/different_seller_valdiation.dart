import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:nb_utils/nb_utils.dart';

confirmRemove({required Function onYes, required Function onNo}) {
  SmartDialog.show(
      builder: (BuildContext context) => AlertDialog(
            title: Text("Warning".translate(context)),
            content: Text("warning_add_to_cart".translate(context)),
            actions: [
              Container(
                decoration: boxDecorationDefault(color: UiColors.darkBlue),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "YES".translate(context),
                  style: textStyle(16).copyWith(color: UiColors.white),
                ),
              ).onTap(() {
                onYes();
              }),
              Container(
                decoration: boxDecorationDefault(color: UiColors.error),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "CANCEL".translate(context),
                  style: textStyle(16).copyWith(color: UiColors.white),
                ),
              ).onTap(() {
                onNo();
              }),
            ],
          ));
}
