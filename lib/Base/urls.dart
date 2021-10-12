import 'package:almajidoud/utils/file_export.dart';

class Urls {
  static final String ADMIN_TOKEN = 'tda5h42j6mke2q43da55wckmoeynz1n1';

  //Authentication Urls
  static final String BASE_URL = "https://test.almajed4oud.com";

  static final String SIGN_UP = "/index.php/rest/V1/mobilelogin/account/create";

  static final String USER_INFO_URL = "/rest/V1/customers/me";

  static final String SIGN_IN =   "/index.php/rest/V1/integration/customer/token";

  static final String FORGET_PASSWORD= "/en-sa/rest/V1/mobilelogin/otp/send";

  static final String CHECK_OTP = "/index.php/rest/V1/mobilelogin/otp/verify";

  static final String CHANGE_PASSWORD = "/index.php/rest/V1/mobilelogin/otp/resetpassword";

  static final String SOCIAL_LOGIN = "/api/auth/socialLogin";

  static final String GET_ALL_CATEGORIES =  '/${translator.currentLanguage}-sa/rest/V1/categories';

  static final String GET_CATEGORy_PRODUCTS = '/${translator.currentLanguage}-sa/rest/V1/products';



  static final String LOGOUT = "/api/auth/logout";
  static final String FINGERPRINT_LOGIN = "/api/auth/BasmaLogin";
  static final String LOYALTY_SYSTEM = "/api/auth/user";
  static final String UPDATE_PROFILE = "/api/auth/profile";
  static final String REFRESH_TOKEN = "/api/auth/refresh";

  static final String HYPERPAY_PAYMENT = "/api/user/payments/PayUrl";

  static final String ADD_USER_LOCATION = "/api/user/location/store";
  static final String GET_ADDRESS_LIST = '/api/user/location/get-user-locations';
  static final String DELETE_USER_LOCATION = '/api/user/location/delete';
  static final String UPDATE_USER_LOCATION = '/api/user/location/update/';
  static final String EDIT_MY_PROFILE_PASSWORD = '/api/auth/changePassword';
  static final String EDIT_MY_PROFILE = '/api/auth/profile';
  static final String GET_ALL_OFFERS = '/api/user/offers/get-offers';
  static final String GET_ALL_RECOMMENDED_PRODUCT= '/api/user/products/recommended';
  static final String GET_MOST_SELLING= '/api/user/products/sort-products';
  static final String GET_PURCHASE_LIST= '/api/user/products/sort-products';
  static final String GET_RELEATED_PRODUCTS= '/api/user/products/related/';

  static final String GET_ALL_BRANDS = '/api/user/brands/index';
  static final String GET_ALL_SIZE = '/api/user/sizes/index';

  static final String GET_SECOND_LEVEL_SUBCATEGORY_PRODUCTS = '/api/user/products/subCategory';

  static final String GET_ALL_NOTIFICATIONS = '/api/user/notification/get';
  static final String REMOVE_NOTIFICATIONS = '/api/user/notification/delete';
  static final String GET_USER_ORDERS = '/api/user/orders/get-user-orders';
  static final String GET_WALLET_ORDERS_HISTORY= '/api/user/wallet/index';
  static final String GET_APP_SETTINGS= '/api/user/info/get-contact';
  static final String FILTER_URL= '/api/user/products/filter';
  static final String SORT_URL= '/api/user/products/sort-products';
  static final String SEARCH_URL= '/api/user/products/index';

  static final String SEND_COMPLAIN = '/api/user/info/store';
  static final String GET_USER_COMPLAINS = '/api/user/info/my-tickets';
  static final String GET_ALL_FAVOURITES = '/api/user/products/favorites/listUserFav';
  static final String ADD_TO_FAVOURITE = '/api/user/products/add-fav';
  static final String REMOVE_FROM_FAVOURITE = '/api/user/products/remove';
  static final String RATE_AND_REVIEW = '/api/user/rates/store';
  static final String ADD_CREDIT_CARD = '/api/user/cards/store';
  static final String GET_ALL_CREDIT_CARD = '/api/user/cards/get-user-cards';
  static final String DELETE_CREDIT_CARD = '/api/user/cards/delete';
  static final String UPDATE_CREDIT_CARD = '/api/user/cards/update/';
  static final String MAKE_ORDER = '/api/user/orders/store';
  static final String APPLY_COUPON = '/api/user/orders/apply-coupon';

  static final String CHARGE_WALLET = '/api/user/payments/chargeWallet';
  static final String CREDIT_CARD_PAY = '/api/user/payments/pay';
  static final String WALLET_PAY = '/api/user/payments/WalletPay';
  static final String SECOND_LEVEL_SUBCATEGORY = '/api/user/categories/parent-subCategory';
}

