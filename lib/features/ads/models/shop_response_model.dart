class ShopResponse {
  int? totalSize;
  int? limit;
  int? offset;
  List<Shops>? shops;

  ShopResponse({this.totalSize, this.limit, this.offset, this.shops});

  ShopResponse.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(new Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_size'] = this.totalSize;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    if (this.shops != null) {
      data['shops'] = this.shops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  int? id;
  int? sellerId;
  String? name;
  String? slug;
  String? address;
  String? contact;
  String? image;
  String? imageStorageType;
  String? bottomBanner;
  String? bottomBannerStorageType;
  String? offerBanner;
  String? offerBannerStorageType;
  String? vacationStartDate;
  String? vacationEndDate;
  String? vacationNote;
  bool? vacationStatus;
  bool? temporaryClose;
  String? createdAt;
  String? updatedAt;
  String? banner;
  String? bannerStorageType;
  double? latitude;
  double? longitude;
  double? distance;
  ImageFullUrl? imageFullUrl;
  ImageFullUrl? bottomBannerFullUrl;
  ImageFullUrl? offerBannerFullUrl;
  ImageFullUrl? bannerFullUrl;

  Shops(
      {this.id,
      this.sellerId,
      this.name,
      this.slug,
      this.address,
      this.contact,
      this.image,
      this.imageStorageType,
      this.bottomBanner,
      this.bottomBannerStorageType,
      this.offerBanner,
      this.offerBannerStorageType,
      this.vacationStartDate,
      this.vacationEndDate,
      this.vacationNote,
      this.vacationStatus,
      this.temporaryClose,
      this.createdAt,
      this.updatedAt,
      this.banner,
      this.bannerStorageType,
      this.latitude,
      this.longitude,
      this.distance,
      this.imageFullUrl,
      this.bottomBannerFullUrl,
      this.offerBannerFullUrl,
      this.bannerFullUrl});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['seller_id'];
    name = json['name'];
    slug = json['slug'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    imageStorageType = json['image_storage_type'];
    bottomBanner = json['bottom_banner'];
    bottomBannerStorageType = json['bottom_banner_storage_type'];
    offerBanner = json['offer_banner'];
    offerBannerStorageType = json['offer_banner_storage_type'];
    vacationStartDate = json['vacation_start_date'];
    vacationEndDate = json['vacation_end_date'];
    vacationNote = json['vacation_note'];
    vacationStatus = json['vacation_status'];
    temporaryClose = json['temporary_close'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
    bannerStorageType = json['banner_storage_type'];
    latitude = double.tryParse("${json['latitude']}");
    longitude = double.tryParse("${json['longitude']}");
    distance = double.tryParse("${json['distance']}"); 
    imageFullUrl = json['image_full_url'] != null
        ? new ImageFullUrl.fromJson(json['image_full_url'])
        : null;
    bottomBannerFullUrl = json['bottom_banner_full_url'] != null
        ? new ImageFullUrl.fromJson(json['bottom_banner_full_url'])
        : null;
    offerBannerFullUrl = json['offer_banner_full_url'] != null
        ? new ImageFullUrl.fromJson(json['offer_banner_full_url'])
        : null;
    bannerFullUrl = json['banner_full_url'] != null
        ? new ImageFullUrl.fromJson(json['banner_full_url'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['seller_id'] = this.sellerId;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['address'] = this.address;
    data['contact'] = this.contact;
    data['image'] = this.image;
    data['image_storage_type'] = this.imageStorageType;
    data['bottom_banner'] = this.bottomBanner;
    data['bottom_banner_storage_type'] = this.bottomBannerStorageType;
    data['offer_banner'] = this.offerBanner;
    data['offer_banner_storage_type'] = this.offerBannerStorageType;
    data['vacation_start_date'] = this.vacationStartDate;
    data['vacation_end_date'] = this.vacationEndDate;
    data['vacation_note'] = this.vacationNote;
    data['vacation_status'] = this.vacationStatus;
    data['temporary_close'] = this.temporaryClose;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['banner'] = this.banner;
    data['banner_storage_type'] = this.bannerStorageType;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['distance'] = this.distance;
    if (this.imageFullUrl != null) {
      data['image_full_url'] = this.imageFullUrl!.toJson();
    }
    if (this.bottomBannerFullUrl != null) {
      data['bottom_banner_full_url'] = this.bottomBannerFullUrl!.toJson();
    }
    if (this.offerBannerFullUrl != null) {
      data['offer_banner_full_url'] = this.offerBannerFullUrl!.toJson();
    }
    if (this.bannerFullUrl != null) {
      data['banner_full_url'] = this.bannerFullUrl!.toJson();
    }
    return data;
  }
}

class ImageFullUrl {
  String? key;
  String? path;
  int? status;

  ImageFullUrl({this.key, this.path, this.status});

  ImageFullUrl.fromJson(Map<String, dynamic> json) {
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
