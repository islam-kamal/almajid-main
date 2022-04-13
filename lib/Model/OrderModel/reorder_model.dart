import 'package:almajidoud/Base/network-mappers.dart';

class ReorderModel extends BaseMappable{
  bool? success;
  String? message;

  ReorderModel({this.success, this.message});

  ReorderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    return data;
  }

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    return ReorderModel(message: message,success: success);
  }
}