import 'package:flutter_sixvalley_ecommerce/data/model/image_full_url.dart';

class ChatModel {
  int? totalSize;
  String? limit;
  String? offset;
  List<Chat>? chat;

  ChatModel({this.totalSize, this.limit, this.offset, this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    totalSize = json['total_size'];
    limit = json['limit'];
    offset = json['offset'];
    if (json['chat'] != null) {
      chat = <Chat>[];
      json['chat'].forEach((v) {
        chat!.add(Chat.fromJson(v));
      });
    }
  }
}

class Chat {
  int? id;
  int? userId;
  int? sellerId;
  int? adminId;
  int? deliveryManId;
  String? message;
  bool? sentByCustomer;
  bool? sentBySeller;
  bool? sentByAdmin;
  bool? sentByDeliveryMan;
  bool? seenByCustomer;
  String? createdAt;
  String? updatedAt;
  SellerInfo? sellerInfo;
  DeliveryMan? deliveryMan;
  ChatUserModel? user;
  int? unseenMessageCount;

  Chat({
    this.id,
    this.userId,
    this.sellerId,
    this.adminId,
    this.deliveryManId,
    this.message,
    this.sentByCustomer,
    this.sentBySeller,
    this.sentByAdmin,
    this.sentByDeliveryMan,
    this.seenByCustomer,
    this.createdAt,
    this.updatedAt,
    this.sellerInfo,
    this.deliveryMan,
    this.user,
    this.unseenMessageCount,
  });

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    sellerId = json['seller_id'];
    adminId = json['admin_id'];
    if (json['delivery_man_id'] != null) {
      deliveryManId = int.parse(json['delivery_man_id'].toString());
    }

    message = json['message'];
    sentByCustomer = json['sent_by_customer'];
    sentBySeller = json['sent_by_seller'];
    sentByAdmin = json['sent_by_admin'];
    sentByDeliveryMan = json['sent_by_delivery_man'];
    seenByCustomer = json['seen_by_customer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sellerInfo = json['seller_info'] != null
        ? SellerInfo.fromJson(json['seller_info'])
        : null;
    deliveryMan = json['delivery_man'] != null
        ? DeliveryMan.fromJson(json['delivery_man'])
        : null;
    user = (json['customer'] ?? json['ader']) != null
        ? ChatUserModel.fromJson(json['customer'] ?? json['ader'])
        : null;
    unseenMessageCount = json['unseen_message_count'];
  }
}

class SellerInfo {
  List<Shops>? shops;

  SellerInfo({this.shops});

  SellerInfo.fromJson(Map<String, dynamic> json) {
    if (json['shops'] != null) {
      shops = <Shops>[];
      json['shops'].forEach((v) {
        shops!.add(Shops.fromJson(v));
      });
    }
  }
}

class Shops {
  int? id;
  int? sellerId;
  String? name;
  String? address;
  String? contact;
  String? image;
  ImageFullUrl? imageFullUrl;
  String? bottomBanner;
  String? offerBanner;
  String? vacationStartDate;
  String? vacationEndDate;
  String? vacationNote;
  bool? vacationStatus;
  bool? temporaryClose;
  String? createdAt;
  String? updatedAt;
  String? banner;

  Shops(
      {this.id,
      this.sellerId,
      this.name,
      this.address,
      this.contact,
      this.image,
      this.imageFullUrl,
      this.bottomBanner,
      this.offerBanner,
      this.vacationStartDate,
      this.vacationEndDate,
      this.vacationNote,
      this.vacationStatus,
      this.temporaryClose,
      this.createdAt,
      this.updatedAt,
      this.banner});

  Shops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = int.parse(json['seller_id'].toString());
    name = json['name'];
    address = json['address'];
    contact = json['contact'];
    image = json['image'];
    if (json['image_full_url'] != null) {
      imageFullUrl = ImageFullUrl.fromJson(json['image_full_url']);
    }
    bottomBanner = json['bottom_banner'];
    offerBanner = json['offer_banner'];
    vacationStartDate = json['vacation_start_date'];
    vacationEndDate = json['vacation_end_date'];
    vacationNote = json['vacation_note'];
    if (json['vacation_status'] != null) {
      try {
        vacationStatus = json['vacation_status'] ?? false;
      } catch (e) {
        vacationStatus = json['vacation_status'] == 1 ? true : false;
      }
    }
    if (json['temporary_close'] != null) {
      try {
        temporaryClose = json['temporary_close'] ?? false;
      } catch (e) {
        temporaryClose = json['temporary_close'] == 1 ? true : false;
      }
    }

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    banner = json['banner'];
  }
}

class DeliveryMan {
  int? id;
  String? fName;
  String? lName;
  String? image;
  String? phone;
  String? code;
  ImageFullUrl? imageFullUrl;

  DeliveryMan(
      {this.id,
      this.fName,
      this.lName,
      this.image,
      this.code,
      this.phone,
      this.imageFullUrl});

  DeliveryMan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fName = json['f_name'];
    lName = json['l_name'];
    image = json['image'];
    phone = json['phone'];
    code = json['country_code'];
    imageFullUrl = json['image_full_url'] != null
        ? ImageFullUrl.fromJson(json['image_full_url'])
        : null;
  }
}

class ChatUserModel {
  int? id;
  String? name;
  String? fName;
  String? lName;
  String? phone;
  String? image;
  String? email;
  String? createdAt;
  String? updatedAt;
  bool? isPhoneVerified;
  String? temporaryToken;
  bool? isEmailVerified;
  int? loginHitCount;
  bool? isTempBlocked;
  String? referralCode;
  String? appLanguage;
  ImageFullUrl? imageFullUrl;

  ChatUserModel(
      {this.id,
      this.name,
      this.fName,
      this.lName,
      this.phone,
      this.image,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.isPhoneVerified,
      this.temporaryToken,
      this.isEmailVerified,
      this.loginHitCount,
      this.isTempBlocked,
      this.referralCode,
      this.appLanguage,
      this.imageFullUrl});

  ChatUserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['f_name'];
    lName = json['l_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isPhoneVerified = json['is_phone_verified'];
    temporaryToken = json['temporary_token'];
    isEmailVerified = json['is_email_verified'];
    loginHitCount = json['login_hit_count'];
    isTempBlocked = json['is_temp_blocked'];
    referralCode = json['referral_code'];
    appLanguage = json['app_language'];
    imageFullUrl = json['image_full_url'] != null
        ? new ImageFullUrl.fromJson(json['image_full_url'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['f_name'] = this.fName;
    data['l_name'] = this.lName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['is_phone_verified'] = this.isPhoneVerified;
    data['temporary_token'] = this.temporaryToken;
    data['is_email_verified'] = this.isEmailVerified;
    data['login_hit_count'] = this.loginHitCount;
    data['is_temp_blocked'] = this.isTempBlocked;
    data['referral_code'] = this.referralCode;
    data['app_language'] = this.appLanguage;
    if (this.imageFullUrl != null) {
      data['image_full_url'] = this.imageFullUrl!.toJson();
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
