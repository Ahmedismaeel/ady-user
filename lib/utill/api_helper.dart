import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/exception/api_error_handler.dart';
import 'package:flutter_sixvalley_ecommerce/utill/submit_status.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:dio/dio.dart';
import "dart:developer" as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

listHelper<T>(
    {required list, required T Function(Map<String, dynamic>) fromJson}) {
  List<T> items = [];
  list.forEach((item) {
    items.add(fromJson(item));
  });

  return items;
}

extension ApiHelper on String {
  Future<dynamic> test() async {
    final response = await DioClient.instance.get(this);
    return response.data;
  }

  Future<T> get<T>(
      {required T Function(Map<String, dynamic>) fromJson, data}) async {
    final response = await DioClient.instance.get(this, data: data);
    "${response.data}".log();
    return fromJson(response.data);
  }

  Future<T> post<T>(
      {required T Function(Map<String, dynamic>) fromJson, data}) async {
    final response = await DioClient.instance.post(this, data: data);
    // "${response.data}".log();
    return fromJson(response.data);
  }

  Future<List<T>> getList<T>(
      {required T Function(Map<String, dynamic>) fromJson, data}) async {
    final response = await DioClient.instance.get(this, data: data);
    "${response.data}".log();
    return listHelper<T>(fromJson: fromJson, list: response.data);
  }

  // post<T>({required body}) {}
}

postHelper(state,
    {required String url, required body, required onSuccess}) async {
  SmartDialog.showLoading();
  state = SubmitState.loading();
  try {
    "${body}".log();
    final response = await DioClient.instance
        .post(url, data: body is List || body is Map ? body : body.toJson());
    onSuccess(response.data);
    SmartDialog.dismiss();
    return response;
  } catch (e) {
    SmartDialog.dismiss();
    toastLong(
      ApiErrorHandler.getMessage(e),
    );
    state = SubmitState.failed(
      message: ApiErrorHandler.getMessage(e),
    );
  }
}

putHelper(state,
    {required String url, required body, required onSuccess}) async {
  SmartDialog.showLoading();
  state = SubmitState.loading();
  try {
    final response = await DioClient.instance
        .put(url, data: body is List ? body : body.toJson());
    onSuccess(response.data);
    SmartDialog.dismiss();
    return response;
  } catch (e) {
    SmartDialog.dismiss();
    toastLong(ApiErrorHandler.getMessage(e));
    state = SubmitState.failed(message: ApiErrorHandler.getMessage(e));
  }
}

getHelper(state, {required String url, required onSuccess, data}) async {
  SmartDialog.showLoading();
  state = SubmitState.loading();
  try {
    final response = await DioClient.instance.get(url, data: data);
    onSuccess(response.data);
    SmartDialog.dismiss();
    return response;
  } catch (e) {
    SmartDialog.dismiss();
    toastLong(ApiErrorHandler.getMessage(e));
    state = SubmitState.failed(message: ApiErrorHandler.getMessage(e));
  }
}

deleteHelper(state, {required String url, required onSuccess}) async {
  SmartDialog.showLoading();
  state = SubmitState.loading();
  try {
    final response = await DioClient.instance.delete(url);
    onSuccess(response.data);
    SmartDialog.dismiss();
    return response;
  } catch (e) {
    SmartDialog.dismiss();

    state = SubmitState.failed(message: ApiErrorHandler.getMessage(e));
    toastLong(ApiErrorHandler.getMessage(e));
  }
}

postFormDataHelper(state,
    {required String url, required body, required onSuccess}) async {
  SmartDialog.showLoading();
  state = SubmitState.loading();
  try {
    final response = await DioClient.instance.post(url,
        data: body,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
    await onSuccess(response.data);
    SmartDialog.dismiss();
    return response;
  } catch (e) {
    SmartDialog.dismiss();
    toastLong(
      ApiErrorHandler.getMessage(e),
    );
    state = SubmitState.failed(message: ApiErrorHandler.getMessage(e));
  }
}

putFormDataHelper(state,
    {required String url, required body, required onSuccess}) async {
  SmartDialog.showLoading();
  state = SubmitState.loading();
  try {
    final response = await DioClient.instance.put(url,
        data: body,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}));
    onSuccess(response.data);
    SmartDialog.dismiss();
    return response;
  } catch (e) {
    SmartDialog.dismiss();
    toastLong(ApiErrorHandler.getMessage(e));
    state = SubmitState.failed(message: ApiErrorHandler.getMessage(e));
  }
}
