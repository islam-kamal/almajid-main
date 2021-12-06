import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/saved_addresses_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class StaticData {

  static String country_code ='+966';
  static String vistor_value;
  static String user_token = '';

  static String order_status = 'accepted';
  static int user_wallet_earnings = 0;
  static String user_mobile_number = '';

  static int product_qty = 1;
 static Future<List<SavedAddressesModel>> saved_addresses;
 static int saved_addresses_count;
 static bool new_address_status = false;



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


