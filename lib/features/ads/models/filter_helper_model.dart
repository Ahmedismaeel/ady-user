import 'package:flutter_sixvalley_ecommerce/features/ads/controller/fields_by_category_controller.dart';
import 'package:flutter_sixvalley_ecommerce/features/category/domain/models/category_model.dart';
import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/field_value_model.dart';

class FilterHelperModel {
  FilterHelperModel(
      {this.name,
      this.productType,
      this.categoryId,
      this.subCategoryId,
      this.subSubCategoryId,
      this.governorateId,
      this.wilyaId,
      this.priceMin,
      this.priceMax,
      this.location,
      this.radius,
      this.latitude,
      this.longitude,
      this.priceSort,
      this.dateSort,
      this.offset = 0,
      this.limit = 10,
      this.parent = const {},
      this.fieldValue = const {}});

  final String? name;

  final String? productType;
  final CategoryModel? categoryId;
  final SubCategory? subCategoryId;
  final SubSubCategory? subSubCategoryId;
  final int? governorateId;
  final int? wilyaId;
  final double? priceMin;
  final double? priceMax;
  final bool? location;
  final int? radius;
  final double? latitude;
  final double? longitude;
  final String? priceSort;
  final String? dateSort;
  final int offset;
  final int limit;
  final Map<int, int?> parent;
  final Map<int, List<FieldValueModel>?> fieldValue;
  FilterHelperModel copyWith({
    String? name,
    String? productType,
    CategoryModel? categoryId,
    SubCategory? subCategoryId,
    SubSubCategory? subSubCategoryId,
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
    Map<int, int?> parent = const {},
    Map<int, List<FieldValueModel>?> fieldValue = const {},
  }) {
    return FilterHelperModel(
        name: name ?? this.name,
        productType: productType ?? this.productType,
        categoryId: categoryId ?? this.categoryId,
        subCategoryId: subCategoryId ?? this.subCategoryId,
        subSubCategoryId: subSubCategoryId ?? this.subSubCategoryId,
        governorateId: governorateId ?? this.governorateId,
        wilyaId: wilyaId ?? this.wilyaId,
        priceMin: priceMin ?? this.priceMin,
        priceMax: priceMax ?? this.priceMax,
        location: location ?? this.location,
        radius: radius ?? this.radius,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        priceSort: priceSort ?? this.priceSort,
        dateSort: dateSort ?? this.dateSort,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        parent: parent,
        fieldValue: fieldValue);
  }

  factory FilterHelperModel.fromJson(Map<String, dynamic> json) {
    return FilterHelperModel(
      name: json["name"],
      productType: json["product_type"],
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      governorateId: json["governorate_id"],
      wilyaId: json["wilya_id"],
      priceMin: json["price_min"],
      priceMax: json["price_max"],
      location: json["location"],
      radius: json["radius"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      priceSort: json["price_sort"],
      dateSort: json["date_sort"],
      offset: json["offset"],
      limit: json["limit"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "product_type": productType,
        "category_id": categoryId,
        "sub_category_id": subCategoryId,
        "governorate_id": governorateId,
        "wilya_id": wilyaId,
        "price_min": priceMin,
        "price_max": priceMax,
        "location": location,
        "radius": radius,
        "latitude": latitude,
        "longitude": longitude,
        "price_sort": priceSort,
        "date_sort": dateSort,
        "offset": offset,
        "limit": limit,
      };

  @override
  String toString() {
    return "$name, $productType, $categoryId, $subCategoryId, $governorateId, $wilyaId, $priceMin, $priceMax, $location, $radius, $latitude, $longitude, $priceSort, $dateSort, $offset, $limit, ";
  }
}
