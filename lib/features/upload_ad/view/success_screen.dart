import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class SuccessScreen extends ConsumerWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            40.height,
            Text(
              "Your Ad has been added successfuly will be approved soon by the admin"
                  .translate(context),
              textAlign: TextAlign.center,
              style: textStyle(22).copyWith(color: UiColors.darkBlue),
            ),
            70.height,
            Center(
              child: Lottie.asset("assets/lottie/success.json", width: 200),
            ),
          ],
        ).paddingAll(30),
      ),
      bottomNavigationBar: CustomButton(
        buttonText: "Ok".translate(context),
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashBoardScreen()),
              (route) => false);
        },
      ).paddingAll(12),
    );
  }
}
