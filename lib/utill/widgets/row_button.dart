import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/text_function.dart';
import 'package:nb_utils/nb_utils.dart';

class RowButton extends StatelessWidget {
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;
  const RowButton(
      {Key? key, required this.text, this.onTap, this.bgColor, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: onTap == null,
      child: InkWell(
          onTap: () {
            hideKeyboard(context);
            onTap != null ? onTap!() : () {};
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 9),
            decoration: boxDecorationDefault(
              color: bgColor ?? UiColors.primary,
            ),
            // height: 35,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  textHeightBehavior: textHeightBehavior,
                  style: CustomStyle.title
                      .copyWith(color: textColor ?? UiColors.white),
                )
              ],
            ),
          )

          // Box(
          //     style: AnimatedStyle(
          //       Style(
          //         $box.height(35),
          //         // $box.width(200),
          //         $box.alignment.center(),
          //         $box.margin.horizontal(4),
          //         $box.color(UiColors.primary),
          //         $box.borderRadius(8),
          //         $on.press(
          //           // $box.height(45),
          //           // $box.width(200),
          //           $box.alignment.center(),
          //           // $box.margin.horizontal(46),
          //           $box.color(UiColors.secondary),
          //           $box.borderRadius(8),
          //         ),
          //       ),
          //       duration: Durations.short4,
          //       curve: Curves.easeIn,
          //     ),
          //     child: StyledText(text,
          //         style: Style(
          //           $text.textHeightBehavior(const TextHeightBehavior(
          //               leadingDistribution: TextLeadingDistribution.even)),
          //           $text.style.color.white(),
          //           $text.style.fontSize(16),
          //         ))),

          ),
    );
  }
}
