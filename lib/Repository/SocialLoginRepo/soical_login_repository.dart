
import 'package:almajidoud/Model/SocialLoginModel/social_login_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';



class SocialLoginRepo{
  Future<SocialLoginModel> social_login_func({String email,String name,String provider,String provider_id,String firebase_token}) async{
    FormData formData = FormData.fromMap({
      'email' : email,
      'name' : name,
      "provider": provider,
      "provider_id": provider_id,
      "firebase_token": firebase_token,
    });

    return NetworkUtil.internal().post(
        SocialLoginModel(), Urls.SOCIAL_LOGIN, body: formData);
  }



}

SocialLoginRepo socialLoginRepo = new SocialLoginRepo();