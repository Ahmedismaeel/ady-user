import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:provider/provider.dart';

const titilliumRegular = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontSize: 12,
);
const titleRegular = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontWeight: FontWeight.w500,
  fontSize: 14,
);
const titleHeader = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontWeight: FontWeight.w600,
  fontSize: 16,
);
const titilliumSemiBold = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontSize: 12,
  fontWeight: FontWeight.w600,
);

const titilliumBold = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontSize: 14,
  fontWeight: FontWeight.w700,
);
const titilliumItalic = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontSize: 14,
  fontStyle: FontStyle.italic,
);

const textRegular = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontWeight: FontWeight.w300,
  fontSize: 14,
);

TextStyle textStyle(double size) => TextStyle(
    fontFamily: 'Outfit-Regular',
    fontSize: size,
    letterSpacing: 0,
    fontWeight: FontWeight.normal,
    textBaseline: TextBaseline.ideographic,
    height: 1);

const textMedium = TextStyle(
    fontFamily: 'Outfit-Regular', fontSize: 14, fontWeight: FontWeight.w500);
const textBold = TextStyle(
    fontFamily: 'Outfit-Regular', fontSize: 14, fontWeight: FontWeight.w600);

const robotoBold = TextStyle(
  fontFamily: 'Outfit-Regular',
  fontSize: 14,
  fontWeight: FontWeight.w700,
);

var robotoRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);
var robotoRegularMainHeadingAddProduct = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeDefault,
);

var robotoRegularForAddProductHeading = TextStyle(
  fontFamily: 'Ubuntu',
  color: Color(0xFF9D9D9D),
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSmall,
);

var robotoTitleRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeLarge,
);

var robotoSmallTitleRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w400,
  fontSize: Dimensions.fontSizeSmall,
);

// var robotoBold = TextStyle(
//   fontFamily: 'Ubuntu',
//   fontSize: Dimensions.fontSizeDefault,
//   fontWeight: FontWeight.w600,
// );

var robotoMedium = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w500,
);

class ThemeShadow {
  static List<BoxShadow> getShadow(BuildContext context) {
    List<BoxShadow> boxShadow = [
      BoxShadow(
          color: Provider.of<ThemeController>(context, listen: false).darkTheme
              ? Colors.black26
              : Theme.of(context).primaryColor.withOpacity(.075),
          blurRadius: 5,
          spreadRadius: 1,
          offset: const Offset(1, 1))
    ];
    return boxShadow;
  }
}
