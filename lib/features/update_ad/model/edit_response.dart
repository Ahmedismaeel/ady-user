class EditResponse {
  int? id;
  String? addedBy;
  int? userId;
  int? governorateId;
  int? wilyaId;
  String? phone;
  int? isCall;
  int? views;
  String? name;
  String? slug;
  String? productType;
  // List<CategoryIds>? categoryIds;
  int? categoryId;
  int? subCategoryId;
  int? subscribedPlanId;
  String? unit;
  int? minQty;
  int? refundable;
  String? digitalFileReadyStorageType;
  String? images;
  String? colorImage;
  String? thumbnail;
  String? thumbnailStorageType;
  int? published;
  int? unitPrice;
  int? purchasePrice;
  int? tax;
  String? taxType;
  String? taxModel;
  int? discount;
  String? discountType;
  int? currentStock;
  int? minimumOrderQty;
  String? details;
  int? freeShipping;
  String? createdAt;
  String? updatedAt;
  int? status;
  int? featuredStatus;
  int? requestStatus;
  int? shippingCost;
  String? code;
  double? latitude;
  double? longitude;
  int? reviewsCount;
  int? isShopTemporaryClose;
  ThumbnailFullUrl? thumbnailFullUrl;
  ThumbnailFullUrl? metaImageFullUrl;

  ThumbnailFullUrl? digitalFileReadyFullUrl;
  List<Translations>? translations;

  SeoInfo? seoInfo;

  EditResponse(
      {this.id,
      this.addedBy,
      this.userId,
      this.governorateId,
      this.wilyaId,
      this.phone,
      this.isCall,
      this.views,
      this.name,
      this.slug,
      this.productType,
      // this.categoryIds,
      this.categoryId,
      this.subCategoryId,
      this.subscribedPlanId,
      this.unit,
      this.minQty,
      this.refundable,
      this.digitalFileReadyStorageType,
      this.images,
      this.colorImage,
      this.thumbnail,
      this.thumbnailStorageType,
      this.published,
      this.unitPrice,
      this.purchasePrice,
      this.tax,
      this.taxType,
      this.taxModel,
      this.discount,
      this.discountType,
      this.currentStock,
      this.minimumOrderQty,
      this.details,
      this.freeShipping,
      this.createdAt,
      this.updatedAt,
      this.status,
      this.featuredStatus,
      this.requestStatus,
      this.shippingCost,
      this.code,
      this.latitude,
      this.longitude,
      this.reviewsCount,
      this.isShopTemporaryClose,
      this.thumbnailFullUrl,
      this.metaImageFullUrl,
      this.digitalFileReadyFullUrl,
      this.translations,
      this.seoInfo});

  EditResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addedBy = json['added_by'];
    userId = json['user_id'];
    governorateId = json['governorate_id'];
    wilyaId = json['wilya_id'];
    phone = json['phone']?.toString();
    isCall = json['is_call'];
    views = json['views'];
    name = json['name'];
    slug = json['slug'];
    productType = json['product_type'];
    // if (json['category_ids'] != null) {
    //   categoryIds = <CategoryIds>[];
    //   json['category_ids'].forEach((v) {
    //     categoryIds!.add(new CategoryIds.fromJson(v));
    //   });
    // }
    categoryId = json['category_id'];
    subCategoryId = json['sub_category_id'];
    subscribedPlanId = json['subscribed_plan_id'];
    unit = json['unit'];
    minQty = json['min_qty'];
    refundable = json['refundable'];
    digitalFileReadyStorageType = json['digital_file_ready_storage_type'];
    images = json['images'];
    colorImage = json['color_image'];
    thumbnail = json['thumbnail'];
    thumbnailStorageType = json['thumbnail_storage_type'];
    published = json['published'];
    unitPrice = json['unit_price'];
    purchasePrice = json['purchase_price'];
    tax = json['tax'];
    taxType = json['tax_type'];
    taxModel = json['tax_model'];
    discount = json['discount'];
    discountType = json['discount_type'];
    currentStock = json['current_stock'];
    minimumOrderQty = json['minimum_order_qty'];
    details = json['details'];
    freeShipping = json['free_shipping'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    featuredStatus = json['featured_status'];
    requestStatus = json['request_status'];
    shippingCost = json['shipping_cost'];
    code = json['code'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    reviewsCount = json['reviews_count'];

    isShopTemporaryClose = json['is_shop_temporary_close'];
    thumbnailFullUrl = json['thumbnail_full_url'] != null
        ? new ThumbnailFullUrl.fromJson(json['thumbnail_full_url'])
        : null;

    metaImageFullUrl = json['meta_image_full_url'] != null
        ? new ThumbnailFullUrl.fromJson(json['meta_image_full_url'])
        : null;

    digitalFileReadyFullUrl = json['digital_file_ready_full_url'] != null
        ? new ThumbnailFullUrl.fromJson(json['digital_file_ready_full_url'])
        : null;
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }

    seoInfo = json['seo_info'] != null
        ? new SeoInfo.fromJson(json['seo_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['added_by'] = this.addedBy;
    data['user_id'] = this.userId;
    data['governorate_id'] = this.governorateId;
    data['wilya_id'] = this.wilyaId;
    data['phone'] = this.phone;
    data['is_call'] = this.isCall;
    data['views'] = this.views;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['product_type'] = this.productType;
    // if (this.categoryIds != null) {
    //   data['category_ids'] = this.categoryIds!.map((v) => v.toJson()).toList();
    // }
    data['category_id'] = this.categoryId;
    data['sub_category_id'] = this.subCategoryId;
    data['subscribed_plan_id'] = this.subscribedPlanId;
    data['unit'] = this.unit;
    data['min_qty'] = this.minQty;
    data['refundable'] = this.refundable;
    data['digital_file_ready_storage_type'] = this.digitalFileReadyStorageType;
    data['images'] = this.images;
    data['color_image'] = this.colorImage;
    data['thumbnail'] = this.thumbnail;
    data['thumbnail_storage_type'] = this.thumbnailStorageType;
    data['published'] = this.published;
    data['unit_price'] = this.unitPrice;
    data['purchase_price'] = this.purchasePrice;
    data['tax'] = this.tax;
    data['tax_type'] = this.taxType;
    data['tax_model'] = this.taxModel;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['current_stock'] = this.currentStock;
    data['minimum_order_qty'] = this.minimumOrderQty;
    data['details'] = this.details;
    data['free_shipping'] = this.freeShipping;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['featured_status'] = this.featuredStatus;
    data['request_status'] = this.requestStatus;
    data['shipping_cost'] = this.shippingCost;
    data['code'] = this.code;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['reviews_count'] = this.reviewsCount;

    data['is_shop_temporary_close'] = this.isShopTemporaryClose;
    if (this.thumbnailFullUrl != null) {
      data['thumbnail_full_url'] = this.thumbnailFullUrl!.toJson();
    }

    if (this.metaImageFullUrl != null) {
      data['meta_image_full_url'] = this.metaImageFullUrl!.toJson();
    }

    if (this.digitalFileReadyFullUrl != null) {
      data['digital_file_ready_full_url'] =
          this.digitalFileReadyFullUrl!.toJson();
    }
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }

    if (this.seoInfo != null) {
      data['seo_info'] = this.seoInfo!.toJson();
    }
    return data;
  }
}

// class CategoryIds {
//   int? id;
//   int? position;

//   CategoryIds({this.id, this.position});

//   CategoryIds.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     position = json['position'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['position'] = this.position;
//     return data;
//   }
// }

class ThumbnailFullUrl {
  String? key;
  String? path;
  int? status;

  ThumbnailFullUrl({this.key, this.path, this.status});

  ThumbnailFullUrl.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    path = json['path'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['path'] = this.path;
    data['status'] = this.status;
    return data;
  }
}

class Translations {
  String? translationableType;
  int? translationableId;
  String? locale;
  String? key;
  String? value;
  int? id;

  Translations(
      {this.translationableType,
      this.translationableId,
      this.locale,
      this.key,
      this.value,
      this.id});

  Translations.fromJson(Map<String, dynamic> json) {
    translationableType = json['translationable_type'];
    translationableId = json['translationable_id'];
    locale = json['locale'];
    key = json['key'];
    value = json['value'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['translationable_type'] = this.translationableType;
    data['translationable_id'] = this.translationableId;
    data['locale'] = this.locale;
    data['key'] = this.key;
    data['value'] = this.value;
    data['id'] = this.id;
    return data;
  }
}

class SeoInfo {
  int? id;
  int? productId;
  String? title;
  String? description;
  String? index;
  String? noFollow;
  String? noImageIndex;
  String? noArchive;
  String? noSnippet;
  String? maxSnippet;
  String? maxSnippetValue;
  String? maxVideoPreview;
  String? maxVideoPreviewValue;
  String? maxImagePreview;
  String? maxImagePreviewValue;
  Null? image;
  String? createdAt;
  String? updatedAt;
  ThumbnailFullUrl? imageFullUrl;
  List<Storage>? storage;

  SeoInfo(
      {this.id,
      this.productId,
      this.title,
      this.description,
      this.index,
      this.noFollow,
      this.noImageIndex,
      this.noArchive,
      this.noSnippet,
      this.maxSnippet,
      this.maxSnippetValue,
      this.maxVideoPreview,
      this.maxVideoPreviewValue,
      this.maxImagePreview,
      this.maxImagePreviewValue,
      this.image,
      this.createdAt,
      this.updatedAt,
      this.imageFullUrl,
      this.storage});

  SeoInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    title = json['title'];
    description = json['description'];
    index = json['index'];
    noFollow = json['no_follow'];
    noImageIndex = json['no_image_index'];
    noArchive = json['no_archive'];
    noSnippet = json['no_snippet'];
    maxSnippet = json['max_snippet'];
    maxSnippetValue = json['max_snippet_value'];
    maxVideoPreview = json['max_video_preview'];
    maxVideoPreviewValue = json['max_video_preview_value'];
    maxImagePreview = json['max_image_preview'];
    maxImagePreviewValue = json['max_image_preview_value'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageFullUrl = json['image_full_url'] != null
        ? new ThumbnailFullUrl.fromJson(json['image_full_url'])
        : null;
    if (json['storage'] != null) {
      storage = <Storage>[];
      json['storage'].forEach((v) {
        storage!.add(new Storage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['index'] = this.index;
    data['no_follow'] = this.noFollow;
    data['no_image_index'] = this.noImageIndex;
    data['no_archive'] = this.noArchive;
    data['no_snippet'] = this.noSnippet;
    data['max_snippet'] = this.maxSnippet;
    data['max_snippet_value'] = this.maxSnippetValue;
    data['max_video_preview'] = this.maxVideoPreview;
    data['max_video_preview_value'] = this.maxVideoPreviewValue;
    data['max_image_preview'] = this.maxImagePreview;
    data['max_image_preview_value'] = this.maxImagePreviewValue;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.imageFullUrl != null) {
      data['image_full_url'] = this.imageFullUrl!.toJson();
    }
    if (this.storage != null) {
      data['storage'] = this.storage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Storage {
  int? id;
  String? dataType;
  String? dataId;
  String? key;
  String? value;
  String? createdAt;
  String? updatedAt;

  Storage(
      {this.id,
      this.dataType,
      this.dataId,
      this.key,
      this.value,
      this.createdAt,
      this.updatedAt});

  Storage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataType = json['data_type'];
    dataId = json['data_id'];
    key = json['key'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['data_type'] = this.dataType;
    data['data_id'] = this.dataId;
    data['key'] = this.key;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
