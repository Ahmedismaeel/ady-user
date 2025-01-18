import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class SelectItemWidget extends StatelessWidget {
  final String value;
  const SelectItemWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecorationDefault(
            boxShadow: [],
            color: UiColors.bgBlue,
            border: Border.all(color: Color(0xFFE0EFFF))),
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: textStyle(17).copyWith(color: UiColors.darkBlue),
            ),
          ],
        ));
  }
}
