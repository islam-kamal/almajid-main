import 'package:almajidoud/Base/network-mappers.dart';

class ResetPasswordModel extends BaseMappable{
  String succeess;
  String errormsg;
  String successmsg;
  String customurl;

  ResetPasswordModel(
      {this.succeess, this.errormsg, this.successmsg, this.customurl});

  ResetPasswordModel.fromJson(Map<String, dynamic> json) {
    succeess = json['succeess'];
    errormsg = json['errormsg'];
    successmsg = json['successmsg'];
    customurl = json['customurl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['succeess'] = this.succeess;
    data['errormsg'] = this.errormsg;
    data['successmsg'] = this.successmsg;
    data['customurl'] = this.customurl;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    succeess = json['succeess'];
    errormsg = json['errormsg'];
    successmsg = json['successmsg'];
    customurl = json['customurl'];
    return ResetPasswordModel(successmsg: successmsg,errormsg: errormsg,customurl: customurl,succeess:succeess);
  }
}