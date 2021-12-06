

import 'package:almajidoud/utils/file_export.dart';

abstract class AppEvent {}

class click extends AppEvent{
   BuildContext context;
  click({this.context});
}
class FingerprintLoginEvent extends AppEvent{}

//User info
class UserInfoClick extends AppEvent{
  final String token;

  UserInfoClick({this.token});
}

//forget password events
class sendOtpClick extends AppEvent{
  final String phone;
  final String route;

  sendOtpClick({this.phone,this.route});
}

class checkOtpClick extends AppEvent{
  final String route;
  final String otp_code;
  checkOtpClick({this.otp_code,this.route});
}

class resendOtpClick extends AppEvent{
  final String otp_code;
  final String route;

  resendOtpClick({this.otp_code,this.route});
}

class changePasswordClick extends AppEvent{}

class UpdateCountryCodeClick extends AppEvent{
  String country_code;
  UpdateCountryCodeClick({this.country_code});
}

class GetProductReviewsEvent extends AppEvent{
  final String product_sku;
  GetProductReviewsEvent({this.product_sku});
}

class logoutClick extends AppEvent{}
class refreshToken extends AppEvent{}

//profile event
class profileClick extends AppEvent{
  var password;
  profileClick({this.password});
}


//Home Page
class GetHomeNewArrivals extends AppEvent{
  final String category_id;
  final int offset;
  GetHomeNewArrivals({this.category_id,this.offset});
}

class GetHomeBestSeller extends AppEvent{
  final int offset;
  final String category_id;
  GetHomeBestSeller({this.category_id,this.offset});
}

//SOCIAL LOGIN
class SocialLoginEvent extends AppEvent{
  var name , email , provider , provider_id ,firebase_token;

  SocialLoginEvent({this.name,this.email,this.provider,this.provider_id,this.firebase_token});
}



//offers
class getAllOffers extends AppEvent{}

//countries
class getAllCountries extends AppEvent{}

//category
class getAllCategories extends AppEvent{}
class getSecondLevelSubcategoryEvent extends AppEvent{
  final int subcategory_id;
  getSecondLevelSubcategoryEvent({this.subcategory_id});
}

class HomeSubCategoryEvent extends AppEvent{}

class getCategoryProducts extends AppEvent{
  final String category_id;
  final int offset;
  getCategoryProducts({this.category_id,this.offset});
}
class getSecondLevelSubCategoryProducts extends AppEvent{
  final String secon_level_subcategory_id;
  final int offset;
  getSecondLevelSubCategoryProducts({this.secon_level_subcategory_id,this.offset});
}
//complain
class getAllComplain extends AppEvent{}


//WishList
class AddToWishListEvent extends AppEvent{
  var product_id;
  var qty;
  BuildContext context;
  AddToWishListEvent({this.product_id,this.qty,this.context});
}
class AddToCarFromWishListEvent extends AppEvent{
  var wishlist_product_id;
  var qty;
  BuildContext context;
  AddToCarFromWishListEvent({this.wishlist_product_id,this.qty,this.context});
}
class removeFromWishListEvent extends AppEvent{
  final int wishlist_item_id;
  removeFromWishListEvent({this.wishlist_item_id});
}
class getAllWishList_click extends AppEvent{

}


// Shopping Cart Events
class AddProductToCartEvent extends AppEvent{
BuildContext context;
var product_quantity ;
var product_sku;
var indictor;
AddProductToCartEvent({this.context,this.product_sku,this.product_quantity,this.indictor});
}

class GetCartDetails extends AppEvent{

}

class UpdateProductQuantityCartEvent extends AppEvent{
  BuildContext context;
  var product_quantity ;
  var product_sku;
  var item_id;
  UpdateProductQuantityCartEvent({this.context,this.product_sku,this.product_quantity,this.item_id});
}
class DeleteProductFromCartEvent extends AppEvent{
  var item_id;
  BuildContext context;
  DeleteProductFromCartEvent({this.item_id,this.context});
}
class ApplyPromoCodeEvent extends AppEvent{
  var prom_code;
  BuildContext context;
  ApplyPromoCodeEvent({this.prom_code,this.context});
}

class DeletePromoCodeEvent extends AppEvent{
  BuildContext context;
  DeletePromoCodeEvent({this.context});
}


// SEARCH
class SearchProductsEvent extends AppEvent{
  final String search_text;
  SearchProductsEvent({this.search_text});
}

// Shipment Address

class GuestAddAdressEvent extends AppEvent{
  BuildContext context;
  GuestAddAdressEvent({this.context});
}
class AddNewAdressEvent extends AppEvent{
  BuildContext context;
  AddNewAdressEvent({this.context});
}

//Orders
class CreateOrderEvent extends AppEvent{
  BuildContext context;
  CreateOrderEvent({this.context});
}

// CREDIT CARD
class updateCreditCard extends AppEvent{
  final String card_id;
  updateCreditCard({this.card_id});
}
class getAllCreditCard_click extends AppEvent{
}

//Locations
class addNewLocation extends AppEvent{

}
class updateLocation extends AppEvent{
  final String location_id;
  updateLocation({this.location_id});
}
class getAllAddresses_click extends AppEvent{
}

//Notifications
class GetAllNotificationEvent extends AppEvent{
}
class RemoveNotificationEvent extends AppEvent{
  List<int> id;
  RemoveNotificationEvent({this.id});
}

//Loyalty System
class LoyaltySystemEvent extends AppEvent{
}


//ORDERS
class UserOrdersEvent extends AppEvent{}
class MakeOrderEvent extends AppEvent{
  String selected_delivery_time, selected_delivery_date, cupon;
  int payment_method_id, location_id;
  List<int> product_ids, products_quantity;

  MakeOrderEvent({this.selected_delivery_time,this.selected_delivery_date,this.cupon,this.payment_method_id,this.location_id,
                   this.products_quantity,this.product_ids});
}
class ApplyCouponEvent extends AppEvent{
  String  cupon;
  List<int> product_ids, products_quantity;

  ApplyCouponEvent({this.cupon, this.products_quantity,this.product_ids});
}
//wallet
class getWalletHistoryOrdersEvent extends AppEvent{}
class ChargeWalletEvent extends AppEvent{
  int card_id;
  String amount;
  String cvv;
  ChargeWalletEvent({this.card_id,this.amount,this.cvv});
}


class cashoutDeliveryEvent extends AppEvent{
  final String delivery_id;
  cashoutDeliveryEvent({this.delivery_id});
}

//Settings
class AppSettingsEvent extends AppEvent{}


//PAYMENT
class PayByCreditCardEvent extends AppEvent{
   int order_id;
   int card_id;
   String amount;
   String cvv;
  PayByCreditCardEvent({this.order_id,this.card_id,this.amount,this.cvv});
}

class PayByWalletEvent extends AppEvent{
  int order_id;
  String amount;
  PayByWalletEvent({this.order_id,this.amount});
}