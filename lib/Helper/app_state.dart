import 'package:almajidoud/Base/network-mappers.dart';
import 'package:almajidoud/utils/file_export.dart';
abstract class AppState {
  get model =>null;
}
class Start extends AppState{

}

class Loading extends AppState{
  final String? indicator;
  Mappable? model;
  Loading({this.model , this.indicator});

  @override
  String toString() {
    return indicator!;

    // TODO: implement toString
  }
}
class ProductLoading extends AppState{
  final String? indicator;
  final String? sku;
  Mappable? model;
  ProductLoading( {this.sku='',this.model , this.indicator});

  @override
  String toString() {
    return indicator!;

  }
}
class WishListToCartLoading extends AppState{
  final String? indicator;
  final String? id;
  Mappable? model;
  WishListToCartLoading( {this.id='',this.model , this.indicator});

  @override
  String toString() {
    return indicator!;

  }
}
class Done extends AppState{
  Mappable? model;
  final String? indicator;
  List<dynamic>? general_model;
  var general_value;
  Done({this.model , this.indicator,this.general_model, this.general_value});

  @override
  String toString() {
    return indicator!;

    // TODO: implement toString
  }

}
class DoneProductAdded extends AppState{
  Mappable? model;
  final String? indicator;
  List<dynamic>? general_model;
  final String? sku;
  var general_value;
  DoneProductAdded({this.sku='',this.model , this.indicator,this.general_model, this.general_value});

  @override
  String toString() {
    return sku!;

    // TODO: implement toString
  }

}
class DoneWishListToCartAdded extends AppState{
  Mappable? model;
  final String? indicator;
  List<dynamic>? general_model;
  final String? id;
  var general_value;
  DoneWishListToCartAdded({this.id='',this.model , this.indicator,this.general_model, this.general_value});

  @override
  String toString() {
    return indicator!;

    // TODO: implement toString
  }

}

class ErrorLoading extends AppState{
  Mappable? model;
  List<dynamic>? general_model;
  String? indicator;
  String? message;
  ErrorLoading({this.model,this.message,this.indicator,this.general_model});
  @override
  String toString() {
    return message!;
    // TODO: implement toString
  }

}
class ErrorLoadingProduct extends AppState{
  Mappable? model;
  List<dynamic>? general_model;
  final String? sku;
  String? indicator;
  String? message;
  ErrorLoadingProduct({this.sku='',this.model,this.message,this.indicator,this.general_model});
  @override
  String toString() {
    return indicator!;
    // TODO: implement toString
  }

}
class ErrorLoadingWishListToCart extends AppState{
  Mappable? model;
  List<dynamic>? general_model;
  final String? id;
  String? indicator;
  String? message;
  ErrorLoadingWishListToCart({this.id='',this.model,this.message,this.indicator,this.general_model});
  @override
  String toString() {
    return indicator!;
    // TODO: implement toString
  }

}
class EmptyField extends AppState{
  var value;
  EmptyField({this.value= 'بيانات الطلب غير مكتملة '});

  @override
  String toString() {
    return value!;
    // TODO: implement toString
  }


}

class RadioSelection extends AppState{
   var value;
  RadioSelection({this.value});

  @override
  String toString() {
    return value!;
  }


}
