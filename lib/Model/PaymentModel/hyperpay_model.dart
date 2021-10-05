import 'package:almajidoud/utils/file_export.dart';

class HyperPayModel extends BaseMappable{
  bool status;
  int code;
  String msg;
  String data;

  HyperPayModel({this.status, this.code, this.msg, this.data});

  HyperPayModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['msg'] = this.msg;
    data['data'] = this.data;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    msg = json['msg'];
    data = json['data'];
    return HyperPayModel(status: status,code: code,msg: msg,data: data);
  }
}

