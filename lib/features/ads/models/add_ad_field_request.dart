import 'package:flutter_sixvalley_ecommerce/features/upload_ad/model/category_field_model.dart';

class AddAdFieldRequest {
  AddAdFieldRequest({
    this.productId,
    required this.items,
  });

  final int? productId;
  final List<Item> items;

  AddAdFieldRequest copyWith({
    int? productId,
    List<Item>? items,
  }) {
    return AddAdFieldRequest(
      productId: productId ?? this.productId,
      items: items ?? this.items,
    );
  }

  factory AddAdFieldRequest.fromJson(Map<String, dynamic> json) {
    return AddAdFieldRequest(
      productId: json["product_id"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "items": items.map((x) => x.toJson()).toList(),
      };

  @override
  String toString() {
    return "$productId, $items, ";
  }
}

class Item {
  Item({
    required this.field,
    required this.value,
    required this.order,
  });

  final CategoryFieldModel? field;
  final List<String> value;
  final int? order;
  Item copyWith({
    CategoryFieldModel? field,
    List<String>? value,
    int? order,
  }) {
    return Item(
      order: this.order ?? order,
      field: field ?? this.field,
      value: value ?? this.value,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      order: 0,
      field: json['field'] != null
          ? CategoryFieldModel.fromJson(json['field'])
          : null,
      value: json["value"] == null
          ? []
          : List<String>.from(json["value"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "field_id": field?.id,
        "value": value.map((x) => x).toList(),
        // "ids": ids.map((x) => x?.toJson()).toList(),
      };
}

class Model {
  String? tets;
  Values? values;

  Model({this.tets, this.values});

  Model.fromJson(Map<String, dynamic> json) {
    tets = json['tets'];
    values =
        json['values'] != null ? new Values.fromJson(json['values']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tets'] = this.tets;
    if (this.values != null) {
      data['values'] = this.values!.toJson();
    }
    return data;
  }
}

class Values {
  int? test;
  String? h;

  Values({this.test, this.h});

  Values.fromJson(Map<String, dynamic> json) {
    test = json['test'];
    h = json['h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['test'] = this.test;
    data['h'] = this.h;
    return data;
  }
}
