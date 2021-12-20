import 'package:almajidoud/Base/network-mappers.dart';

class StcPayModel extends BaseMappable{
bool status;
String message;
Result result;
Parameters parameters;
String trace;

StcPayModel({this.status, this.message, this.result,this.parameters,this.trace});

StcPayModel.fromJson(Map<String, dynamic> json) {
status = json['status'];
message = json['message'];
result =
json['result'] != null ? new Result.fromJson(json['result']) : null;
parameters = json['parameters'] != null
    ? new Parameters.fromJson(json['parameters'])
    : null;
trace = json['trace'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['status'] = this.status;
  data['message'] = this.message;
  if (this.result != null) {
    data['result'] = this.result.toJson();
  }
  if (this.parameters != null) {
    data['parameters'] = this.parameters.toJson();
  }
  data['trace'] = this.trace;
  return data;
}

  @override
  Mappable fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    parameters = json['parameters'] != null
        ? new Parameters.fromJson(json['parameters'])
        : null;
    trace = json['trace'];
    return StcPayModel(message: message,status: status,result: result,parameters: parameters,trace: trace);
  }
}

class Result {
  String otpReference;
  String paymentReference;

  Result({this.otpReference, this.paymentReference});

  Result.fromJson(Map<String, dynamic> json) {
    otpReference = json['OtpReference'];
    paymentReference = json['paymentReference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OtpReference'] = this.otpReference;
    data['paymentReference'] = this.paymentReference;
    return data;
  }
}

class Parameters {
  String fieldName;
  String fieldValue;

  Parameters({this.fieldName, this.fieldValue});

  Parameters.fromJson(Map<String, dynamic> json) {
    fieldName = json['fieldName'];
    fieldValue = json['fieldValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fieldName'] = this.fieldName;
    data['fieldValue'] = this.fieldValue;
    return data;
  }
}