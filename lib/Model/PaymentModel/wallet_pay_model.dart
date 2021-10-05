import 'package:almajidoud/utils/file_export.dart';

class WalletPayModel extends BaseMappable {
  bool status;
  int code;
  String msg;
  Data data;

  WalletPayModel({this.status, this.code, this.msg, this.data});

  WalletPayModel.fromJson(Map<String, dynamic> json) {
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
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    return WalletPayModel(status: status,code: code,msg: msg,data: data);
  }
}

class Data {
  var cost;
  var remainBalance;
  var orderId;
  var userId;
  var model;
  var updatedAt;
  var createdAt;
  var id;

  Data(
      {this.cost,
        this.remainBalance,
        this.orderId,
        this.userId,
        this.model,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    remainBalance = json['remain_balance'];
    orderId = json['order_id'];
    userId = json['user_id'];
    model = json['model'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    data['remain_balance'] = this.remainBalance;
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['model'] = this.model;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}