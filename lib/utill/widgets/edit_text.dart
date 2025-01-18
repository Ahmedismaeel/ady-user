// import 'package:client/src/res/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';

InputDecoration editTextDecoration() {
  double radius = 90;
  return InputDecoration(
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
    isCollapsed: true,
    prefixIconConstraints: BoxConstraints.tight(const Size(48, 48)),
    suffixIconConstraints: BoxConstraints.tight(const Size(48, 48)),
    contentPadding: const EdgeInsets.only(top: 12, right: 14, left: 14),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.secondary, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.error, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.error, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: UiColors.primary, style: BorderStyle.solid, width: 1),
        gapPadding: 0,
        borderRadius: BorderRadius.circular(radius)),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.primary, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}

TextStyle editTextTextStyle() {
  return const TextStyle(
    fontSize: 16,
  );
}

InputDecoration whiteEditTextDecoration() {
  double radius = 10;
  return InputDecoration(
    hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
    isCollapsed: true,
    prefixIconConstraints: BoxConstraints.tight(const Size(48, 48)),
    suffixIconConstraints: BoxConstraints.tight(const Size(48, 48)),
    filled: true,
    fillColor: UiColors.white,
    contentPadding: const EdgeInsets.only(top: 12, right: 14, left: 14),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.secondary, style: BorderStyle.solid, width: 1),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.error, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.error, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
    enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Colors.transparent, style: BorderStyle.solid, width: 0),
        gapPadding: 0,
        borderRadius: BorderRadius.circular(radius)),
    border: OutlineInputBorder(
      borderSide: const BorderSide(
          color: UiColors.primary, style: BorderStyle.solid, width: 0),
      gapPadding: 0,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
