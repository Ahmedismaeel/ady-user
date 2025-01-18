import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';

class SubCategoryIdNotifier extends StateNotifier<SubCategory> {
  SubCategoryIdNotifier() : super(SubCategory());

  setCategoryId(SubCategory category) {
    state = category;
  }
}

final subcategoryIdProvider =
    StateNotifierProvider<SubCategoryIdNotifier, SubCategory>((ref) {
  return SubCategoryIdNotifier();
});

class SubSubCategoryIdNotifier extends StateNotifier<SubSubCategory?> {
  SubSubCategoryIdNotifier() : super(null);

  setCategoryId(SubSubCategory category) {
    state = category;
  }
}

final subSubcategoryIdProvider =
    StateNotifierProvider<SubSubCategoryIdNotifier, SubSubCategory?>((ref) {
  return SubSubCategoryIdNotifier();
});

class CategoryIdNotifier extends StateNotifier<CategoryModel> {
  CategoryIdNotifier() : super(CategoryModel());

  setCategoryId(CategoryModel category) {
    state = category;
  }
}

final categoryIdProvider =
    StateNotifierProvider<CategoryIdNotifier, CategoryModel>((ref) {
  return CategoryIdNotifier();
});
