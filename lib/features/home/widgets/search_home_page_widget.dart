import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/localization/controllers/localization_controller.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class SearchHomePageWidget extends StatelessWidget {
  final Color? color;
  final Color? backgroundColor;
  const SearchHomePageWidget({super.key, this.color, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? UiColors.bgBlue,
      // padding: const EdgeInsets.symmetric(
      //     vertical: Dimensions.paddingSizeExtraExtraSmall),
      child: Container(
        color: backgroundColor ?? UiColors.bgBlue,
        padding: const EdgeInsets.symmetric(
            horizontal: Dimensions.homePagePadding,
            vertical: Dimensions.paddingSizeSmall),
        alignment: Alignment.center,
        child: Container(
          decoration: boxDecorationDefault(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.10000000149011612),
                  offset: Offset(0, 1),
                  blurRadius: 7)
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              // padding: EdgeInsets.only(
              //     left: Provider.of<LocalizationController>(context, listen: false)
              //             .isLtr
              //         ? Dimensions.homePagePadding
              //         : Dimensions.paddingSizeExtraSmall,
              //     right: Provider.of<LocalizationController>(context, listen: false)
              //             .isLtr
              //         ? Dimensions.paddingSizeExtraSmall
              //         : Dimensions.homePagePadding),
              height: 48,
              alignment: Alignment.centerLeft,
              decoration: boxDecorationDefault(
                borderRadius: BorderRadius.circular(0),
              ),

              // color: Theme.of(context).cardColor,
              // borderRadius:
              //     BorderRadius.circular(Dimensions.paddingSizeExtraSmall),

              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        16.width,
                        Text(
                            "Search product, ads or services"
                                .translate(context),
                            style:
                                textRegular.copyWith(color: UiColors.medGrey)),
                      ],
                    ),
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: color ?? Theme.of(context).primaryColor,
                        // borderRadius: const BorderRadius.all(
                        //     Radius.circular(Dimensions.paddingSizeExtraSmall))
                      ),
                      child: Icon(Icons.search,
                          color: Provider.of<ThemeController>(context,
                                      listen: false)
                                  .darkTheme
                              ? Colors.white
                              : Theme.of(context).cardColor,
                          size: 24),
                    ),
                  ]),
            ).paddingAll(0),
          ),
        ),
      ),
    );
  }
}
