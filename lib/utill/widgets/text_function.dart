import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:intl/intl.dart';

Text textTitle(String text) {
  return Text(
    text,
    textHeightBehavior: const TextHeightBehavior(
        leadingDistribution: TextLeadingDistribution.even),
    style: const TextStyle(color: UiColors.primary, fontSize: 16),
  );
}



class CustomStyle {
  static const TextStyle title =
      TextStyle(color: UiColors.primary, fontSize: 16);
  static const TextStyle display = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    color: Color.fromARGB(255, 140, 10, 10),
    // height: 146 / 48,
  );

  static const TextStyle h1 = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,

    // height: 78 / 40,
  );
  static const TextStyle h2 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w700,

    // height: 60 / 32,
  );
  static const TextStyle h3 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,

    // height: 59 / 28,
  );
  static const TextStyle h4 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,

    // height: 51 / 24,
  );

  static const TextStyle h5 = TextStyle(
    fontSize: 20,
    // fontWeight: FontWeight.w700,

    // height: 40 / 20,
  );

  static const TextStyle p = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );
  static const TextStyle n = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle p18 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle pBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,

    //
  );
  static const TextStyle pMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,

    //
  );
  static const TextStyle lpMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,

    //
  );
  static const TextStyle small = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w400,

    //
  );
}

const textHeightBehavior =
    TextHeightBehavior(leadingDistribution: TextLeadingDistribution.even);
