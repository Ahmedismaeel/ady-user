import 'dart:convert';

import 'package:flutter_sixvalley_ecommerce/data/datasource/remote/dio/dio_client.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static late SharedPreferences sharedPreference;

  /// private constructor
  SharedPreferenceHelper._();

  /// the one and only instance of this singleton
  static final instance = SharedPreferenceHelper._();
  static Future<SharedPreferences> init() async {
    sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference;
  }

  Future<void> saveToken(String token) async {
    final bool s =
        await sharedPreference.setString(AppConstants.userLoginToken, token);
    if (s) {
      "Token Saved Successully".log();
    } else {
      "Token Faild To Save".log();
    }
  }

  String? getToken() {
    return sharedPreference.getString(AppConstants.userLoginToken);
  }

  Future<bool> removeToken() async {
    return await sharedPreference.remove(AppConstants.userLoginToken);
  }

  saveLang(Map<String, dynamic> data) async {
    await sharedPreference.setString("langMap", json.encode(data));
  }

  Map<String, dynamic>? getLang() {
    try {
      // "${sharedPreference.getString("langMap")}".log();
      return json.decode(sharedPreference.getString("langMap") ?? "{}");
    } catch (e) {
      return null;
    }
  }

  Future<void> saveSearchProductName(String searchAddress) async {
    try {
      List<String> searchKeywordList =
          sharedPreference.getStringList(AppConstants.searchProductName) ?? [];
      if (!searchKeywordList.contains(searchAddress)) {
        searchKeywordList.add(searchAddress);
      }
      await sharedPreference.setStringList(
          AppConstants.searchProductName, searchKeywordList);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeSearchProductName(String searchAddress) async {
    try {
      List<String> searchKeywordList =
          sharedPreference.getStringList(AppConstants.searchProductName) ?? [];
      if (!searchKeywordList.contains(searchAddress)) {
        searchKeywordList.remove(searchAddress);
      }
      await sharedPreference.setStringList(
          AppConstants.searchProductName, searchKeywordList);
    } catch (e) {
      rethrow;
    }
  }

  clearSearchProductNames() async {
    await sharedPreference.setStringList(AppConstants.searchProductName, []);
  }

  List<String> getSavedSearchProductName() {
    return sharedPreference.getStringList(AppConstants.searchProductName) ?? [];
  }
}
