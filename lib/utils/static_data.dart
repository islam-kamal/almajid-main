import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
as product_model;

class StaticData {
  static List<Map> wishlist_items;
  static List<Map> product_images_list;
  static List<Map> product_images_map  = [];
  static String country_code ='+966';
  static String vistor_value;
  static String user_token = '';
  static int product_id ;
  static String order_status = 'accepted';
  static int home_category_index = 0;
  static var user_mobile_number = '';
  static int saved_addresses_count;
  static bool chosse_address_status = false;
  static String order_address = '';
  static String order_payment_refused_reason = '';
  static String discount_amount;
  static int selectedIndex = 0;
  static int chossed_address_id;


  //order payment
  static String card_number = "";
  static String card_holder_name =  "";
  static String card_security_code = "";
  static String expiry_date = "";

//reviews
  static var review_product_sku;
  static int product_qty = 1;
 static Future<List<AddressModel>> saved_addresses;




  static List<dynamic> gallery = [];
  static List<SliderImage> slider = [];
  static  var data ;
  static bool apple_pay_activation = false;

  static Map<String,dynamic> staticBanner;

  static  bool isCurrentDateInRange(DateTime startDate, DateTime endDate) {
    final currentDate = DateTime.now();
    return currentDate.isAfter(startDate) && currentDate.isBefore(endDate);
  }

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

class SliderImage{
  var id , url, english_name, arabic_name,type;
  SliderImage({this.id,this.url,this.english_name,this.arabic_name,this.type});
}

