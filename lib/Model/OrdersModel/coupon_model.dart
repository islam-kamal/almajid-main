import 'package:almajidoud/utils/file_export.dart';
import 'package:intl/intl.dart';

class CouponModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  Data data;

  CouponModel({this.status, this.code, this.msg, this.data});

  CouponModel.fromJson(Map<String, dynamic> json) {
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
    return CouponModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  var subTotal;
  var savingAmount;
  var deliveryCharge;
  var rewardPoint;
  var total;

  Data(
      {this.subTotal,
        this.savingAmount,
        this.deliveryCharge,
        this.rewardPoint,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    subTotal = json['sub_total'];
    savingAmount = json['saving_amount'];
    deliveryCharge = json['delivery_charge'];
    rewardPoint = json['reward_point'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub_total'] = this.subTotal;
    data['saving_amount'] = this.savingAmount;
    data['delivery_charge'] = this.deliveryCharge;
    data['reward_point'] = this.rewardPoint;
    data['total'] = this.total;
    return data;
  }
}