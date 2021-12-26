import 'dart:convert';

import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/guest_cart_details_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class CartRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

   Future<void> create_quote({BuildContext context})async{
    Dio dio = new Dio();
    try {
      final response = await dio.post( StaticData.vistor_value == 'visitor'?
      Urls.BASE_URL +Urls.CREATE_Guest_QUOTE : Urls.BASE_URL +Urls.CREATE_Client_QUOTE,
          options: Options(
            headers: {

              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': StaticData.vistor_value == 'visitor'? null
                  :  'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
            },

          ));
      if (response.statusCode == 200) {
        sharedPreferenceManager.writeData(CachingKey.CART_QUOTE, response.data.toString());
      } else {
        //errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("create_quote 6");
      print("error : ${e.toString()}");
   //   errorDialog(context: context, text: e.toString());
    }

  }


  Future<http.Response> check_quote_status() async {
    try {

      final response = await http.get(
        Uri.parse(Urls.BASE_URL+"/${MyApp.app_langauge}-${MyApp.app_location}"
            "/index.php/rest/V1/mstore/quote/is_active/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/${StaticData.vistor_value == 'visitor'? 1 : 0}"),
          headers: {
            "content-type": "application/json",
            "Authorization": 'Bearer ${Urls.ADMIN_TOKEN}'
          },
          );

      return response;
    } catch (error) {
      throw (error);
    }
  }

  Future<AddCartModel> add_product_to_cart({BuildContext context, var product_quantity ,
    var product_sku})async{
    print("1");
    try {
        final params = {
          'cartItem': {
            'sku': product_sku,
            'qty': product_quantity,
            'quote_id': await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
          }
        };
        FormData formData = FormData.fromMap(params);
        print("4");
        return NetworkUtil().post(
            AddCartModel(),
            StaticData.vistor_value == 'visitor'? "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/items"
                      : Urls.Client_Add_Product_To_Cart,
            body: formData,
          headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
            'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            'content-type': 'application/json'
          }) );


    } catch (e) {
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }

  }

  Future<CartDetailsModel> get_cart_details()async{
    Map<String, String> headers = StaticData.vistor_value == 'visitor'? {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    } : {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
    };
    return NetworkUtil.internal().get(
        CartDetailsModel(), StaticData.vistor_value == 'visitor'?
    '${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/totals'
        : Urls.Client_Cart_Details, headers: headers  );
  }

  Future<AddCartModel> update_product_quantity_cart ({var product_quantity , var item_id}) async{

    return NetworkUtil().put(
        AddCartModel(),
        StaticData.vistor_value == 'visitor'? "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/items/${item_id}"
            : "${Urls.BASE_URL}/index.php/rest/V1/carts/mine/items/${item_id}",
        body: {
    'cartItem': {
    'item_id': item_id,
    'qty': product_quantity,
    'quote_id': await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
    }},
        headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
          'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
          'content-type': 'application/json',
          'Accept': 'application/json',

        }) );
  }

  Future<bool> delete_product_from_cart ({BuildContext context, var item_id}) async{
     Dio dio = new Dio();
    try {

      final response = await dio.delete(
          StaticData.vistor_value == 'visitor'? "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/items/${item_id}"
          : "${Urls.BASE_URL}/rest/V1/carts/mine/items/${item_id}",

          options: Options(
              headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
                'content-type': 'application/json',
                'Accept': 'application/json',

              })
          ));
      if (response.statusCode == 200) {
        return response.data;

      } else {
        return null;
        //errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("res 6");
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }

  }

  Future<bool> apply_promo_code_to_cart({BuildContext context, var promo_code}) async {
    Dio dio = new Dio();
    try {

      final response = await dio.put(
          StaticData.vistor_value == 'visitor'?
              "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons/${promo_code}"
          : "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons/${promo_code}",

          options: Options(
              headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
              'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
              'content-type': 'application/json',
              'Accept': 'application/json',
              })
          ));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("error : ${e.toString()}");
  //    Navigator.pop(context);
     // errorDialog(context: context, text: e.toString());
    }
  }

  Future<bool> delete_promo_code_from_cart({BuildContext context}) async {
    Dio dio = new Dio();
    try {
      final response = await dio.delete(
          StaticData.vistor_value == 'visitor'?
          "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons"
              : "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons",

          options: Options(
              headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
                'content-type': 'application/json',
                'Accept': 'application/json',

              })
          ));
      if (response.statusCode == 200) {
        return response.data;

      } else {
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("error : ${e.toString()}");
      Navigator.pop(context);
      errorDialog(context: context, text: e.toString());
    }


  }

}
CartRepository cartRepository = CartRepository();