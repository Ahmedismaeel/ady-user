import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_test_controller.g.dart';

@riverpod
Future<dynamic> apiTester(ApiTesterRef ref, {required String url}) async {
  return await url.test();
}
