import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/common/basewidget/custom_button_widget.dart';
import 'package:flutter_sixvalley_ecommerce/features/dashboard/screens/dashboard_screen.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/subscribe_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/controller/thawani_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_test_controller.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/provider_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';

class CheckPaymentView extends ConsumerWidget {
  final String url;
  final int? planId;
  final bool isSeller;
  const CheckPaymentView(
      {super.key,
      required this.url,
      required this.planId,
      required this.isSeller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      bottomSheet: CustomButton(
        buttonText: "Ok".translate(context),
        onTap: () {
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     MaterialPageRoute(builder: (_) => const DashBoardScreen()),
          //     (route) => false);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        },
      ).paddingAll(12),
      body: Container(
        child: Center(
          child: ProviderHelperWidget(
              function: (function) {
                return isSeller
                    ? AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Text("Success"),
                            Center(
                                child: Lottie.asset(
                                    "assets/lottie/success.json",
                                    width: 70)),
                          ],
                        ),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "You are a seller now 🎉🎉🎉".translate(context),
                              style: textStyle(18).copyWith(
                                  color: UiColors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                            12.height,
                            Text(
                              "You can download ady vendor app and login with same credentials to start adding your products and services"
                                  .translate(context),
                              style: textStyle(16)
                                  .copyWith(color: UiColors.darkGrey),
                            )
                          ],
                        ),
                      )
                    : Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                                child: Lottie.asset(
                                    "assets/lottie/success.json",
                                    width: 130)),
                            12.height,
                            Text(
                              "Your Subscription has been Added Successfuly"
                                  .translate(context),
                              style: titleHeader,
                              textAlign: TextAlign.center,
                            ).paddingSymmetric(horizontal: 20),
                          ],
                        ),
                      );
              },
              listener: planId != null
                  ? ref.watch(thawaniProvider(planId!))
                  : ref.watch(apiTesterProvider(url: url))),
        ),
      ),
    );
  }
}
