import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class SuccessView extends StatelessWidget {
  const SuccessView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      bottomSheet: CustomButton(
        buttonText: "ok".translate(context),
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashBoardScreen()),
              (route) => false);
        },
      ).paddingAll(12),
      body: Container(
        child: Column(
          children: [
            Text(
              "Your Subscription has been Added Successfuly".translate(context),
              style: titleHeader,
              textAlign: TextAlign.center,
            ),
            12.height,
            Center(child: Lottie.asset("assets/lottie/success.json")),
          ],
        ),
      ),
    );
  }
}
