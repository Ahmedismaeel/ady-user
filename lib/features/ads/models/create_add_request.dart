class CreateAdRequest {
  List<String>? lang;
  List<String>? name;
  int? subCategoryId;
  int? categoryId;
  String? productType;
  List<String>? description;
  double? unitPrice;
  List<Images>? images;
  String? thumbnail;
  int? subscribedPlanId;
  double? longitude;
  double? latitude;
  int? governorateId;
  int? wilyaId;
  int? isCall;
  String? phone;
  int? subSubCategoryId;

  CreateAdRequest({
    this.lang = const ["en", "om"],
    this.name,
    this.categoryId,
    this.subCategoryId,
    this.subSubCategoryId,
    this.productType = "ad",
    this.description,
    this.unitPrice,
    this.images,
    this.thumbnail,
    this.subscribedPlanId,
    this.latitude,
    this.longitude,
    this.governorateId,
    this.wilyaId,
    this.isCall,
    this.phone,
  });

  CreateAdRequest.fromJson(Map<String, dynamic> json) {
    lang = json['lang'].cast<String>();
    name = json['name'].cast<String>();
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    subSubCategoryId = json['sub_sub_category_id'];
    governorateId = json['governorate_id'];
    wilyaId = json['wilya_id'];
    isCall = json['is_call'];
    phone = json['phone'];
    productType = json['product_type'];
    description = json['description'].cast<String>();
    unitPrice = json['unit_price'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    thumbnail = json['thumbnail'];
    subscribedPlanId = json['subscribed_plan_id'];

    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lang'] = this.lang;
    data['name'] = this.name;
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['sub_sub_category_id'] = this.subSubCategoryId;
    data['governorate_id'] = this.governorateId;
    data['is_call'] = this.isCall;

    data['wilya_id'] = this.wilyaId;
    data['phone'] = this.phone;
    data['product_type'] = this.productType;
    data['description'] = this.description;
    data['unit_price'] = this.unitPrice;
    if (this.images != null) {
      data['images'] = this.images!.map((v) => v.toJson()).toList();
    }
    data['thumbnail'] = this.thumbnail;

    data['subscribed_plan_id'] = this.subscribedPlanId;

    data['longitude'] = this.longitude;

    data['latitude'] = this.latitude;

    return data;
  }
}

class Images {
  String? imageName;
  String? storage;

  Images({this.imageName, this.storage = "public"});

  Images.fromJson(Map<String, dynamic> json) {
    imageName = json['image_name'];
    storage = json['storage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_name'] = this.imageName;
    data['storage'] = this.storage;
    return data;
  }
}
