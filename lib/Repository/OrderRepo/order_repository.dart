import 'dart:convert';

import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/OrderMode/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
class OrderRepository {
  Future<String> create_guest_order({BuildContext context}) async {
    Dio dio = new Dio();
    try {
      final response = await dio.put(
          "${Urls.BASE_URL}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/order",
          data: {
            "paymentMethod": {
              //     "method": await sharedPreferenceManager.readString(CachingKey.CHOSSED_PAYMENT_METHOD),
             "method":  'aps_fort_cc'
            }
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
              //    "method": await sharedPreferenceManager.readString(CachingKey.CHOSSED_PAYMENT_METHOD),
            "method" : "aps_fort_cc"
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


  Future<AllOrdersModel> get_all_orders({var user_email}) async{
    return NetworkUtil.internal().get(
        AllOrdersModel(),
        Urls.BASE_URL + "/index.php/rest/V1/orders?searchCriteria[filter_groups][0][filters][0][field]=customer_email&searchCriteria[filter_groups][0][filters][0][value]=${user_email}&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[currentPage]=1&searchCriteria[pageSize]=20&searchCriteria[sortOrders][0][field]=created_at&searchCriteria[sortOrders][0][direction]=DESC",
        headers:Map<String, String>.from({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'

    })
    );
  }





/*
  Future<http.Response> getPayFortSettings() async {
    // final url = '${ORDER_DATA['website_domain']}/rest/V1/mstore/update-order-type';
    final url = 'https://test.almajed4oud.com/index.php/rest/V1/mstore/update-order-type';
    try {
      final Map<String,dynamic> data = {
        "orderId": 3499,
        "type": "mobile_android"
      };
      final serializedData = json.encode(data);
      final response = await http.post(Uri.parse(url), headers: {
        "content-type": "application/json",
        "Authorization": "Bearer tda5h42j6mke2q43da55wckmoeynz1n1"
      }, body: serializedData);
      print("response-- : ${response.body}");
      return response;
    } catch (error) {
      throw (error);
    }
  }*/
}

OrderRepository orderRepository = new OrderRepository();
