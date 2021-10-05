import 'package:almajidoud/Model/ProfileModel/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';



class ProfileRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

   Future<ProfileModel> editMyProfilePasswordFunc(
      {String new_password, String password_confirmation}) async{
    FormData formData = FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "password": new_password,
      "password_confirmation": password_confirmation,
      "lang": "ar",
    });

    return NetworkUtil.internal().post(
        ProfileModel(), Urls.EDIT_MY_PROFILE_PASSWORD, body: formData);
  }


  Future<ProfileModel> editMyProfileFunc(
      {String name, String email,String phone}) async{
    FormData formData = FormData.fromMap({
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "email": email ,
      "phone": phone ,
      "name": name ,
      "lang": "ar",
    });

    return NetworkUtil.internal().post(
        ProfileModel(), Urls.EDIT_MY_PROFILE, body: formData);
  }
}
final profile_repository = ProfileRepository();