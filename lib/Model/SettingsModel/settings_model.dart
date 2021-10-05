
import 'package:almajidoud/utils/file_export.dart';

class SettingsModel  extends BaseMappable{
  bool status;
  int code;
  String msg;
  Data data;

  SettingsModel({this.status, this.code, this.msg, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
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
    return SettingsModel(status: status,msg: msg,code: code,data: data);
  }
}

class Data {
  var id;
  var name;
  var nameAr;
  var nameEn;
  var email;
  var emailMessag;
  var phone;
  var phoneMessage;
  var fbLink;
  var twLink;
  var inLink;
  var instaLink;
  var websiteLink;
  var address;
  var logo;
  var icon;
  var aboutAr;
  var aboutEn;
  var termsConditionsEn;
  var termsConditionsAr;
  var appVersion;
  var about;
  var termsConditions;

  Data(
      {this.id,
        this.name,
        this.nameAr,
        this.nameEn,
        this.email,
        this.emailMessag,
        this.phone,
        this.phoneMessage,
        this.fbLink,
        this.twLink,
        this.inLink,
        this.instaLink,
        this.websiteLink,
        this.address,
        this.logo,
        this.icon,
        this.aboutAr,
        this.aboutEn,
        this.termsConditionsEn,
        this.termsConditionsAr,
        this.appVersion,
        this.about,
        this.termsConditions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    email = json['email'];
    emailMessag = json['email_messag'];
    phone = json['phone'];
    phoneMessage = json['phone_message'];
    fbLink = json['fb_link'];
    twLink = json['tw_link'];
    inLink = json['in_link'];
    instaLink = json['insta_link'];
    websiteLink = json['website_link'];
    address = json['address'];
    logo = json['logo'];
    icon = json['icon'];
    aboutAr = json['about_ar'];
    aboutEn = json['about_en'];
    termsConditionsEn = json['terms_conditions_en'];
    termsConditionsAr = json['terms_conditions_ar'];
    appVersion = json['app_version'];
    about = json['about'];
    termsConditions = json['terms_conditions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['email'] = this.email;
    data['email_messag'] = this.emailMessag;
    data['phone'] = this.phone;
    data['phone_message'] = this.phoneMessage;
    data['fb_link'] = this.fbLink;
    data['tw_link'] = this.twLink;
    data['in_link'] = this.inLink;
    data['insta_link'] = this.instaLink;
    data['website_link'] = this.websiteLink;
    data['address'] = this.address;
    data['logo'] = this.logo;
    data['icon'] = this.icon;
    data['about_ar'] = this.aboutAr;
    data['about_en'] = this.aboutEn;
    data['terms_conditions_en'] = this.termsConditionsEn;
    data['terms_conditions_ar'] = this.termsConditionsAr;
    data['app_version'] = this.appVersion;
    data['about'] = this.about;
    data['terms_conditions'] = this.termsConditions;
    return data;
  }
}