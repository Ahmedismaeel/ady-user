import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';
import 'package:flutter_sixvalley_ecommerce/utill/app_constants.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'category_controller.g.dart';

@riverpod
Future<List<CategoryModel>> categoryList(CategoryListRef ref) async {
  final list = await AppConstants.categoriesUri
      .getList(fromJson: CategoryModel.fromJson);
  list.sort((a, b) {
    return a.id!.compareTo(b.id!);
  });
  List<CategoryModel> newList = [
    list[2],
    list[3],
    list[0],
    list[1],
  ];
  return newList;
}
