import 'package:flutter/material.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/pay_subscribtion_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/widgets/colors.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'subscribe_controller.g.dart';

@riverpod
class SubscribePlan extends _$SubscribePlan {
  @override
  SubmitState<String> build() {
    return const SubmitState.initial();
  }

  Future<void> subscribe(
      {required int planId,
      bool isDefault = false,
      required BuildContext context}) async {
    await getHelper(state, url: AppConstants.subscribePlane(planId: planId),
        onSuccess: (onSuccess) {
      if (!isDefault) {
        state = SubmitState.success(response: onSuccess['pay_url']);
        PaySubscriptionView(
          url: onSuccess['pay_url'],
          planId: planId,
          isSeller: false,
        ).launch(context);
      } else {
        state = const SubmitState.success(response: "");
        return SmartDialog.show(builder: (BuildContext context) {
          return const BecomeSellerSuccessWidget();
        });
      }
    });
  }

  Future<void> becomeASeller(
      {required int planId,
      bool isDefault = false,
      required BuildContext context}) async {
    await getHelper(state, url: AppConstants.becomeASeller(planId: planId),
        onSuccess: (onSuccess) {
      if (!isDefault) {
        state = SubmitState.success(response: onSuccess['pay_url']);
        PaySubscriptionView(
          isSeller: true,
          url: onSuccess['pay_url'],
          planId: planId,
        ).launch(context);
      } else {
        state = const SubmitState.success(response: "");
        return SmartDialog.show(builder: (BuildContext context) {
          return const BecomeSellerSuccessWidget();
        });
      }
    });
  }
}

class BecomeSellerSuccessWidget extends StatelessWidget {
  const BecomeSellerSuccessWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Text("Success"),
          Center(child: Lottie.asset("assets/lottie/success.json", width: 70)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "You are a seller now 🎉🎉🎉".translate(context),
            style: textStyle(18)
                .copyWith(color: UiColors.black, fontWeight: FontWeight.w600),
          ),
          12.height,
          Text(
            "You can download ady vendor app and login with same credentials to start adding your products and services"
                .translate(context),
            style: textStyle(16).copyWith(color: UiColors.darkGrey),
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            SmartDialog.dismiss();
          },
          child: Text("ok".translate(context)),
        ),
      ],
    );
  }
}
