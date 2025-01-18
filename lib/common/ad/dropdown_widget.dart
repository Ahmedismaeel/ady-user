import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class DropDownOption extends StatelessWidget {
  final String title;
  const DropDownOption({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDecorationDefault(
          boxShadow: [],
          borderRadius: BorderRadius.circular(10),
          color: UiColors.bgBlue,
          border: Border.all(color: UiColors.borderBlue)),
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: textStyle(16),
          ),
          const Icon(
            Icons.keyboard_arrow_down_outlined,
          )
        ],
      ),
    );
  }
}
