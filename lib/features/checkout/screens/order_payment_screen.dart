import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:flutter_sixvalley_ecommerce/utill/translate_helper.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PayOrderView extends ConsumerWidget {
  final String url;
  final int orderId;
  const PayOrderView({
    super.key,
    required this.url,
    required this.orderId,
  });

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
              try {
                SmartDialog.showLoading();
                await request.url.test();
                SmartDialog.dismiss();
                SmartDialog.dismiss(result: true);
                // Navigator.pop(context, true);
              } catch (e) {
                // Navigator.pop(context, false);
                SmartDialog.dismiss(result: true);
              }

              return NavigationDecision.prevent;
            } else {
              try {
                SmartDialog.showLoading();
                await AppConstants.checkPayment.get(
                    fromJson: (Map<String, dynamic> i) {},
                    data: {"order_id": orderId});
                SmartDialog.dismiss();
                SmartDialog.dismiss(result: true);
                // Navigator.pop(context, true);
              } catch (e) {
                // Navigator.pop(context, false);
                SmartDialog.dismiss(result: true);
              }
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
