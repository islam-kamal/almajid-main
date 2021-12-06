import 'dart:convert';

import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';

class OrderRepository {
  Future<String> create_guest_order({BuildContext context}) async {
    Dio dio = new Dio();
    try {
      final response = await dio.put(
          "${Urls.BASE_URL}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/order",
          data: {
            "paymentMethod": {"method": "cashondelivery"}
          },
          options: Options(headers: Map<String, String>.from({})));
      print("create_guest_order  response : ${response.data}");
      if (response.statusCode == 200) {
        sharedPreferenceManager.writeData(CachingKey.ORDER_ID, response.data);
        return response.data;
      } else {
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("error : ${e.toString()}");
    }
  }

  Future<String> create_client_order({BuildContext context}) async {
    Dio dio = new Dio();
    try {
      final response = await dio.post(
          "${Urls.BASE_URL}/index.php/rest/V1/carts/mine/payment-information",
          data: {
            "paymentMethod": {
              "method": "payfort_fort_cc"
            }
          },
          options: Options(headers: Map<String, String>.from({
            'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            'content-type': 'application/json',
            'Accept': 'application/json',
          })));
      print("create_client_order  response : ${response.data}");
      if (response.statusCode == 200) {
        sharedPreferenceManager.writeData(CachingKey.ORDER_ID, response.data);
        return response.data;
      } else {
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("error : ${e.toString()}");
    }
  }

}

OrderRepository orderRepository = new OrderRepository();
