import 'package:almajidoud/utils/file_export.dart';

class CreditCardPayModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  Data data;

  CreditCardPayModel({this.status, this.code, this.msg, this.data});

  CreditCardPayModel.fromJson(Map<String, dynamic> json) {
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
    return CreditCardPayModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  var orderId;
  var userId;
  var transactionId;
  var buildNumber;
  var ndc;
  var amount;
  var payTime;
  var updatedAt;
  var createdAt;
  var id;

  Data(
      {this.orderId,
        this.userId,
        this.transactionId,
        this.buildNumber,
        this.ndc,
        this.amount,
        this.payTime,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    transactionId = json['transaction_id'];
    buildNumber = json['buildNumber'];
    ndc = json['ndc'];
    amount = json['amount'];
    payTime = json['pay_time'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['transaction_id'] = this.transactionId;
    data['buildNumber'] = this.buildNumber;
    data['ndc'] = this.ndc;
    data['amount'] = this.amount;
    data['pay_time'] = this.payTime;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}