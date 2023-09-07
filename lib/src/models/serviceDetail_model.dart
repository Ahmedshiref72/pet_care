import 'package:demo_project/src/models/store_model.dart';

class ServiceDetailModel {
  int? status;
  String? msg;
  Restaurant? restaurant;
  List<Review>? review;

  ServiceDetailModel({this.status, this.msg, this.restaurant, this.review});

  ServiceDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    restaurant = json['restaurant'] != null
        ? new Restaurant.fromJson(json['restaurant'])
        : null;
    if (json['review'] != null) {
      review = <Review>[];
      json['review'].forEach((v) {
        review!.add(new Review.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.restaurant != null) {
      data['restaurant'] = this.restaurant!.toJson();
    }
    if (this.review != null) {
      data['review'] = this.review!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Restaurant2 {
  String? resId;
  String? vid;
  String? catId;
  String? resName;
  String? resNameU;
  String? resDesc;
  String? resDescU;
  String? resWebsite;
  String? resPhone;
  String? resAddress;
  String? resIsOpen;
  String? resStatus;
  String? resRatings;
  String? status;
  ResImage? resImage;
  String? logo;
  String? resVideo;
  String? resUrl;
  String? mfo;
  String? mondayFrom;
  String? mondayTo;
  String? tuesdayFrom;
  String? tuesdayTo;
  String? wednesdayFrom;
  String? wednesdayTo;
  String? thursdayFrom;
  String? thursdayTo;
  String? fridayFrom;
  String? fridayTo;
  String? saturdayFrom;
  String? saturdayTo;
  String? sundayFrom;
  String? sundayTo;
  String? lat;
  String? lon;
  String? approved;
  String? resCreateDate;
  String? cName;
  String? reviewCount;
  String? vendorName;
  List<Review>? reviews;
  Restaurant2(
      {this.resId,
      this.vid,
      this.catId,
      this.resName,
      this.resNameU,
      this.resDesc,
      this.resDescU,
      this.resWebsite,
      this.resPhone,
      this.resAddress,
      this.resIsOpen,
      this.resStatus,
      this.resRatings,
      this.status,
      this.resImage,
      this.logo,
      this.resVideo,
      this.resUrl,
      this.mfo,
      this.mondayFrom,
      this.mondayTo,
      this.tuesdayFrom,
      this.tuesdayTo,
      this.wednesdayFrom,
      this.wednesdayTo,
      this.thursdayFrom,
      this.thursdayTo,
      this.fridayFrom,
      this.fridayTo,
      this.saturdayFrom,
      this.saturdayTo,
      this.sundayFrom,
      this.sundayTo,
      this.lat,
      this.lon,
      this.approved,
      this.resCreateDate,
      this.cName,
      this.reviewCount,
      this.vendorName,
      this.reviews});

  Restaurant2.fromJson(Map<String, dynamic> json) {
    resId = json['res_id'];
    vid = json['vid'];
    catId = json['cat_id'];
    resName = json['res_name'];
    resNameU = json['res_name_u'];
    resDesc = json['res_desc'];
    resDescU = json['res_desc_u'];
    resWebsite = json['res_website'];
    resPhone = json['res_phone'];
    resAddress = json['res_address'];
    resIsOpen = json['res_isOpen'];
    resStatus = json['res_status'];
    resRatings = json['res_ratings'];
    status = json['status'];
    resImage = json['res_image'] != null
        ? new ResImage.fromJson(json['res_image'])
        : null;
    logo = json['logo'];
    resVideo = json['res_video'];
    resUrl = json['res_url'];
    mfo = json['mfo'];
    mondayFrom = json['monday_from'];
    mondayTo = json['monday_to'];
    tuesdayFrom = json['tuesday_from'];
    tuesdayTo = json['tuesday_to'];
    wednesdayFrom = json['wednesday_from'];
    wednesdayTo = json['wednesday_to'];
    thursdayFrom = json['thursday_from'];
    thursdayTo = json['thursday_to'];
    fridayFrom = json['friday_from'];
    fridayTo = json['friday_to'];
    saturdayFrom = json['saturday_from'];
    saturdayTo = json['saturday_to'];
    sundayFrom = json['sunday_from'];
    sundayTo = json['sunday_to'];
    lat = json['lat'];
    lon = json['lon'];
    approved = json['approved'];
    resCreateDate = json['res_create_date'];
    cName = json['c_name'];
    reviewCount = json['review_count'];
    vendorName = json['vendor_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['res_id'] = this.resId;
    data['vid'] = this.vid;
    data['cat_id'] = this.catId;
    data['res_name'] = this.resName;
    data['res_name_u'] = this.resNameU;
    data['res_desc'] = this.resDesc;
    data['res_desc_u'] = this.resDescU;
    data['res_website'] = this.resWebsite;
    data['res_phone'] = this.resPhone;
    data['res_address'] = this.resAddress;
    data['res_isOpen'] = this.resIsOpen;
    data['res_status'] = this.resStatus;
    data['res_ratings'] = this.resRatings;
    data['status'] = this.status;
    if (this.resImage != null) {
      data['res_image'] = this.resImage!.toJson();
    }
    data['logo'] = this.logo;
    data['res_video'] = this.resVideo;
    data['res_url'] = this.resUrl;
    data['mfo'] = this.mfo;
    data['monday_from'] = this.mondayFrom;
    data['monday_to'] = this.mondayTo;
    data['tuesday_from'] = this.tuesdayFrom;
    data['tuesday_to'] = this.tuesdayTo;
    data['wednesday_from'] = this.wednesdayFrom;
    data['wednesday_to'] = this.wednesdayTo;
    data['thursday_from'] = this.thursdayFrom;
    data['thursday_to'] = this.thursdayTo;
    data['friday_from'] = this.fridayFrom;
    data['friday_to'] = this.fridayTo;
    data['saturday_from'] = this.saturdayFrom;
    data['saturday_to'] = this.saturdayTo;
    data['sunday_from'] = this.sundayFrom;
    data['sunday_to'] = this.sundayTo;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['approved'] = this.approved;
    data['res_create_date'] = this.resCreateDate;
    data['c_name'] = this.cName;
    data['review_count'] = this.reviewCount;
    data['vendor_name'] = this.vendorName;
    return data;
  }
}


class Restaurant {
  String? id;
  String? catId;
  String? resId;
  String? vId;
  String? serviceName;
  String? servicePrice;
  String? serviceDescription;
  List<String>? serviceImage;
  String? priceUnit;
  String? duration;
  String? serviceRatings;
  String? createdDate;
  String? categoryName;
  String? storeName;
  List<String>? storeImage;
  String? storeAddress;
  String? storeLatitude;
  String? storeLongitude;
  String? vendorName;
  String? reviewCount;
  String ? serviceShort;
  String? isRating;

  Restaurant(
      {this.id,
      this.catId,
      this.resId,
      this.vId,
      this.serviceName,
      this.servicePrice,
      this.serviceDescription,
      this.serviceImage,
      this.priceUnit,
      this.duration,
      this.serviceRatings,
      this.createdDate,
      this.categoryName,
      this.storeName,this.serviceShort,
      this.storeImage,
      this.storeAddress,
      this.storeLatitude,
      this.storeLongitude,
      this.vendorName,
      this.reviewCount,
      this.isRating});

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catId = json['cat_id'];
    resId = json['res_id'];
    vId = json['v_id'];
    serviceName = json['service_name'];
    serviceShort = json['service_short'] ?? '';
    servicePrice = json['service_price'];
    serviceDescription = json['service_description'];
    serviceImage = json['service_image'].cast<String>();
    priceUnit = json['price_unit'];
    duration = json['duration'];
    serviceRatings = json['service_ratings'];
    createdDate = json['created_date'];
    categoryName = json['category_name'];
    storeName = json['store_name'];
    storeImage = json['store_image'].cast<String>();
    storeAddress = json['store_address'];
    storeLatitude = json['store_latitude'];
    storeLongitude = json['store_longitude'];
    vendorName = json['vendor_name'];
    reviewCount = json['review_count'];
    isRating = json['is_rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['cat_id'] = this.catId;
    data['res_id'] = this.resId;
    data['v_id'] = this.vId;
    data['service_name'] = this.serviceName;
    data['service_price'] = this.servicePrice;
    data['service_description'] = this.serviceDescription;
    data['service_image'] = this.serviceImage;
    data['price_unit'] = this.priceUnit;
    data['duration'] = this.duration;
    data['service_ratings'] = this.serviceRatings;
    data['created_date'] = this.createdDate;
    data['category_name'] = this.categoryName;
    data['store_name'] = this.storeName;
    data['store_image'] = this.storeImage;
    data['store_address'] = this.storeAddress;
    data['store_latitude'] = this.storeLatitude;
    data['store_longitude'] = this.storeLongitude;
    data['vendor_name'] = this.vendorName;
    data['review_count'] = this.reviewCount;
    data['is_rating'] = this.isRating;
    return data;
  }
}

class Review {
  String? revId;
  String? revService;
  String? revUser;
  String? revStars;
  String? revText;
  String? revDate;
  String? username;
  String? profilePic;
  RevUserData? revUserData;

  Review(
      {this.revId,
      this.revService,
      this.revUser,
      this.revStars,
      this.revText,
      this.revDate,
      this.username,
      this.profilePic,
      this.revUserData});

  Review.fromJson(Map<String, dynamic> json) {
    revId = json['rev_id'];
    revService = json['rev_service'];
    revUser = json['rev_user'];
    revStars = json['rev_stars'];
    revText = json['rev_text'];
    revDate = json['rev_date'];
    username = json['username'];
    profilePic = json['profile_pic'];
    revUserData = json['rev_user_data'] != null
        ? new RevUserData.fromJson(json['rev_user_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rev_id'] = this.revId;
    data['rev_service'] = this.revService;
    data['rev_user'] = this.revUser;
    data['rev_stars'] = this.revStars;
    data['rev_text'] = this.revText;
    data['rev_date'] = this.revDate;
    data['username'] = this.username;
    data['profile_pic'] = this.profilePic;
    if (this.revUserData != null) {
      data['rev_user_data'] = this.revUserData!.toJson();
    }
    return data;
  }
}

class RevUserData {
  String? id;
  String? username;
  String? email;
  String? mobile;
  String? password;
  String? profilePic;
  String? facebookId;
  String? type;
  String? isGold;
  String? address;
  String? city;
  String? country;
  String? deviceToken;
  String? date;

  RevUserData(
      {this.id,
      this.username,
      this.email,
      this.mobile,
      this.password,
      this.profilePic,
      this.facebookId,
      this.type,
      this.isGold,
      this.address,
      this.city,
      this.country,
      this.deviceToken,
      this.date});

  RevUserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    mobile = json['mobile'];
    password = json['password'];
    profilePic = json['profile_pic'];
    facebookId = json['facebook_id'];
    type = json['type'];
    isGold = json['isGold'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    deviceToken = json['device_token'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['password'] = this.password;
    data['profile_pic'] = this.profilePic;
    data['facebook_id'] = this.facebookId;
    data['type'] = this.type;
    data['isGold'] = this.isGold;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['device_token'] = this.deviceToken;
    data['date'] = this.date;
    return data;
  }
}
