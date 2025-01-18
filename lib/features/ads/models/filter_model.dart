class FilterRequest {
  FilterRequest({
    this.name,
    this.productType = const [],
    this.categoryId,
    this.subCategoryId,
    this.subSubCategoryId,
    this.governorateId,
    this.wilyaId,
    this.priceMin,
    this.priceMax,
    this.items = const [],
    this.location,
    this.radius,
    this.latitude,
    this.longitude,
    this.priceSort,
    this.dateSort,
    this.offset,
    this.limit,
  });

  final String? name;
  final List<String> productType;
  final int? categoryId;
  final int? subCategoryId;
  final int? subSubCategoryId;
  final int? governorateId;
  final int? wilyaId;
  final double? priceMin;
  final double? priceMax;
  final List<Item> items;
  final bool? location;
  final int? radius;
  final double? latitude;
  final double? longitude;
  final String? priceSort;
  final String? dateSort;
  final int? offset;
  final int? limit;

  FilterRequest copyWith({
    String? name,
    List<String>? productType,
    int? categoryId,
    int? subCategoryId,
    int? subSubCategoryId,
    int? governorateId,
    int? wilyaId,
    double? priceMin,
    double? priceMax,
    List<Item>? items,
    bool? location,
    int? radius,
    double? latitude,
    double? longitude,
    String? priceSort,
    String? dateSort,
    int? offset,
    int? limit,
  }) {
    return FilterRequest(
      name: name ?? this.name,
      productType: productType ?? this.productType,
      categoryId: categoryId ?? this.categoryId,
      subCategoryId: subCategoryId ?? this.subCategoryId,
      subSubCategoryId: subSubCategoryId ?? this.subSubCategoryId,
      governorateId: governorateId ?? this.governorateId,
      wilyaId: wilyaId ?? this.wilyaId,
      priceMin: priceMin ?? this.priceMin,
      priceMax: priceMax ?? this.priceMax,
      items: items ?? this.items,
      location: location ?? this.location,
      radius: radius ?? this.radius,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      priceSort: priceSort ?? this.priceSort,
      dateSort: dateSort ?? this.dateSort,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }

  factory FilterRequest.fromJson(Map<String, dynamic> json) {
    return FilterRequest(
      name: json["name"],
      productType: json["product_type"] == null
          ? []
          : List<String>.from(json["product_type"]!.map((x) => x)),
      categoryId: json["category_id"],
      subCategoryId: json["sub_category_id"],
      subSubCategoryId: json["sub_sub_category_id"],
      governorateId: json["governorate_id"],
      wilyaId: json["wilya_id"],
      priceMin: json["price_min"],
      priceMax: json["price_max"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
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
        "sub_sub_category_id": subSubCategoryId,
        "governorate_id": governorateId,
        "wilya_id": wilyaId,
        "price_min": priceMin,
        "price_max": priceMax,
        "items": items.map((x) => x?.toJson()).toList(),
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
    return "$name, $productType, $categoryId, $subCategoryId, $subSubCategoryId, $governorateId, $wilyaId, $priceMin, $priceMax, $items, $location, $radius, $latitude, $longitude, $priceSort, $dateSort, $offset, $limit, ";
  }
}

class Item {
  Item({
    required this.field,
    required this.value,
  });

  final int? field;
  final List<String> value;

  Item copyWith({
    int? field,
    List<String>? value,
  }) {
    return Item(
      field: field ?? this.field,
      value: value ?? this.value,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      field: json["field"],
      value: json["value"] == null
          ? []
          : List<String>.from(json["value"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "field": field,
        "value": value.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$field, $value, ";
  }
}
