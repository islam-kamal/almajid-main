import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/guest_cart_details_model.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/utils/file_export.dart';

class ShoppingCartBloc extends Bloc<AppEvent, AppState> with Validator {
  ShoppingCartBloc(AppState initialState) : super(initialState);

  BehaviorSubject<CartDetailsModel> _cart_details_subject =
      new BehaviorSubject<CartDetailsModel>();
  get cart_details_subject {
    return _cart_details_subject;
  }



  void drainStream() {}

  void dispose() {}
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AddProductToCartEvent) {
      print("1");
      yield Loading();
      final response = await cartRepository.add_product_to_cart(
          context: event.context,
          product_sku: event.product_sku,
          product_quantity: event.product_quantity);
      print("AddProductToCart response : ${response}");

      if (response.message != null) {
        print("AddProductToCart ErrorLoading");
        yield ErrorLoading(model: response);
      } else {

        print("AddProductToCart Done");
        yield Done(model: response);
      }
    }
    else if(event is GetCartDetails){
      yield Loading();

      final response =await cartRepository.get_cart_details();
      print("cart response : ${response}");
      if(response.message != null){
        yield ErrorLoading();

      }else{
        _cart_details_subject.sink.add(response);
        yield Done(model: response);
      }
    }
   else if (event is UpdateProductQuantityCartEvent) {
      print("1");
      yield Loading(indicator: 'UpdateProductQuantity');
      final response = await cartRepository.update_product_quantity_cart(
          item_id: event.item_id,
          product_quantity: event.product_quantity);
      print("UpdateProductQuantityCart response : ${response}");

      if (response.message != null) {
        print("UpdateProductQuantityCart ErrorLoading");
        yield ErrorLoading(model: response,indicator: 'UpdateProductQuantity');

      } else {
        print("UpdateProductQuantityCart Done");
        yield Done(model: response,indicator: 'UpdateProductQuantity');
      }
    }
   else if(event is DeleteProductFromCartEvent){
      print("1");
      yield Loading(indicator: 'UpdateProductQuantity');
      final response = await cartRepository.delete_product_from_cart(
          item_id: event.item_id,
         );
      print("DeleteProductFromCart response : ${response}");

      if (response != true) {
        print("DeleteProductFromCart ErrorLoading");
        yield ErrorLoading(indicator: 'DeleteProductFromCart');

      } else {
        print("DeleteProductFromCart Done");
        yield Done(indicator: 'DeleteProductFromCart');
      }
    }
  }
}

ShoppingCartBloc shoppingCartBloc = new ShoppingCartBloc(null);
