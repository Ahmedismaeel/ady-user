class AdFieldModel {
  int? fieldId;
  String? fieldName;
  List<String>? value;

  AdFieldModel({this.fieldId, this.fieldName, this.value});

  AdFieldModel.fromJson(Map<String, dynamic> json) {
    fieldId = json['field_id'];
    fieldName = json['field_name'];
    value = json['value'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['field_id'] = this.fieldId;
    data['field_name'] = this.fieldName;
    data['value'] = this.value;
    return data;
  }
}
