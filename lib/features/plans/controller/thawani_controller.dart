import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';

final thawaniProvider =
    FutureProvider.autoDispose.family<dynamic, int>((ref, id) async {
  return AppConstants.checkPayment
      .get(fromJson: (Map<String, dynamic> i) {}, data: {"plan_id": id});
});
