

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

class GetWeeklyDealSeller extends AppEvent{
  final int offset;
  final String category_id;
  GetWeeklyDealSeller({this.category_id,this.offset});
}
class GetTestahelCollectionEvent extends AppEvent{
  final int offset;
  final String category_id;
  GetTestahelCollectionEvent({this.category_id,this.offset});
}

class ProductDetailsEvent extends AppEvent{
   var product_id , product_sku;
  ProductDetailsEvent({this.product_id,this.product_sku});
}





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
  BuildContext context;
  GlobalKey<ScaffoldState> scafffoldKey;

  getAllWishList_click({this.context,this.scafffoldKey});
}


// Shopping Cart Events
class AddProductToCartEvent extends AppEvent{
BuildContext context;
var product_quantity ;
var product_sku;
var indictor;

AddProductToCartEvent({this.context,this.product_sku,this.product_quantity,this.indictor});
}

class GetCartDetailsEvent extends AppEvent{

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
class AddressDetailsEvent extends AppEvent{
  var address_id;
  AddressDetailsEvent({this.address_id});
}

//Orders
class CreateOrderEvent extends AppEvent{
  BuildContext context;
  CreateOrderEvent({this.context});
}
class GetAllOrderEvent extends AppEvent{
  GetAllOrderEvent();
}

class ReOrderEvent extends AppEvent{
  BuildContext context;
  var order_id;
  ReOrderEvent({this.context,this.order_id});
}

//Reviews
class CreateReviewEvent extends AppEvent{
  var title,  detail, nickname, product_id ;
  CreateReviewEvent({this.product_id , this.nickname,this.detail,this.title});
}

//Payment

class StcSendVerificationCodeEvent extends AppEvent{
  BuildContext context;
  var phone;
  StcSendVerificationCodeEvent({this.context,this.phone});
}









