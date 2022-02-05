import 'package:almajidoud/Base/network_util.dart';
import 'package:almajidoud/utils/urls.dart';
import 'package:almajidoud/Model/AuthenticationModel/authentication_model.dart';
import 'package:almajidoud/Model/AuthenticationModel/user_info_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;

class AuthenticationRepository {
  static SharedPreferenceManager sharedPreferenceManager =
      SharedPreferenceManager();

  static Future<AuthenticationModel> signUp(
      {String mobile,
      String firstname,
      String email,
      String password,
      String lastname}) async {
    FormData formData = FormData.fromMap({
      "mobile": mobile,
      "password": password,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      //   "firebase_token" : await  sharedPreferenceManager.readString(CachingKey.FIREBASE_TOKEN)
    });

    return NetworkUtil.internal().post(AuthenticationModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mobilelogin/account/create",
        body: formData);
  }

  static Future<String> signIn(
      {BuildContext context, String email, String password}) async {
    Dio dio = new Dio();

    try {
      final response = await dio.post(
          Urls.BASE_URL + "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/integration/customer/token",
          data: convert.jsonEncode({'username': email, 'password': password}),
          options: Options(headers: {'content-type': 'application/json'}));
      print("response : $response");

      if (response.statusCode == 200) {
        return StaticData.user_token = response.data;
      } else {
        return null;
      }
    } catch (e) {
    }
  }

  static Future<UserInfoModel> get_user_info({String token}) {
    return NetworkUtil.internal().get(UserInfoModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/customers/me",
        headers: Map<String, String>.from({
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${token}'
        }));
  }

  static Future<AuthenticationModel> sendVerificationCode(
      String mobilenumber, String route) {
    FormData formData = FormData.fromMap({
      'mobilenumber': mobilenumber,
      'otptype': route == 'login'
          ? 'login'
          : route == 'ForgetPasswordScreen'
              ? 'forgot'
              : 'register',
      'email': '',
      'resendotp': '',
      'oldmobile': '',
    });
    return NetworkUtil.internal().post(AuthenticationModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/mobilelogin/otp/send",
        body: formData);
  }

  static Future<AuthenticationModel> checkOtpCode(
      String phone, String code, String route) {
    FormData formData = FormData.fromMap({
      'mobilenumber': phone,
      'otpcode': code,
      'otptype': route == 'login' || route == 'LoginWithPhoneScreen'
          ? 'login'
          : route == 'ForgetPasswordScreen'
              ? 'forgot'
              : 'register',
      'oldmobile': '',
    });
    return NetworkUtil.internal().post(AuthenticationModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mobilelogin/otp/verify",
        body: formData);
  }

  static Future<AuthenticationModel> resendOtp(String phone, String route) {
    FormData formData = FormData.fromMap({
      'mobilenumber': phone,
      'otptype': route == 'login'
          ? 'login'
          : route == 'ForgetPasswordScreen'
              ? 'forgot'
              : 'register',
      'email': '',
      'resendotp': '',
      'oldmobile': '',
    });
    return NetworkUtil.internal().post(AuthenticationModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/mobilelogin/otp/send",
        body: formData);
  }

  static Future<ResetPasswordModel> changePassword(
      String phone, String password) {
    FormData formData = FormData.fromMap({
      'mobilenumber': phone,
      'password': password,
    });
    return NetworkUtil.internal().post(ResetPasswordModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mobilelogin/otp/resetpassword",
        body: formData);
  }

  static Future<AuthenticationModel> logout(String token) {
    FormData formData = FormData.fromMap({
      'token': token,
    });
    return NetworkUtil.internal().post(AuthenticationModel(),
        "/${MyApp.app_langauge}-${MyApp.app_location}/api/auth/logout",
        body: formData);
  }

  static Future<bool> updateUserProfile(
      {String firstName,
      String lastName,
      String email,
      String phone,
      String token}) async {
    final payload = convert.jsonEncode({
      "customer": {
        "email": email,
        "firstname": firstName,
        "lastname": lastName,
        "custom_attributes": [
          {"attribute_code": "mobile_number", "value": phone}
        ]
      }
    });
    Dio dio = new Dio();
    try {
      final response = await dio.put(Urls.BASE_URL + Urls.UPDATE_PROFILE,
          data: payload,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer ${token}'
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateDeviceToken({
    int customerId,
    String deviceToken,
  }) async {
    final payload =
        convert.jsonEncode({"customerId": customerId, "token": deviceToken});
    Dio dio = new Dio();
    try {
      final response = await dio.post(Urls.BASE_URL + Urls.UPDATE_DEVICE_TOKEN,
          data: payload,
          options: Options(headers: {
            'content-type': 'application/json',
            'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
          }));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
