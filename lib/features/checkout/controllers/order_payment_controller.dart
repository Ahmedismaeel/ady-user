import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/checkout/domain/models/payment_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

final orderPaymentProvider = FutureProvider.family
    .autoDispose<PaymentResponse, String>((ref, String order) async {
  return await "${AppConstants.orderPayment}$order"
      .get(fromJson: PaymentResponse.fromJson);
});
