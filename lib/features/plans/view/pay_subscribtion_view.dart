import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/check_payment_view.dart';
import 'package:flutter_sixvalley_ecommerce/features/plans/view/success_view.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaySubscriptionView extends ConsumerWidget {
  final String url;
  final int planId;
  final bool isSeller;
  const PaySubscriptionView(
      {super.key,
      required this.planId,
      required this.url,
      required this.isSeller});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) async {
            "${request.url}".log();

            if ("${request.url}"
                .startsWith("${AppConstants.baseUrl}/payment-success")) {
              CheckPaymentView(
                url: request.url,
                isSeller: isSeller,
                planId: null,
              ).launch(context);
              return NavigationDecision.prevent;
            } else {
              CheckPaymentView(
                isSeller: isSeller,
                url: request.url,
                planId: planId,
              ).launch(context);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          }))
      ..loadRequest(Uri.parse(url));
    return Scaffold(
        appBar: AppBar(
          title: Text("Payment Screen".translate(context)),
        ),
        body: Container(
          child: WebViewWidget(
            controller: controller,
          ),
        ));
  }
}
