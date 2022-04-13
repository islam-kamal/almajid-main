import 'package:almajidoud/utils/file_export.dart';

class ComplainModel extends BaseMappable{
  bool? status;
  int? code;
  String? msg;
  Data? data;
  Errors? errors;
  ComplainModel({this.status, this.code, this.msg, this.data,this.errors});

  ComplainModel.fromJson(Map<String, dynamic> json) {
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
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
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
    if(status!){
      return ComplainModel(status: status,msg: msg,code: code,data: data);
    }else{
      return ComplainModel(status: status,msg: msg,code: code,errors: errors);
    }

  }
}

class Data {
  var id;
  var name;
  var message;
  var email;
  var subject;
  var phone;
  var userId;
  var model;
  var deletedAt;
  var createdAt;
  var updatedAt;
  var status;
  var msgNum;

  Data(
      {this.id,
        this.name,
        this.message,
        this.email,
        this.subject,
        this.phone,
        this.userId,
        this.model,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.status,
        this.msgNum});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    message = json['message'];
    email = json['email'];
    subject = json['subject'];
    phone = json['phone'];
    userId = json['user_id'];
    model = json['model'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
    msgNum = json['msg_num'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['message'] = this.message;
    data['email'] = this.email;
    data['subject'] = this.subject;
    data['phone'] = this.phone;
    data['user_id'] = this.userId;
    data['model'] = this.model;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    data['msg_num'] = this.msgNum;
    return data;
  }
}

class Errors {
  List<String>? message;

  Errors({this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    message = json['message'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}