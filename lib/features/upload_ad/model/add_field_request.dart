class AddFieldRequest {
  AddFieldRequest({
    required this.productId,
    required this.items,
  });

  final String? productId;
  final List<Item> items;

  AddFieldRequest copyWith({
    String? productId,
    List<Item>? items,
  }) {
    return AddFieldRequest(
      productId: productId ?? this.productId,
      items: items ?? this.items,
    );
  }

  factory AddFieldRequest.fromJson(Map<String, dynamic> json) {
    return AddFieldRequest(
      productId: json["product_id"],
      items: json["items"] == null
          ? []
          : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "product_id": productId,
        "items": items.map((x) => x?.toJson()).toList(),
      };

  @override
  String toString() {
    return "$productId, $items, ";
  }
}

class Item {
  Item({
    required this.fieldId,
    required this.value,
  });

  final int? fieldId;
  final List<String> value;

  Item copyWith({
    int? fieldId,
    List<String>? value,
  }) {
    return Item(
      fieldId: fieldId ?? this.fieldId,
      value: value ?? this.value,
    );
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      fieldId: json["field_id"],
      value: json["value"] == null
          ? []
          : List<String>.from(json["value"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "field_id": fieldId,
        "value": value.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$fieldId, $value, ";
  }
}
