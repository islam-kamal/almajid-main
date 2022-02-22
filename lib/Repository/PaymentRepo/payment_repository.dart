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

import 'package:network_info_plus/network_info_plus.dart';

class PaymentRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
  Dio dio = new Dio();

  Future<StcPayModel> stc_pay_genertate_otp({BuildContext context , var phone_number}) async {

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
          Urls.BASE_URL+'/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/stc-pay/get-otp',
          data: {
            "mobile": phone_number.toString().replaceRange(0,4,'0') , //"0591826195",
            "quoteId": StaticData.vistor_value == 'visitor'? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)
                :await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
           "isMask": StaticData.vistor_value == 'visitor'? true : false
          },
          options: Options(headers: headers));
      if (response.statusCode == 200) {
        return StcPayModel.fromJson(response.data);


      } else {
        return response.data;
      }
    } catch (e) {
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
      final response = await http.post(
          Uri.parse(Urls.BASE_URL+'/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/stc-pay/verify-otp'),
          body:jsonEncode( {
            "otp": otp,
            "otpReference": otpReference,
            "paymentReference": paymentReference,
            "mobile":phone_number ,
            "quoteId": StaticData.vistor_value == 'visitor'? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)
                :await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
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
    }
  }

  Future<http.Response> getPayFortSettings({var orderId}) async {
    try {
      final Map<String, dynamic> data = {
        "orderId": int.parse(orderId),
        "type": Platform.isAndroid ? "mobile_android" : "mobile_ios"
      };
      final serializedData = json.encode(data);
      final response = await http.post(Uri.parse(Urls.BASE_URL+"/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/update-order-type"),
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


  Future<http.Response> create_token_for_Tap({var public_key}) async {
  //  final info = NetworkInfo();
    var exp_month = StaticData.expiry_date.substring(2);
    var exp_year = "20" + StaticData.expiry_date.substring(0,2);
    try {
      final Map<String, dynamic> data = {
        "card": {
          "number": StaticData.card_number,
          "exp_month": exp_month,
          "exp_year": exp_year,
          "cvc": StaticData.card_security_code,
          "name": StaticData.card_holder_name,
          "address": {
            "country": "Kuwait",
            "line1": StaticData.order_address,
            "city": await sharedPreferenceManager.readString(MyApp.app_langauge == 'ar' ?CachingKey.REGION_AR :CachingKey.REGION_EN),
            "street": StaticData.order_address,
            "avenue": "Gulf"
          }
        },
        "client_ip": "192.168.1.20"
      };
      final serializedData = json.encode(data);
      final response = await http.post(Uri.parse('https://api.tap.company/v2/tokens'),
          headers: {
            "content-type": "application/json",
            "Authorization": 'Bearer ${public_key}'
          },
          body: serializedData);
      return response;
    } catch (error) {
      throw (error);
    }
  }

  Future<http.Response> getPayfortApplePayValidation({
  var apple_data , var apple_signature , var apple_version , var apple_ephemeralPublicKey , var apple_publicKeyHash,
    var apple_transactionId , var apple_displayName , var apple_network , var order_id
})async{
    try {
      final Map<String, dynamic> data = {
        "apple_data" : apple_data,
        "apple_signature" : apple_signature,
        "apple_version" : apple_version,
        "apple_ephemeralPublicKey" :apple_ephemeralPublicKey,
        "apple_publicKeyHash" : apple_publicKeyHash,
        "apple_transactionId" : apple_transactionId,
        "apple_displayName" : apple_displayName,
        "apple_network" :apple_network,
        "order_id" : order_id
      };
      final serializedData = json.encode(data);
      final response = await http.post(Uri.parse(Urls.BASE_URL+"/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/update-order-type"),
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