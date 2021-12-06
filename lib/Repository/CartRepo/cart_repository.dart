import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/guest_cart_details_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'package:almajidoud/Model/CartModel/cart_item_model.dart';
class CartRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

   Future<void> create_quote({BuildContext context})async{
     print("create_quote 1");
    Dio dio = new Dio();
    try {
      print("create_quote 2");
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
      print("create_quote 3");
      if (response.statusCode == 200) {
        print("create_quote 4");
        sharedPreferenceManager.writeData(CachingKey.CART_QUOTE, response.data.toString());
      } else {
        print("create_quote 5");
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("create_quote 6");
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }

  }

  Future<AddCartModel> add_product_to_cart({BuildContext context, var product_quantity ,
    var product_sku})async{
    print("1");
    Dio dio = new Dio();
    try {
      print("user---- token : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
      print("user type : ${ StaticData.vistor_value}");
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
            StaticData.vistor_value == 'visitor'? "/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/items"
                      : Urls.Client_Add_Product_To_Cart,
            body: formData,
          headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
            'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
            'content-type': 'application/json'
          }) );


    } catch (e) {
      print("6");

      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }

  }

  Future<CartDetailsModel> get_cart_details()async{
    print("user type : ${ StaticData.vistor_value}");
    Map<String, String> headers = StaticData.vistor_value == 'visitor'? {
      'Content-Type': 'application/json',
      'Accept': 'application/json',

    } : {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
    };
    print("guest cart quote : ${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}");
    return NetworkUtil.internal().get(
        CartDetailsModel(), StaticData.vistor_value == 'visitor'?
    '${Urls.BASE_URL}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/totals'
        : Urls.Client_Cart_Details, headers: headers  );
  }

  Future<AddCartModel> update_product_quantity_cart ({var product_quantity , var item_id}) async{

    return NetworkUtil().put(
        AddCartModel(),
        StaticData.vistor_value == 'visitor'? "${Urls.BASE_URL}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/items/${item_id}"
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


    print("res 2");
    Dio dio = new Dio();
    try {

      print("res 3");
      final response = await dio.delete(
          StaticData.vistor_value == 'visitor'? "${Urls.BASE_URL}/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/items/${item_id}"
          : "${Urls.BASE_URL}/rest/V1/carts/mine/items/${item_id}",

          options: Options(
              headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
                'content-type': 'application/json',
                'Accept': 'application/json',

              })
          ));
      print("response : ${response.data}");
      if (response.statusCode == 200) {
        print("res 4");
        return response.data;

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

  Future<bool> apply_promo_code_to_cart({BuildContext context, var promo_code}) async {
    Dio dio = new Dio();
    try {
      print("*** prom_code *** ${promo_code}");
      StaticData.vistor_value == 'visitor'?
      print("guest_cart_quote : ${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}")
      :print("client_cart_quote : ${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}");
      print("promo 1");
      final response = await dio.put(
          StaticData.vistor_value == 'visitor'?
              "${Urls.BASE_URL}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons/${promo_code}"
          : "${Urls.BASE_URL}/index.php/rest/V1/carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons/${promo_code}",

          options: Options(
              headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
              'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
              'content-type': 'application/json',
              'Accept': 'application/json',
              })
          ));
      print("promo response : ${response.data}");
      if (response.statusCode == 200) {
        print("promo 2");
        return response.data;
      } else {
        print("promo 3");
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("promo 4");
      print("error : ${e.toString()}");
  //    Navigator.pop(context);
     // errorDialog(context: context, text: e.toString());
    }
  }

  Future<bool> delete_promo_code_from_cart({BuildContext context}) async {
    Dio dio = new Dio();
    try {
      StaticData.vistor_value == 'visitor'?
      print("guest_cart_quote : ${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}")
          :print("client_cart_quote : ${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}");
      print("promo 1");
      final response = await dio.delete(
          StaticData.vistor_value == 'visitor'?
          "${Urls.BASE_URL}/index.php/rest/V1/guest-carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons"
              : "${Urls.BASE_URL}/index.php/rest/V1/carts/${await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/coupons",

          options: Options(
              headers: StaticData.vistor_value == 'visitor'?  Map<String, String>.from({}) : Map<String, String>.from({
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
                'content-type': 'application/json',
                'Accept': 'application/json',

              })
          ));
      print("promo response : ${response.data}");
      if (response.statusCode == 200) {
        print("promo 2");
        return response.data;

      } else {
        print("promo 3");
        Navigator.pop(context);
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("promo 4");
      print("error : ${e.toString()}");
      Navigator.pop(context);
      errorDialog(context: context, text: e.toString());
    }


  }

}
CartRepository cartRepository = CartRepository();