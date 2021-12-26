import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StaticData {
  static List<Map> wishlist_items;

  static String country_code ='+966';
  static String vistor_value;
  static String user_token = '';
  static int product_id ;
  static String order_status = 'accepted';
  static int user_wallet_earnings = 0;
  static String user_mobile_number = '';
  static int saved_addresses_count;
  static bool chosse_address_status = false;
  static String order_address = '';
  static String order_payment_refused_reason = '';
  //order payment
  static String card_number = "";
  static String card_holder_name =  "";
  static String card_security_code = "";
  static String expiry_date = "";


  static int product_qty = 1;
 static Future<List<AddressModel>> saved_addresses;




  static List<dynamic> gallery = [];
  static List images = [];
  static  var data ;


  static double get_height(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return height;
  }

  static double get_width(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return width;
  }

  static int TOTAL_AMOUNT = 0;
  static int CART_ITEMS_NUMBER = 0;
  static List CART_IDS;
  static List<ProductModel> cartProductList = [];
  static shoppingCart(ProductModel cartProductDetailsHelper) {
    cartProductList.add(cartProductDetailsHelper);
  }


  static void Toast_Short_Message(String x){
    Fluttertoast.showToast(
        msg: x,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}


