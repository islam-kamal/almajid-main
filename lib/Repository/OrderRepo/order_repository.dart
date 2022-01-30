import 'dart:convert';

import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/OrderMode/order_model.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:almajidoud/Model/OrderMode/reorder_model.dart';
class OrderRepository {
  Future<String> create_guest_order({BuildContext context}) async {
    Dio dio = new Dio();
    print("create order url : ${     "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${StaticData.vistor_value == 'visitor'? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)
        :await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/order"}");

    try {
      final response = await dio.put(
          "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)}/order",
          data: {
            "paymentMethod": {
                 "method": await sharedPreferenceManager.readString(CachingKey.CHOSSED_PAYMENT_METHOD),
            }
          },
          options: Options(headers: Map<String, String>.from({})));
      print("^^^^order response ^^^^^ : ${response}");
      if (response.statusCode == 200) {
        print("^^^^order response.data ^^^^^ : ${response.data}");
        sharedPreferenceManager.writeData(CachingKey.ORDER_ID, response.data);
        return response.data;
      } else {
        Navigator.pop(context);
        print("^^^^order response.data['message'] ^^^^^ : ${response.data['message']}");
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
          "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/carts/mine/payment-information",
          data: {
            "paymentMethod": {
            "method": await sharedPreferenceManager.readString(CachingKey.CHOSSED_PAYMENT_METHOD),
            }
          },
          options: Options(headers: Map<String, String>.from({
            'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            'content-type': 'application/json',
            'Accept': 'application/json',
          })));
      print("create_client_order response : ${response.data}");
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


  Future<ReorderModel> re_order({BuildContext context, order_id}) async {
    Dio dio = new Dio();
    try {
      final response = await dio.post(
          "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/reorder/${order_id}",
          data: {
            "cartId":await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
            "orderId":order_id
          },
          options: Options(headers: Map<String, String>.from({
            'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            'content-type': 'application/json',
            'Accept': 'application/json',
          })));
      if (response.statusCode == 200) {
        errorDialog(context: context, text: translator.translate(  "Your order created successfully"));
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
        Urls.BASE_URL + "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/orders?searchCriteria[filter_groups][0][filters][0][field]=customer_email&searchCriteria[filter_groups][0][filters][0][value]=${user_email}&searchCriteria[filter_groups][0][filters][0][condition_type]=eq&searchCriteria[currentPage]=1&searchCriteria[pageSize]=20&searchCriteria[sortOrders][0][field]=created_at&searchCriteria[sortOrders][0][direction]=DESC",
        headers:Map<String, String>.from({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'

    })
    );
  }


}

OrderRepository orderRepository = new OrderRepository();
