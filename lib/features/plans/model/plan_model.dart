class PlanModel {
  int? id;
  String? name;
  int? count;
  double? price;
  int? type;
  int? discount;
  int? duration;
  int? isActive;
  int? categoryId;
  int? expiryDuration;
  String? createdAt;
  String? description;
  String? updatedAt;
  int? totalCount;
  int? is_default;

  PlanModel(
      {this.id,
      this.name,
      this.count,
      this.price,
      this.type,
      this.discount,
      this.duration,
      this.isActive,
      this.expiryDuration,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.totalCount,
      this.is_default,
      this.description});

  PlanModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    is_default = json['is_default'];
    description = json['description'];
    name = json['name'];
    count = json['count'];
    price = double.parse('${json['price']}');
    categoryId = json['category_id'];
    type = json['type'];
    discount = json['discount'];
    duration = json['duration'];
    isActive = json['is_active'];
    expiryDuration = json['expiry_duration'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    totalCount = json['total_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_default'] = this.is_default;
    data['id'] = this.id;
    data['name'] = this.name;
    data['count'] = this.count;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['type'] = this.type;
    data['description'] = this.description;
    data['discount'] = this.discount;
    data['duration'] = this.duration;
    data['is_active'] = this.isActive;
    data['expiry_duration'] = this.expiryDuration;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['total_count'] = this.totalCount;
    return data;
  }
}
