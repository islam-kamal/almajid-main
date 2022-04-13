import 'package:almajidoud/utils/file_export.dart';

class RateAndReviewModel extends BaseMappable{
  bool? status;
  int? code;
  String? msg;
  Data? data;

  RateAndReviewModel({this.status, this.code, this.msg, this.data});

  RateAndReviewModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return RateAndReviewModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  var id;
  var value;
  var productQuality;
  var deliveryTime;
  var usingExperiences;
  var comment;
  var product;
  var userId;
  User? user;
  CreateDates? createDates;
  UpdateDates? updateDates;

  Data(
      {this.id,
        this.value,
        this.productQuality,
        this.deliveryTime,
        this.usingExperiences,
        this.comment,
        this.product,
        this.userId,
        this.user,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    productQuality = json['product_quality'];
    deliveryTime = json['delivery_time'];
    usingExperiences = json['using_experiences'];
    comment = json['comment'];
    product = json['product'];
    userId = json['user_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    createDates = json['create_dates'] != null
        ? new CreateDates.fromJson(json['create_dates'])
        : null;
    updateDates = json['update_dates'] != null
        ? new UpdateDates.fromJson(json['update_dates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['product_quality'] = this.productQuality;
    data['delivery_time'] = this.deliveryTime;
    data['using_experiences'] = this.usingExperiences;
    data['comment'] = this.comment;
    data['product'] = this.product;
    data['user_id'] = this.userId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates!.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates!.toJson();
    }
    return data;
  }
}

class User {
  var id;
  var name;
  var email;
  var phone;
  var type;
  var promoCode;
  var address;
  var rewardPoint;
  var walletBalance;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.promoCode,
        this.address,
        this.rewardPoint,
        this.walletBalance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    promoCode = json['promo_code'];
    address = json['address'];
    rewardPoint = json['reward_point'];
    walletBalance = json['wallet_balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['promo_code'] = this.promoCode;
    data['address'] = this.address;
    data['reward_point'] = this.rewardPoint;
    data['wallet_balance'] = this.walletBalance;
    return data;
  }
}

class CreateDates {
  String? createdAtHuman;

  CreateDates({this.createdAtHuman});

  CreateDates.fromJson(Map<String, dynamic> json) {
    createdAtHuman = json['created_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_at_human'] = this.createdAtHuman;
    return data;
  }
}

class UpdateDates {
  String? updatedAtHuman;

  UpdateDates({this.updatedAtHuman});

  UpdateDates.fromJson(Map<String, dynamic> json) {
    updatedAtHuman = json['updated_at_human'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated_at_human'] = this.updatedAtHuman;
    return data;
  }
}