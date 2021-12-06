import 'package:almajidoud/Base/enumeration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceManager {
  SharedPreferences sharedPreferences;

  Future<bool> removeData(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    print("remove : ${key.value}");

    return sharedPreferences.remove(key.value);
  }

  Future<bool> logout() async {
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.clear();
  }

  Future<bool> writeData(CachingKey key, value) async {
    sharedPreferences = await SharedPreferences.getInstance();
    print(
        "saving this value $value into local prefrence with key ${key.value}");
    Future returnedValue;
    if (value is String) {
      returnedValue = sharedPreferences.setString(key.value, value);
    } else if (value is int) {
      returnedValue = sharedPreferences.setInt(key.value, value);
    } else if (value is bool) {
      returnedValue = sharedPreferences.setBool(key.value, value);
    } else if (value is double) {
      returnedValue = sharedPreferences.setDouble(key.value, value);
    } else {
      return Future.error(NotValidCacheTypeException());
    }
    return returnedValue;
  }

  Future<bool> readBoolean(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getBool(key.value) ?? false);
  }

  Future<double> readDouble(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getDouble(key.value) ?? 0.0);
  }

  Future<int> readInteger(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getInt(key.value) ?? 0);
  }

  Future<String> readString(CachingKey key) async {
    sharedPreferences = await SharedPreferences.getInstance();
    return Future.value(sharedPreferences.getString(key.value) ?? "");
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

  static const CachingKey FIREBASE_TOKEN = const CachingKey('FIREBASE_TOKEN');
  static const CachingKey CART_QUOTE = const CachingKey('CART_QUOTE');

  static const CachingKey USER_NAME = const CachingKey('USER_NAME');
  static const CachingKey EMAIL = const CachingKey('EMAIL');
  static const CachingKey MOBILE_NUMBER = const CachingKey('MOBILE_NUMBER');
  static const CachingKey USER_CITY = const CachingKey('USER_CITY');
  static const CachingKey REGION_ID = const CachingKey('REGION_ID');
  static const CachingKey REGION_AR = const CachingKey('REGION_AR');
  static const CachingKey REGION_EN = const CachingKey('REGION_EN');
  static const CachingKey CHOSSED_ADDRESS_ID = const CachingKey('CHOSSED_ADDRESS_ID');
  static const CachingKey ORDER_ID = const CachingKey('ORDER_ID');


  static const CachingKey FORGET_PASSWORD_PHONE = const CachingKey('FORGET_PASSWORD_PHONE');
  static const CachingKey DEFAULT_SHIPPING_ADDRESS = const CachingKey('DEFAULT_SHIPPING_ADDRESS');
  static const CachingKey USER_DEFAULT_LOCATION_ID = const CachingKey('USER_DEFAULT_LOCATION_ID'); //use in payment
  static const CachingKey LOGOUT = const CachingKey('LOGOUT'); //check direction to UserLocation page

  static const CachingKey MAPS_LAT = const CachingKey('lat');
  static const CachingKey Maps_lang = const CachingKey('lang');
  static const CachingKey MAP_ADDRESS = const CachingKey('map_address');
  static const CachingKey DEFAULT_CREDIT_CARD = const CachingKey('DEFAULT_CREDIT_CARD');
  static const CachingKey USER_WALLET= const CachingKey('USER_WALLET');
  static const CachingKey SOCIAL_LOGIN_TYPE= const CachingKey('SOCIAL_LOGIN_TYPE');
  static const CachingKey STRART_PRICE = const CachingKey('start_price');
  static const CachingKey END_PRICE = const CachingKey('end_price');
  static const CachingKey FILTER_RATE = const CachingKey('FILTER_RATE');
  static const CachingKey CATEGORY_ID = const CachingKey('CATEGORY_ID');
  static const CachingKey BRAND_ID = const CachingKey('BRAND_ID');
  static const CachingKey SIZE_ID = const CachingKey('SIZE_ID');
  static const CachingKey PAYMENT_METHOD = const CachingKey('PAYMENT_METHOD');
  static const CachingKey CARD_ID = const CachingKey('CARD_ID');
  static const CachingKey CVV = const CachingKey('CVV');
  static const CachingKey RECHARGE_AMOUNT = const CachingKey('RECHARGE_AMOUNT');
  static const CachingKey COUPON_IS_FRIST = const CachingKey('COUPON_IS_FRIST');

}

final sharedPreferenceManager =SharedPreferenceManager();
