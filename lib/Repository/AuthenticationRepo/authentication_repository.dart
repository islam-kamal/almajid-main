
import 'package:almajidoud/Base/network_util.dart';
import 'package:almajidoud/Base/urls.dart';
import 'package:almajidoud/Model/AuthenticationModel/authentication_model.dart';
import 'package:almajidoud/Model/AuthenticationModel/user_info_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
class AuthenticationRepository{
 static SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();

  static Future<AuthenticationModel> signUp({String mobile, String firstname, String email,
            String password, String lastname})async{
    FormData formData=FormData.fromMap({
      "mobile" : mobile,
      "password" : password,
      "firstname" : firstname,
      "lastname" : lastname,
      "email" :email,
   //   "firebase_token" : await  sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)
    });

    return NetworkUtil.internal().post(AuthenticationModel(), Urls.SIGN_UP,body: formData);
  }

/* static Future<AuthenticationModel> signIn({BuildContext context,String email, String password})async{
   FormData formData=FormData.fromMap({'username': email, 'password': password});

   return NetworkUtil.internal().post(AuthenticationModel(), Urls.SIGN_IN,body: formData);


 }*/



  static Future<String> signIn({BuildContext context,String email, String password})async{

    print("res 2");
    Dio dio = new Dio();
    try {

      print("res 3");
      final response = await dio.post(Urls.BASE_URL+Urls.SIGN_IN,
          data: convert.jsonEncode({'username': email, 'password': password}) , options: Options(
              headers: {'content-type': 'application/json'}
          ));
      print("response : ${response.data}");
      if (response.statusCode == 200) {
        print("res 4");
       return StaticData.user_token = response.data;
   /*     return NetworkUtil.internal().get(
            UserInfoModel(), Urls.USER_INFO_URL, headers:{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${response}'

        });*/
      } else {
        print("res 5");
        return null;
        //errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("res 6");
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }

  }


 static Future<UserInfoModel> get_user_info({String token }){
   return NetworkUtil.internal().get(
       UserInfoModel(), Urls.USER_INFO_URL, headers:{
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Authorization': 'Bearer ${token}'

   });
 }


 static Future<AuthenticationModel> sendVerificationCode(String mobilenumber , String route){
    FormData formData = FormData.fromMap({
      'mobilenumber' : mobilenumber,
      'otptype' : route == 'login'? 'login' : route== 'ForgetPasswordScreen' ? 'forgot' : 'register',
      'email' : '',
      'resendotp' : '',
      'oldmobile' : '',
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.FORGET_PASSWORD, body: formData);
  }

  static Future<AuthenticationModel> checkOtpCode(String phone , String code, String route){
    FormData formData =FormData.fromMap({
      'mobilenumber' : phone,
      'otpcode' : code,
      'otptype' : route == 'login'? 'login' : route== 'ForgetPasswordScreen' ? 'forgot' : 'register',
      'oldmobile' : '',
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.CHECK_OTP, body: formData);
  }

  static Future<AuthenticationModel> resendOtp(String phone , String route){
    FormData formData =FormData.fromMap({
      'mobilenumber' : phone,
      'otptype' : route == 'login'? 'login' : route== 'ForgetPasswordScreen' ? 'forgot' : 'register',
      'email' : '',
      'resendotp' : '',
      'oldmobile' : '',
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.FORGET_PASSWORD ,body: formData);
  }

  static Future<ResetPasswordModel> changePassword(String phone, String password){
    FormData formData =FormData.fromMap({
      'mobilenumber' : phone,
      'password' :password,
    });
    return NetworkUtil.internal().post(ResetPasswordModel(), Urls.CHANGE_PASSWORD,body: formData);
  }

  static Future<AuthenticationModel> editProfile(String token, String username, String mobile, String email, String password ){
    FormData formData = FormData.fromMap({
      "token" : token,
      "username" : username,
      "mobile" : mobile,
      "email" : email,
      "password" : password
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.UPDATE_PROFILE, body: formData);
  }

  static Future<AuthenticationModel> logout(String token){

    FormData formData = FormData.fromMap({
      'token' : token,
    });
    return NetworkUtil.internal().post(AuthenticationModel(), Urls.LOGOUT, body: formData);
  }




}