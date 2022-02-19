import 'dart:async';

import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/guest_cart_details_model.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:another_flushbar/flushbar.dart';
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

  void dispose() {
    _cart_details_subject.drain();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is AddProductToCartEvent) {
      yield ProductLoading(sku: event.product_sku, indicator: event.indictor);
      final response = await cartRepository.add_product_to_cart_FUN(
          context: event.context,
          product_sku: event.product_sku,
          product_quantity: event.product_quantity);

      if (response.message != null) {
        yield ErrorLoadingProduct(sku: event.product_sku, model: response, indicator: event.indictor);
      } else {
        yield DoneProductAdded(sku: event.product_sku, model: response, indicator: event.indictor);

        //update the car badge
        final cartResponse = await cartRepository.get_cart_details();
        if (cartResponse.message != null) {
          yield ErrorLoading(message: cartResponse.message, indicator: 'GetCartDetails');
        } else {
          yield Done(model: cartResponse, indicator: 'GetCartDetails');
        }

      }
    }
    else if (event is GetCartDetailsEvent) {
      yield Loading(indicator: 'GetCartDetails');

      final response = await cartRepository.get_cart_details();
      print("response : ${response}");
      if (response.message != null) {
        yield ErrorLoading(
            message: response.message, indicator: 'GetCartDetails');
      } else {
        yield Done(model: response, indicator: 'GetCartDetails');
      }
    }
    else if (event is ApplyPromoCodeEvent) {
      final response = await cartRepository.apply_promo_code_to_cart(
          promo_code: event.prom_code, context: event.context);
      if (response != true) {

        Flushbar(
          messageText:  Container(
            child: Wrap(
              children: [
                Text(
                  translator.translate("The coupon code isn't valid. Verify the code and try again."),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: whiteColor),
                ),
              ],
            ),
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: redColor,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 3),
        )..show(event.scafffoldKey.currentState.context);
      } else {
        Flushbar(
          messageText: Container(
            child: Wrap(
              children: [
                Text(
                  translator.translate("Promo Code Applied Sucessfully"),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: whiteColor),
                ),
              ],
            ),
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: greenColor,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 1),
        )..show(event.scafffoldKey.currentState.context).whenComplete((){
         // shoppingCartBloc.add(GetCartDetailsEvent());
          customAnimatedPushNavigation(event.context, CartScreen());

        });

      }
    }
    else if (event is DeletePromoCodeEvent) {
      final response = await cartRepository.delete_promo_code_from_cart(
          context: event.context);

      if (response != true) {
        Flushbar(
          messageText:  Container(
            child: Wrap(
              children: [
                Text(
                  translator.translate("Promo Code not deleted"),
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: whiteColor),
                ),
              ],
            ),
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: redColor,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 3),
        )..show(event.scafffoldKey.currentState.context);

      } else {
        StaticData.discount_amount = null;
        Flushbar(
          messageText:   Container(
            child:    Container(
              child: Wrap(
                children: [
                  Text(
                    translator.translate("Promo Code deleted Sucessfully"),
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: whiteColor),
                  ),
                ],
              ),
            ),
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: greenColor,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 1),
        )..show(event.scafffoldKey.currentState.context).whenComplete((){
            customAnimatedPushNavigation(event.context, CartScreen());

        });


      }
    }

  }
}

ShoppingCartBloc shoppingCartBloc = new ShoppingCartBloc(null);
