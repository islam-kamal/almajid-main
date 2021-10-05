import 'package:almajidoud/utils/file_export.dart';

class CreditCardModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  Data data;
  Errors errors;
  CreditCardModel({this.status, this.code, this.msg, this.data,this.errors});

  CreditCardModel.fromJson(Map<String, dynamic> json) {
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
      data['data'] = this.data.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors.toJson();
    }
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors = json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
    if(status){
      return CreditCardModel(status: status,msg: msg,code: code,data: data);
    }else{
      return CreditCardModel(status: status,msg: msg,code: code,errors: errors);

    }

  }
}

class Data {
  int id;
  String holderName;
  String number;
  String expYear;
  String expMonth;
  User user;
  CreateDates createDates;
  UpdateDates updateDates;

  Data(
      {this.id,
        this.holderName,
        this.number,
        this.expYear,
        this.expMonth,
        this.user,
        this.createDates,
        this.updateDates});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holderName = json['holder_name'];
    number = json['number'];
    expYear = json['exp_year'];
    expMonth = json['exp_month'];
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
    data['holder_name'] = this.holderName;
    data['number'] = this.number;
    data['exp_year'] = this.expYear;
    data['exp_month'] = this.expMonth;
    if (this.user != null) {
      data['user'] = this.user.toJson();
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

class Errors {
  List<String> holderName;
  List<String> number;
  List<String> expYear;
  List<String> expMonth;

  Errors({this.holderName, this.number, this.expYear, this.expMonth});

  Errors.fromJson(Map<String, dynamic> json) {
    print("--holder --- ${json['holder_name']}");
    holderName = json['holder_name']==null?null :json['holder_name'].cast<String>();
    number = json['number'] ==null?null :json['number'].cast<String>();
    expYear = json['exp_year']==null?null :json['exp_year'].cast<String>();
    expMonth = json['exp_month']==null?null :json['exp_month'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holder_name'] = this.holderName;
    data['number'] = this.number;
    data['exp_year'] = this.expYear;
    data['exp_month'] = this.expMonth;
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String phone;
  String type;
  Null promoCode;
  Null address;

  User(
      {this.id,
        this.name,
        this.email,
        this.phone,
        this.type,
        this.promoCode,
        this.address});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    type = json['type'];
    promoCode = json['promo_code'];
    address = json['address'];
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

