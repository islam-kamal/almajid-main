import 'package:almajidoud/utils/file_export.dart';


class AuthenticationModel extends BaseMappable{
  String success;
  String errormsg;
  String successmsg;
  String customurl;
  String token;
  AuthenticationModel({this.success, this.errormsg, this.successmsg, this.customurl,this.token});

  AuthenticationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errormsg = json['errormsg'];
    successmsg = json['successmsg'];
    customurl = json['customurl'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['errormsg'] = this.errormsg;
    data['successmsg'] = this.successmsg;
    data['customurl'] = this.customurl;
    data['token'] = this.token;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    success = json['success'];
    errormsg = json['errormsg'];
    successmsg = json['successmsg'];
    customurl = json['customurl'];
    token = json['token'];

    return AuthenticationModel(success: success,customurl: customurl,errormsg: errormsg,successmsg: successmsg,token: token);
  }
}