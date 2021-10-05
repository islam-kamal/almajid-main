import 'package:almajidoud/utils/file_export.dart';

class NotificationsModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  List<Data> data;

  NotificationsModel({this.status, this.code, this.msg, this.data});

  NotificationsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    return NotificationsModel(status: status,code: code,msg: msg,data: data);
  }
}

class Data {
  var id;
  var message;
  var date;
  var time;
  var title;
  var type;
  var notifiableType;
  var notifiableId;
  Notifiable notifiable;
  CreateDates createDates;
  UpdateDates updateDates;

  Data(
      {this.id,
        this.message,
        this.date,
        this.time,
        this.title,
        this.type,
        this.notifiableType,
        this.notifiableId,
        this.notifiable,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    date = json['date'];
    time = json['time'];
    title = json['title'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];
    notifiable = json['notifiable'] != null
        ? new Notifiable.fromJson(json['notifiable'])
        : null;
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
    data['message'] = this.message;
    data['date'] = this.date;
    data['time'] = this.time;
    data['title'] = this.title;
    data['type'] = this.type;
    data['notifiable_type'] = this.notifiableType;
    data['notifiable_id'] = this.notifiableId;
    if (this.notifiable != null) {
      data['notifiable'] = this.notifiable.toJson();
    }
    if (this.createDates != null) {
      data['create_dates'] = this.createDates.toJson();
    }
    if (this.updateDates != null) {
      data['update_dates'] = this.updateDates.toJson();
    }
    return data;
  }
}

class Notifiable {
  var id;
  var name;
  var email;
  var phone;
  var type;
  var promoCode;
  var address;
  var rewardPoint;
  var walletBalance;

  Notifiable(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.promoCode,
        this.address,
        this.rewardPoint,
        this.walletBalance});

  Notifiable.fromJson(Map<String, dynamic> json) {
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
  String createdAtHuman;

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
  String updatedAtHuman;

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