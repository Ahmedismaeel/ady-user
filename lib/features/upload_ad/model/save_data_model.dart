import 'package:flutter_sixvalley_ecommerce/features/upload_ad/controller/category_field_controller.dart';

class SaveAddHelperModel {
  SaveAddHelperModel({
    required this.field,
    required this.values,
  });

  final FieldWithOrder? field;
  final List<String> values;

  SaveAddHelperModel copyWith({
    FieldWithOrder? field,
    List<String>? values,
  }) {
    return SaveAddHelperModel(
      field: field ?? this.field,
      values: values ?? this.values,
    );
  }

  factory SaveAddHelperModel.fromJson(Map<String, dynamic> json) {
    return SaveAddHelperModel(
      field: json["field"],
      values: json["values"] == null
          ? []
          : List<String>.from(json["values"]!.map((x) => x)),
    );
  }

  Map<String, dynamic> toJson() => {
        "field": "",
        "values": values.map((x) => x).toList(),
      };

  @override
  String toString() {
    return "$field, $values, ";
  }
}
