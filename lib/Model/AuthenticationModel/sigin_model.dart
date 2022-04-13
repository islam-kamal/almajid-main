import 'package:almajidoud/Base/network-mappers.dart';

class SignInModel extends BaseMappable{
  String? message;
  String? trace;

  SignInModel({this.message, this.trace});

  SignInModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['trace'] = this.trace;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    message = json['message'];
    trace = json['trace'];
    return SignInModel(message: message,trace: trace);
  }
}