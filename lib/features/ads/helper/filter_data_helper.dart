import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/controller/fields_by_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/helper/sort_data_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_helper_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/ads/models/filter_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/governorate_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/helper/wilaya_helper.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/field_value_model.dart';
import 'package:flutter_sixvalley_ecommerce/utill/api_helper.dart';

class FilterDataNotifier extends StateNotifier<FilterHelperModel> {
  final StateNotifierProviderRef<FilterDataNotifier, FilterHelperModel> ref;
  FilterDataNotifier(this.ref) : super(FilterHelperModel());
  updateItemList(FieldHelperModel field, List<FieldValueModel> values,
      FieldHelperModel? nextField) {
    Map<int, List<FieldValueModel>?> map = {};
    map.addAll(state.fieldValue);
    map[field.field.id ?? 0] = values;
    "update Next".log();
    if (nextField != null) {
      "remove Next".log();
      map[nextField.field.id ?? 0] = null;
    }
    Map<int, int?> parent = {};
    parent.addAll(state.parent);
    parent[field.order + 1] = values[0].id;
    state = state.copyWith(fieldValue: map, parent: parent);
  }

  bool isSelectItem(
    FieldHelperModel field,
    FieldValueModel value,
  ) {
    if (state.fieldValue[field.field.id ?? 0]?.isNotEmpty == true) {
      return isIdSelect(state.fieldValue[field.field.id ?? 0]!, value);
    }
    return false;
  }

  updateItemListMulti(
    FieldHelperModel field,
    FieldValueModel value,
  ) {
    Map<int, List<FieldValueModel>?> map = {};
    map.addAll(state.fieldValue);
    if (map[field.field.id ?? 0]?.isNotEmpty == true) {
      "Yes".log();
      List<FieldValueModel> list = [];
      list.addAll(map[field.field.id ?? 0] ?? []);
      if (isIdSelect(list, value)) {
        try {
          list.removeWhere((test) => test.id == value.id);
        } catch (e) {}
      } else {
        list.add(value);
      }
      map[field.field.id ?? 0] = list;
    } else {
      "NO".log();
      map[field.field.id ?? 0] = [value];
    }
    Map<int, int?> parent = {};
    parent.addAll(state.parent);
    parent[field.order + 1] = value.id;
    state = state.copyWith(fieldValue: map, parent: parent);
  }

  isIdSelect(List<FieldValueModel> list, FieldValueModel item) {
    try {
      list.firstWhere((test) => test.id == item.id);
      return true;
    } catch (e) {
      return false;
    }
  }

  updateCategory(CategoryModel? category) {
    state = FilterHelperModel(categoryId: category, name: state.name);
  }

  updateSubCategory(SubCategory? subCategory) {
    state = FilterHelperModel(
        categoryId: state.categoryId,
        subCategoryId: subCategory,
        name: state.name);
  }

  updateSubSubCategory(SubSubCategory? subSubCategory) {
    state = FilterHelperModel(
        categoryId: state.categoryId,
        subCategoryId: state.subCategoryId,
        subSubCategoryId: subSubCategory,
        name: state.name);
  }

  update({
    String? name,
    String? productType,
    int? governorateId,
    int? wilyaId,
    double? priceMin,
    double? priceMax,
    bool? location,
    int? radius,
    double? latitude,
    double? longitude,
    String? priceSort,
    String? dateSort,
    int? offset,
    int? limit,
  }) {
    state = state.copyWith(
        name: name ?? state.name,
        productType: productType ?? state.productType,
        governorateId: governorateId ?? state.governorateId,
        wilyaId: wilyaId ?? state.wilyaId,
        priceMin: (priceMin ?? state.priceMin) == 0.00
            ? null
            : (priceMin ?? state.priceMin),
        priceMax: (priceMax ?? state.priceMax) == 0.00
            ? null
            : (priceMax ?? state.priceMax),
        location: location ?? state.location,
        radius: radius ?? state.radius,
        latitude: latitude ?? state.latitude,
        longitude: longitude ?? state.longitude,
        priceSort: priceSort ?? state.priceSort,
        dateSort: dateSort ?? state.dateSort,
        offset: offset ?? state.offset,
        limit: limit ?? state.limit,
        fieldValue: state.fieldValue,
        parent: state.parent);
  }

  FilterRequest getData() {
    final filterModel = FilterRequest(
      categoryId: state.categoryId?.id,
      subCategoryId: state.subCategoryId?.id,
      subSubCategoryId: state.subSubCategoryId?.id,
      // governorateId: ref.watch(governorateHelperProvider)?.id,
      // wilyaId: ref.watch(wilayatHelperProvider)?.id,
      priceMin: state.priceMin,
      priceMax: state.priceMax,
      items: List.generate(state.fieldValue.entries.length, (index) {
        final list = state.fieldValue.entries.toList();
        return Item(
            field: list[index].key,
            value: List.generate(list[index].value?.length ?? 0,
                (i) => list[index].value?[i].value ?? ""));
      }),
      location: state.location,
      radius: state.radius,
      latitude: state.latitude,
      longitude: state.longitude,
      priceSort: state.priceSort,
      dateSort: state.dateSort,
      offset: state.offset,
      limit: state.limit,
    );

    switch (ref.watch(sortProvider)) {
      case 0:
        return filterModel;
      case 1:
        return filterModel.copyWith(dateSort: "desc");
      case 2:
        return filterModel.copyWith(dateSort: "asc");
      case 3:
        return filterModel.copyWith(location: true);
      case 4:
        return filterModel.copyWith(priceSort: "asc");
      case 5:
        return filterModel.copyWith(priceSort: "desc");
      default:
        return filterModel;
    }
  }

  clear() {
    state = FilterHelperModel();
    ref.read(sortProvider.notifier).clear();
    ref.read(governorateHelperProvider.notifier).clear();
    ref.read(wilayatHelperProvider.notifier).clear();
  }

  // bool isSelected(
  //   FieldHelperModel field,
  // ) {
  //   return state.fieldValue?[field] != null;
  // }
}

final filterDataProvider =
    StateNotifierProvider<FilterDataNotifier, FilterHelperModel>((ref) {
  return FilterDataNotifier(ref);
});
