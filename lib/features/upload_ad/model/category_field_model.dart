class CategoryFieldModel {
  int? id;
  int? categoryId;
  String? name;
  int? type;
  int? order;
  int? isFilter;
  int? isParent;
  String? updatedAt;
  String? createdAt;
  int? isRequired;

  CategoryFieldModel(
      {this.id,
      this.categoryId,
      this.name,
      this.type,
      this.order,
      this.isFilter,
      this.isRequired,
      this.isParent,
      this.updatedAt,
      this.createdAt});

  CategoryFieldModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['category_id'];
    name = json['name'];
    type = json['type'];
    order = json['order'];
    isFilter = json['is_filter'];
    isParent = json['is_parent'];
    isRequired = json['is_required'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category_id'] = this.categoryId;
    data['name'] = this.name;
    data['type'] = this.type;
    data['order'] = this.order;
    data['is_filter'] = this.isFilter;
    data['is_parent'] = this.isParent;
    data['is_required'] = this.isRequired;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
