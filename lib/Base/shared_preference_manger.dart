import 'dart:convert';

import 'package:almajidoud/Base/enumeration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  SharedPreferences? sharedPreferences;

  Future<bool> removeData(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.remove(key.value);
  }

  Future<bool> logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences!.clear();
  }

  Future<Future> writeData(CachingKey key, value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    Future? returnedValue;
    if (value is String) {
      returnedValue = sharedPreferences!.setString(key.value, value);
    } else if (value is int) {
      returnedValue = sharedPreferences!.setInt(key.value, value);
    } else if (value is bool) {
      returnedValue = sharedPreferences!.setBool(key.value, value);
    } else if (value is double) {
      returnedValue = sharedPreferences!.setDouble(key.value, value);
    } else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  Future<bool> readBoolean(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getBool(key.value) ?? false);
  }

  Future<double> readDouble(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getDouble(key.value) ?? 0.0);
  }

  Future<int> readInteger(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getInt(key.value) ?? 0);
  }

  Future<String> readString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences!.getString(key.value) ?? "");
  }


  Future setListOfMaps(List<Map> messages , String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> messagesString = [];
    messages.forEach((element) {
      messagesString.add(json.encode(element));
    });
    await sharedPreferences.setStringList(key, messagesString);
  }

   Future<List<Map>> getListOfMaps(String key) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    List<String> messagesString =
        sharedPreferences.getStringList(key) ?? [];
    List<Map> messages = [];
    if (messagesString.isNotEmpty) {
      messagesString.forEach((element) {
        messages.add(json.decode(element));
      });
    }

    return messages;
  }

}

class NotValidCacheTypeException implements Exception {
  String message() => "Not a valid cahing type";
}



class   CachingKey extends Enum<String> {
  const CachingKey(String val) : super(val);
  static const CachingKey FRIST_TIME = const CachingKey('FRIST_TIME');
  static const CachingKey FRIST_LOGIN = const CachingKey('FRIST_LOGIN');
  static const CachingKey USER_ID = const CachingKey('USER_ID');
  static const CachingKey AUTH_TOKEN = const CachingKey('AUTH_TOKEN');
  static const CachingKey CUSTOMER_ID = const CachingKey('CUSTOMER_ID');
  static const CachingKey PROFILE_IMAGE= const CachingKey('PROFILE_IMAGE');

  static const CachingKey FIREBASE_TOKEN = const CachingKey('FIREBASE_TOKEN');
  static const CachingKey CART_QUOTE = const CachingKey('CART_QUOTE');
  static const CachingKey GUEST_CART_QUOTE = const CachingKey('GUEST_CART_QUOTE');

  static const CachingKey USER_NAME = const CachingKey('USER_NAME');
  static const CachingKey EMAIL = const CachingKey('EMAIL');
  static const CachingKey MOBILE_NUMBER = const CachingKey('MOBILE_NUMBER');
  static const CachingKey USER_COUNTRY_CODE = const CachingKey('USER_COUNTRY_CODE');
  static const CachingKey APP_LANGUAGE = const CachingKey('APP_LANGUAGE');

  static const CachingKey REGION_ID = const CachingKey('REGION_ID');
  static const CachingKey REGION_AR = const CachingKey('REGION_AR');
  static const CachingKey REGION_EN = const CachingKey('REGION_EN');
  static const CachingKey CHOSSED_ADDRESS_ID = const CachingKey('CHOSSED_ADDRESS_ID');
  static const CachingKey ORDER_ID = const CachingKey('ORDER_ID');
  static const CachingKey CHOSSED_PAYMENT_METHOD = const CachingKey('CHOSSED_PAYMENT_METHOD');

  static const CachingKey ORDER_INCREMENTAL_ID= const CachingKey('ORDER_INCREMENTAL_ID');
  static const CachingKey TAP_PUBLIC_KEY = const CachingKey('TAP_PUBLIC_KEY');
  static const CachingKey TAP_TOKEN = const CachingKey('TAP_TOKEN');


  static const CachingKey FORGET_PASSWORD_PHONE = const CachingKey('FORGET_PASSWORD_PHONE');
  static const CachingKey DEFAULT_SHIPPING_ADDRESS = const CachingKey('DEFAULT_SHIPPING_ADDRESS');
  static const CachingKey USER_DEFAULT_LOCATION_ID = const CachingKey('USER_DEFAULT_LOCATION_ID'); //use in payment
  static const CachingKey LOGOUT = const CachingKey('LOGOUT'); //check direction to UserLocation page




}

final sharedPreferenceManager =SharedPreferenceManager();
