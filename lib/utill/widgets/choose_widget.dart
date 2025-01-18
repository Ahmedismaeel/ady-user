import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class ChooseWidget extends StatelessWidget {
  const ChooseWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          boxDecorationDefault(border: Border.all(color: UiColors.primary)),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${title}",
            style: TextStyle(
              color: UiColors.primary,
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            size: 21,
            color: UiColors.primary,
          )
        ],
      ),
    );
  }
}
