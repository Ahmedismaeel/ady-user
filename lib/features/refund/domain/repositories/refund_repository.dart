import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/data/model/api_response.dart';
import 'package:flutter_sixvalley_ecommerce/features/auth/controllers/auth_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/refund/domain/repositories/refund_repository_interface.dart';
import 'package:flutter_sixvalley_ecommerce/main.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

class RefundRepository implements RefundRepositoryInterface {
  final DioClient? dioClient;
  RefundRepository({required this.dioClient});

  @override
  Future<http.StreamedResponse> refundRequest(int? orderDetailsId,
      double? amount, String refundReason, List<XFile?> file) async {
    http.MultipartRequest request = http.MultipartRequest('POST',
        Uri.parse('${AppConstants.baseUrl}${AppConstants.refundRequestUri}'));
    request.headers.addAll(<String, String>{
      'Authorization':
          'Bearer ${Provider.of<AuthController>(Get.context!, listen: false).getUserToken()}'
    });
    for (int i = 0; i < file.length; i++) {
      Uint8List list = await file[i]!.readAsBytes();
      var part = http.MultipartFile(
          'images[]', file[i]!.readAsBytes().asStream(), list.length,
          filename: basename(file[i]!.path),
          contentType: MediaType('image', 'jpg'));
      request.files.add(part);
    }
    Map<String, String> fields = {};
    fields.addAll(<String, String>{
      'order_details_id': orderDetailsId.toString(),
      'amount': amount.toString(),
      'refund_reason': refundReason
    });
    request.fields.addAll(fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  @override
  Future<ApiResponse> getRefundInfo(int? orderDetailsId) async {
    try {
      final response = await DioClient.instance.get(
          '${AppConstants.refundRequestPreReqUri}?order_details_id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future<ApiResponse> getRefundResult(int? orderDetailsId) async {
    try {
      final response = await DioClient.instance
          .get('${AppConstants.refundResultUri}?id=$orderDetailsId');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  @override
  Future add(value) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future getList({int? offset = 1}) {
    // TODO: implement getList
    throw UnimplementedError();
  }

  @override
  Future update(Map<String, dynamic> body, int id) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
