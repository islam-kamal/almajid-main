import 'package:almajidoud/main.dart';
import 'package:almajidoud/utils/file_export.dart';

class Urls {
  static final String ADMIN_TOKEN = 'tda5h42j6mke2q43da55wckmoeynz1n1';

  //Authentication Urls
  static final String BASE_URL = "https://test.almajed4oud.com";

  static final String SIGN_UP = "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mobilelogin/account/create";

  static final String USER_INFO_URL = "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/customers/me";

  static final String SIGN_IN =   "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/integration/customer/token";

  static final String FORGET_PASSWORD= "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/mobilelogin/otp/send";

  static final String CHECK_OTP = "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mobilelogin/otp/verify";

  static final String CHANGE_PASSWORD = "/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mobilelogin/otp/resetpassword";


  static final String GET_ALL_CATEGORIES =  '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/categories';

  static final String GET_CATEGORy_PRODUCTS = '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/products';

  static final String GET_APP_COUNTRIES = '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/directory/countries';

  static final String GET_ALL_CITIES = '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/regions/sa';

  static final String GET_ALL_OFFERS = '/${MyApp.app_langauge}-${MyApp.app_location}/api/user/offers/get-offers';

//Shopping cart Urls

  static final String CREATE_Guest_QUOTE = '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/';

  static final String CREATE_Client_QUOTE = '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/carts/mine';

  static final String Client_Add_Product_To_Cart = "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/carts/mine/items";

  static final String Client_Cart_Details = "/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/carts/mine/totals";

  static final String GET_ALL_WISHLIST_ITEMS = '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist';

  static final String ADD_NEW_ADDRESS = '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/customers/me/address';


  static final String STC_PAY_GENERATE_OTP = '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/stc-pay/get-otp';

  static final String STC_PAY_VALIDATE_OTP = '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/stc-pay/verify-otp';




  static final String LOGOUT = "/${MyApp.app_langauge}-${MyApp.app_location}/api/auth/logout";


  static final String EDIT_MY_PROFILE = '/${MyApp.app_langauge}-${MyApp.app_location}/api/auth/profile';




}
