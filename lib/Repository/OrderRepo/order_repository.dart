import 'dart:convert';

import 'package:almajidoud/Model/OrdersModel/coupon_model.dart';
import 'package:almajidoud/Model/OrdersModel/make_order_model.dart';
import 'package:almajidoud/Model/OrdersModel/order_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';


class OrderRepository{
  Future<OrderModel> get_user_orders() async{
    Map<String, String> header={
       'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    };
    return NetworkUtil.internal().get(OrderModel(), Urls.GET_USER_ORDERS, headers: header);
  }


  Future<MakeOrderModel> make_order({String delivery_time,String delivery_date, int payment_method_id,int location_id,
  List<int> qty ,List<int> products, int card_id ,String coupon})async{
    print("order peoducts : ${products}");
    print("card_id : ${card_id}");
    print("delivery_time : ${delivery_time}");
    print("delivery_date : ${delivery_date}");
    print("payment_method_id : ${payment_method_id}");
    print("location_id : ${location_id}");
    print("products : ${products}");
    print("qty : ${qty}");
    print("coupon : ${coupon}");

    FormData formData=FormData.fromMap({
      'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "card_id" :  card_id,
      "delivery_time" : delivery_time,
      "delivery_date" :delivery_date,
      "payment_method_id" :payment_method_id,
      "location_id" :location_id,
      "products":jsonEncode(products),
      "qty" : jsonEncode(qty),
     // "card_id" :card_id,
      "coupon" : coupon
    });
    print("order peoducts 11");
    return NetworkUtil.internal().post(MakeOrderModel(), Urls.MAKE_ORDER,body: formData);
  }


  Future<CouponModel> applyCoupon({List<int> qty ,List<int> products ,String coupon})async{
    print("#peoducts# : ${products}");
    print("qty : ${qty}");
    print("coupon : ${coupon}");
    FormData formData=FormData.fromMap({
      'token' :  await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      "products":jsonEncode(products),
      "qty" : jsonEncode(qty),
      "coupon" : coupon
    });

    return NetworkUtil.internal().post(CouponModel(), Urls.APPLY_COUPON,body: formData);
  }
}

OrderRepository orderRepository = new OrderRepository();