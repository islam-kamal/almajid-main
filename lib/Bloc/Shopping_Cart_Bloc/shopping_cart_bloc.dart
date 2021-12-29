import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/guest_cart_details_model.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/utils/file_export.dart';

class ShoppingCartBloc extends Bloc<AppEvent, AppState> with Validator {
  ShoppingCartBloc(AppState initialState) : super(initialState);

  BehaviorSubject<CartDetailsModel> _cart_details_subject = new BehaviorSubject<CartDetailsModel>();

  get cart_details_subject {
    return _cart_details_subject;
  }

  void drainStream() {}

  void dispose() {}

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AddProductToCartEvent) {
      yield Loading(indicator: event.indictor);
      final response = await cartRepository.add_product_to_cart_FUN(
          context: event.context,
          product_sku: event.product_sku,
          product_quantity: event.product_quantity);
      print("AddProductToCart response : ${response}");

      if (response.message != null) {
        print("AddProductToCart ErrorLoading");
        yield ErrorLoading(model: response, indicator: event.indictor);
      } else {
        print("AddProductToCart Done");
        yield Done(model: response, indicator: event.indictor);
      }
    } else if (event is GetCartDetailsEvent) {
      yield Loading(indicator: 'GetCartDetails');

      final response = await cartRepository.get_cart_details();
      print("cart response : ${response}");
      if (response.message != null) {
        yield ErrorLoading(
            message: response.message, indicator: 'GetCartDetails');
      } else {
        yield Done(model: response, indicator: 'GetCartDetails');
      }
    } else if (event is ApplyPromoCodeEvent) {
      final response = await cartRepository.apply_promo_code_to_cart(
          promo_code: event.prom_code, context: event.context);
      print("apply_promo_code response : ${response}");

      if (response != true) {
        errorDialog(
            context: event.context,
            text:
                "The coupon code isn't valid. Verify the code and try again.");
      } else {
        errorDialog(
            context: event.context, text: "Promo Code Applied Sucessfully");
      }
    } else if (event is DeletePromoCodeEvent) {
      final response = await cartRepository.delete_promo_code_from_cart(
          context: event.context);
      print("apply_promo_code response : ${response}");

      if (response != true) {
        errorDialog(context: event.context, text: "There is error Occured");
      } else {
        errorDialog(
            context: event.context, text: "Promo Code deleted Sucessfully");
      }
    }
  }
}

ShoppingCartBloc shoppingCartBloc = new ShoppingCartBloc(null);
