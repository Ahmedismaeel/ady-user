class FieldValueModel {
  int? id;
  int? fieldId;
  String? value;
  String? updatedAt;
  String? createdAt;

  FieldValueModel(
      {this.id, this.fieldId, this.value, this.updatedAt, this.createdAt});

  FieldValueModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fieldId = json['field_id'];
    value = json['value'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['field_id'] = this.fieldId;
    data['value'] = this.value;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
