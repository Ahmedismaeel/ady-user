import 'package:flutter_sixvalley_ecommerce/features/product/domain/models/product_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'add_list_controller.g.dart';

@riverpod
Future<List<Product>> getAdList(GetAdListRef ref, {int? categoryId}) async {
  return await AppConstants.adList
      .getList(fromJson: Product.fromJson, data: {"category_id": categoryId});
}
