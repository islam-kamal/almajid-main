import 'dart:convert';
import 'dart:io';
import 'package:almajidoud/Bloc/Order_Bloc/order_bloc.dart';
import 'package:almajidoud/Model/PaymentModel/stc_pay_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/Payment/stc_pay/stc_pay_verify_phone_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class PaymentRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  Dio dio = new Dio();

  Future<void> stc_pay_genertate_otp({BuildContext context , var phone_number}) async {
    Map<String, String> headers = StaticData.vistor_value == 'visitor'? {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    } : {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
    };
    try {
      final response = await dio.post(
          Urls.BASE_URL+Urls.STC_PAY_GENERATE_OTP,
          data: {
            "mobile": "0591826195",
            "quoteId": await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
           "isMask": StaticData.vistor_value == 'visitor'? true : false
          },
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        print("response.data : ${response.data} :\n ${response.data['message']}");

     //   go to otp verification
        customAnimatedPushNavigation(context, StcVerificationCodeScreen(
          user_phone: phone_number,
          OtpReference: response.data['result']['OtpReference'],
          paymentReference: response.data['result']['paymentReference'],
        ));
      } else {
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("error : ${e.toString()}");
    }
  }

  Future<http.Response> stc_pay_validate_otp({BuildContext context , var phone_number , var otpReference , var otp ,
    var paymentReference}) async {
    Map<String, String> headers = StaticData.vistor_value == 'visitor'? {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    } : {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
    };
    try {
      print("stc_pay_verify_quote : ${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}");
      print("otp type : ${otp.runtimeType}");
      final response = await http.post(
          Uri.parse(Urls.BASE_URL+Urls.STC_PAY_VALIDATE_OTP),
          body:jsonEncode( {
            "otp": otp,
            "otpReference": otpReference,
            "paymentReference": paymentReference,
            "mobile":"0591826195",
            "quoteId": await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
            "isMask": StaticData.vistor_value == 'visitor'? true : false
          }),
         headers: headers);
      if (response.statusCode == 200) {
        return response;

      } else {
        Navigator.pop(context);
        errorDialog(context: context, text: response.body);
      }
    } catch (e) {
      print("error : ${e.toString()}");
    }
  }

  Future<http.Response> getPayFortSettings({var orderId}) async {
    //final url = '${ORDER_DATA['website_domain']}/rest/V1/mstore/update-order-type';
    print("-----------------------orderId : ${orderId}");
    try {
      final Map<String, dynamic> data = {
        "orderId": int.parse(orderId),
        "type": Platform.isAndroid ? "mobile_android" : "mobile_ios"
      };
      final serializedData = json.encode(data);
      final response = await http.post(Uri.parse(Urls.BASE_URL+"/index.php/rest/V1/mstore/update-order-type"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'Bearer ${Urls.ADMIN_TOKEN}'
          },
          body: serializedData);
      return response;
    } catch (error) {
      throw (error);
    }
  }

}
final payment_repository = PaymentRepository();