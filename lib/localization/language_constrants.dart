import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/app_localization.dart';
import 'package:flutter_sixvalley_ecommerce/main_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';

String getTranslated(String? key, BuildContext context) {
  String? text = key;
  try {
    text = AppLocalization.of(context)!.translate(key);
  } catch (error) {
    text = "$key";
  }

  return text ?? "$key";
}
