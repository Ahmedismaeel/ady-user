import 'package:flutter_sixvalley_ecommerce/theme/controllers/theme_controller.dart';

class GovernorateModel {
  int? id;
  String? name;
  String? nameAr;
  int? active;
  String? createdAt;
  String? updatedAt;

  GovernorateModel(
      {this.id,
      this.name,
      this.nameAr,
      this.active,
      this.createdAt,
      this.updatedAt});
  getName() => getLang() ? this.name ?? "" : this.nameAr ?? "";
  GovernorateModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
