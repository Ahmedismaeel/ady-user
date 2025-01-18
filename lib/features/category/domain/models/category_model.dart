import 'package:flutter_sixvalley_ecommerce/data/model/image_full_url.dart';

class CategoryModel {
  int? _id;
  String? _name;
  String? _slug;
  String? _icon;
  String? _color;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  List<SubCategory>? _subCategories;
  bool? isSelected;
  ImageFullUrl? _imageFullUrl;
  List<ImageFullUrl>? _images;
  String? _description;

  CategoryModel(
      {int? id,
      String? name,
      String? slug,
      String? icon,
      String? color,
      int? parentId,
      int? position,
      String? createdAt,
      String? updatedAt,
      List<SubCategory>? subCategories,
      bool? isSelected,
      ImageFullUrl? imageFullUrl,
      String? description,
      List<ImageFullUrl>? images}) {
    _id = id;
    _name = name;
    _slug = slug;
    _icon = icon;
    _color = color;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _subCategories = subCategories;
    isSelected = isSelected;
    _imageFullUrl = imageFullUrl;
    _description = description;
    _images = images;
  }

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get icon => _icon;
  String? get color => _color;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<SubCategory>? get subCategories => _subCategories;
  ImageFullUrl? get imageFullUrl => _imageFullUrl;
  String? get description => _description;
  List<ImageFullUrl> get images => _images ?? [];

  CategoryModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _color = json['color'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['childes'] != null) {
      _subCategories = [];
      json['childes'].forEach((v) {
        _subCategories!.add(SubCategory.fromJson(v));
      });
    }
    if (json['images_full_url'] != null) {
      _images = [];
      json['images_full_url'].forEach((v) {
        _images!.add(ImageFullUrl.fromJson(v));
      });
    }
    _imageFullUrl = json['icon_full_url'] != null
        ? ImageFullUrl.fromJson(json['icon_full_url'])
        : null;
    _description = json['description'];
    isSelected = false;
  }
}

class SubCategory {
  int? _id;
  String? _name;
  String? _slug;
  String? _icon;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  List<SubSubCategory>? _subSubCategories;
  bool? isSelected;
  ImageFullUrl? _iconFullUrl;

  SubCategory(
      {int? id,
      String? name,
      String? slug,
      String? icon,
      int? parentId,
      int? position,
      String? createdAt,
      String? updatedAt,
      List<SubSubCategory>? subSubCategories,
      bool? isSelected,
      ImageFullUrl? iconFullUrl}) {
    _id = id;
    _name = name;
    _slug = slug;
    _icon = icon;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _subSubCategories = subSubCategories;
    isSelected = isSelected;
    _iconFullUrl = iconFullUrl;
  }

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get icon => _icon;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  ImageFullUrl? get iconFullUrl => _iconFullUrl;
  List<SubSubCategory>? get subSubCategories => _subSubCategories;

  SubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['childes'] != null) {
      _subSubCategories = [];
      json['childes'].forEach((v) {
        _subSubCategories!.add(SubSubCategory.fromJson(v));
      });
    }
    isSelected = false;
    _iconFullUrl = json['icon_full_url'] != null
        ? ImageFullUrl.fromJson(json['icon_full_url'])
        : null;
  }
}

class SubSubCategory {
  int? _id;
  String? _name;
  String? _slug;
  String? _icon;
  int? _parentId;
  int? _position;
  String? _createdAt;
  String? _updatedAt;
  ImageFullUrl? _iconFullUrl;
  SubSubCategory({
    int? id,
    String? name,
    String? slug,
    String? icon,
    int? parentId,
    int? position,
    String? createdAt,
    String? updatedAt,
    ImageFullUrl? iconFullUrl,
  }) {
    _id = id;
    _name = name;
    _slug = slug;
    _icon = icon;
    _parentId = parentId;
    _position = position;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _iconFullUrl = iconFullUrl;
  }

  int? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get icon => _icon;
  int? get parentId => _parentId;
  int? get position => _position;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  ImageFullUrl? get iconFullUrl => _iconFullUrl;

  SubSubCategory.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _icon = json['icon'];
    _parentId = json['parent_id'];
    _position = json['position'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _iconFullUrl = json['icon_full_url'] != null
        ? ImageFullUrl.fromJson(json['icon_full_url'])
        : null;
  }
}
