import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';

class WilayaModel {
  int? id;
  String? name;
  String? nameAr;
  int? governorateId;
  int? active;
  String? createdAt;
  String? updatedAt;
  getName() => getLang() ? this.name ?? "" : this.nameAr ?? "";
  WilayaModel(
      {this.id,
      this.name,
      this.nameAr,
      this.governorateId,
      this.active,
      this.createdAt,
      this.updatedAt});

  WilayaModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    governorateId = json['governorate_id'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['governorate_id'] = this.governorateId;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
