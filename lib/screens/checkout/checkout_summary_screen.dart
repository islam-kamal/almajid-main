import 'dart:convert';

import 'package:almajidoud/Bloc/Order_Bloc/order_bloc.dart';
import 'package:almajidoud/Bloc/ShippmentAddress_Bloc/shippment_address_bloc.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/screens/Payment/stc_pay/stc_pay_phone_screen.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/Payment/Constants.dart';
import 'package:almajidoud/screens/Payment/payfort/payfort_payment_screen.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/done_button.dart';
import 'package:almajidoud/screens/checkout/widgets/order_summary_widget.dart';
import 'package:almajidoud/screens/checkout/widgets/single_order_summary_item.dart';
import 'package:almajidoud/screens/checkout/widgets/single_product_summary_card.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Payment/tap/tap_payment_screen.dart';
import 'package:almajidoud/screens/Payment/tamara/tamara_payment_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;


class CheckoutSummaryScreen extends StatefulWidget{
  GuestShipmentAddressModel guestShipmentAddressModel;
  var payment_method ;
  CheckoutSummaryScreen({this.guestShipmentAddressModel,this.payment_method = ''});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckoutSummaryScreenState();
  }

}
class CheckoutSummaryScreenState extends State<CheckoutSummaryScreen> with TickerProviderStateMixin{
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();

  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  void dispose() {

    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  NetworkIndicator(
      child: PageContainer(
      child: Scaffold(
      key:_drawerKey,
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: BlocListener<OrderBloc,AppState>(
        bloc: orderBloc,
        listener: (context,state){
      if (state is Loading) {
        if(state.indicator == 'CreateOrder'){
          print("Loading");
          _playAnimation();
        }

      }
      else if (state is ErrorLoading) {
        if(state.indicator == 'CreateOrder') {
          print("ErrorLoading");
      _stopAnimation();

      Flushbar(
        messageText: Row(
          children: [
            Container(
              width: StaticData.get_width(context) * 0.7,
              child: Wrap(
                children: [
                  Text(
                    'There is Error',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(color: whiteColor),
                  ),
                ],
              ),
            ),
            Spacer(),
            Text(
              translator.translate("Try Again"),
              textDirection: TextDirection.rtl,
              style: TextStyle(color: whiteColor),
            ),
          ],
        ),
        flushbarPosition: FlushbarPosition.BOTTOM,
        backgroundColor: redColor,
        flushbarStyle: FlushbarStyle.FLOATING,
        duration: Duration(seconds: 6),
      )
        ..show(_drawerKey.currentState.context);
    }
      }

      else if (state is Done) {
        if(state.indicator == 'CreateOrder') {
      print("done");

      var data = state.general_value;
      final Future<http.Response> response = payment_repository.getPayFortSettings(
        orderId: data
      );
print(" PayFortSettings     response  : ${response}");
      response.then((response) {
               print(response.body);
        final extractedData = json.decode(response.body) as Map<String, dynamic>;
        if (extractedData["success"]) {
          sharedPreferenceManager.readString(CachingKey.CHOSSED_PAYMENT_METHOD).then((value){
            switch(value){
              case 'cashondelivery':
                customAnimatedPushNavigation(context, StaticData.vistor_value == 'visitor'? CustomCircleNavigationBar(): OrdersScreen(
                  increment_id: extractedData["increment_id"],
                ));
                break;
              case "aps_fort_cc" :
                final merchantIdentifier = extractedData["payment_config"]
                ["params"]["merchant_identifier"];
                final accessCode =
                extractedData["payment_config"]["params"]["access_code"];
                final merchantReference = extractedData["payment_config"]
                ["params"]["merchant_reference"];
                final language =
                extractedData["payment_config"]["params"]["language"];
                final serviceCommand = extractedData["payment_config"]
                ["params"]["service_command"];
                final returnUrl =
                extractedData["payment_config"]["params"]["return_url"];
                final signature =
                extractedData["payment_config"]["params"]["signature"];
                final url = extractedData["payment_config"]["url"];
                final order_number = extractedData["increment_id"];
                _stopAnimation();

                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PayfortPaymentScreen(
                      amount: widget.guestShipmentAddressModel.totals.baseGrandTotal.toString(),
                      merchantIdentifier: merchantIdentifier,
                      accessCode: accessCode,
                      merchantReference: merchantReference,
                      language: language,
                      serviceCommand: serviceCommand,
                      returnUrl: returnUrl,
                      signature: signature,
                      url: url,
                      order_number: order_number,
                    )));
                break;
              case  "tap":
                sharedPreferenceManager.writeData(CachingKey.ORDER_INCREMENTAL_ID,extractedData["increment_id"]);
                sharedPreferenceManager.writeData(CachingKey.TAP_PUBLIC_KEY,extractedData["payment_config"]["public_key"]);
                final Future<http.Response> tap_response =  payment_repository.create_token_for_Tap(
                  public_key: extractedData["payment_config"]["public_key"]
                );
                tap_response.then((result) {
                  print(result.body);
                  final tap_extractedData = json.decode(result.body) as Map<String, dynamic>;
                  if (tap_extractedData[ "errors"] == null) {
                    customAnimatedPushNavigation(context, TapPaymentScreen(
                      order_incremental_id: extractedData["increment_id"],
                      public_key: tap_extractedData["id"],
                      order_id: extractedData["increment_id"],
                    ));
                  }else{
                    _stopAnimation();
                    Flushbar(
                      messageText: Row(
                        children: [
                          Container(
                            width: StaticData.get_width(context) * 0.7,
                            child: Wrap(
                              children: [
                                Text(
                                  '${tap_extractedData[ "errors"][0]["description"]}',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            translator.translate("Try Again"),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: whiteColor),
                          ),
                        ],
                      ),
                      flushbarPosition: FlushbarPosition.BOTTOM,
                      backgroundColor: redColor,
                      flushbarStyle: FlushbarStyle.FLOATING,
                      duration: Duration(seconds: 6),
                    )..show(_drawerKey.currentState.context);

                  }
                  });
                break;
              case 'tamara_pay_by_instalments':
                customAnimatedPushNavigation(context, TamaraPaymentScreen(
                  redirect_url: extractedData["payment_config"]["redirect_url"],
                  increment_id: extractedData["increment_id"],
                ));
                break;
              case 'mestores_applepay':
                customAnimatedPushNavigation(context, StaticData.vistor_value == 'visitor'? CustomCircleNavigationBar(): OrdersScreen(
                  increment_id: extractedData["increment_id"],
                ));
                break;
            }
          });


        } else {
          print('order not found');
        }
      });

    }
      }
    },
    child: Column(
          children: [
            checkoutHeader(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            topPageIndicator(
                context: context, isPayment: true, isAddress: true, indicatorWidth: 1,
                isSummary: true),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Container(
              width: width(context),
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: isLandscape(context)
                  ? 2 * height(context) * .23
                  : height(context) * .23,
              child: ListView.builder(
                itemCount: widget.guestShipmentAddressModel.totals.items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      singleProductSummaryCard(
                          context: context,
                      prod_name: widget.guestShipmentAddressModel.totals.items[index].name,
                        prod_price: widget.guestShipmentAddressModel.totals.items[index].price,
                        prod_qty: widget.guestShipmentAddressModel.totals.items[index].qty
                      ),
                      SizedBox(width: width(context) * .05)
                    ],
                  );
                },

              ),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            singleOrderSummaryItem(
                context: context,
                isAddress: true,
                title: "Address",
                details: StaticData.order_address
            ),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            singleOrderSummaryItem(
                context: context,
                title: "Payment",
                details: "${widget.payment_method} "),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            orderSummaryWidget(
                context: context,
            subtotal: widget.guestShipmentAddressModel.totals.subtotal,
            vat: widget.guestShipmentAddressModel.totals.baseTaxAmount,
            total: widget.guestShipmentAddressModel.totals.baseGrandTotal) ,
            responsiveSizedBox(context: context, percentageOfHeight: .04),
            doneButton(context: context)

          ],
        ),
        )
      ),
    ))   );
  }

  doneButton({BuildContext context,}) {
    return StaggerAnimation(
      titleButton: translator.translate("Place Order"),
      buttonController: _loginButtonController.view,
      btn_width: width(context) * .7,
      onTap: ()async {
      await  sharedPreferenceManager.readString(CachingKey.CHOSSED_PAYMENT_METHOD).then((value){
        print("value : ${value}");
          if(value=='stc_pay'){
            customAnimatedPushNavigation(context, StcPayPhoneScreen());
          }else{
            orderBloc.add(CreateOrderEvent(
                context: context
            ));
          }
        });

      },
    );
  }


}
