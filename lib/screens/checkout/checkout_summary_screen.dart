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
import 'package:almajidoud/screens/checkout/widgets/order_summary_widget.dart';
import 'package:almajidoud/screens/checkout/widgets/single_order_summary_item.dart';
import 'package:almajidoud/screens/checkout/widgets/single_product_summary_card.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Payment/tap/tap_payment_screen.dart';
import 'package:almajidoud/screens/Payment/tamara/tamara_payment_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:almajidoud/screens/Payment/apple_pay/apple_pay_screen.dart';
import 'package:pay/pay.dart';

class CheckoutSummaryScreen extends StatefulWidget {
  GuestShipmentAddressModel? guestShipmentAddressModel;
  var payment_method;
  CheckoutSummaryScreen(
      {this.guestShipmentAddressModel, this.payment_method = ''});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckoutSummaryScreenState();
  }
}

class CheckoutSummaryScreenState extends State<CheckoutSummaryScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();
  bool? _show = false;
late  AnimationController _loginButtonController;
  bool isLoading = false;
  bool apple_pay_loading = false;
  String? _quoteId;

  var grand_total;
  var increment_order_id;
  var _paymentItems;
  Pay? _payClient;
  @override
  void initState() {
    getQuote().then((value) => _quoteId = value);
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);

    if (Platform.isIOS) {
      _payClient =
          Pay.withAssets(['apple_pay/default_payment_profile_apple_pay.json']);
    }

    super.initState();
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {}
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {}
  }

  @override
  void dispose() {
    _quoteId = null;

    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_show!) {
          return false;
        } else {
          return true;
         // Navigator.pop(context);
         // return null!;
        }
      },
      child: NetworkIndicator(
          child: PageContainer(
              child: Directionality(
                  textDirection: MyApp.app_langauge  == 'ar'
                      ?TextDirection.rtl
                      : TextDirection.ltr,
                  child:Scaffold(
        key: _drawerKey,
        backgroundColor: whiteColor,
        body: BlocListener<OrderBloc, AppState>(
          bloc: orderBloc,
          listener: (context, state) {
            if (state is Loading) {
              if (state.indicator == 'CreateOrder-$_quoteId') {
                _playAnimation();
              }
            }
            else if (state is ErrorLoading) {
              if (state.indicator == 'CreateOrder-$_quoteId') {
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
                )..show(_drawerKey.currentState!.context);
              }
            }
            else if (state is Done) {
              if (state.indicator == 'CreateOrder-$_quoteId') {
                var data = state.general_value;
                final Future<http.Response> response =
                    payment_repository.getPayFortSettings(orderId: data);
                response.then((response) {
                  final extractedData =
                      json.decode(response.body) as Map<String, dynamic>;
                  if (extractedData["success"]) {
                    sharedPreferenceManager
                        .readString(CachingKey.CHOSSED_PAYMENT_METHOD)
                        .then((value) {
                      switch (value) {
                        case 'cashondelivery':
                          customAnimatedPushNavigation(
                              context,
                              SubmitSuccessfulScreen(
                                order_id: extractedData["increment_id"],
                              ));
                          break;
                        case "aps_fort_cc":
                          final merchantIdentifier =
                              extractedData["payment_config"]["params"]
                                  ["merchant_identifier"];
                          final accessCode = extractedData["payment_config"]
                              ["params"]["access_code"];
                          final merchantReference =
                              extractedData["payment_config"]["params"]
                                  ["merchant_reference"];
                          final language = extractedData["payment_config"]
                              ["params"]["language"];
                          final serviceCommand = extractedData["payment_config"]
                              ["params"]["service_command"];
                          final returnUrl = extractedData["payment_config"]
                              ["params"]["return_url"];
                          final signature = extractedData["payment_config"]
                              ["params"]["signature"];
                          final url = extractedData["payment_config"]["url"];
                          final order_number = extractedData["increment_id"];
                          _stopAnimation();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => PayfortPaymentScreen(
                                    amount: widget.guestShipmentAddressModel!
                                        .totals!.baseGrandTotal
                                        .toString(),
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
                        case "tap":
                          sharedPreferenceManager.writeData(CachingKey.ORDER_INCREMENTAL_ID, extractedData["increment_id"]);
                          sharedPreferenceManager.writeData(CachingKey.TAP_PUBLIC_KEY, extractedData["payment_config"]["public_key"]);
                          final Future<http.Response> tap_response =
                              payment_repository.create_token_for_Tap(
                                  public_key: extractedData["payment_config"]["public_key"]
                              );
                          tap_response.then((result) {
                            final tap_extractedData = json.decode(result.body)
                                as Map<String, dynamic>;
                            if (tap_extractedData["errors"] == null) {
                              customAnimatedPushNavigation(
                                  context,
                                  TapPaymentScreen(
                                    order_incremental_id:
                                        extractedData["increment_id"],
                                    public_key: tap_extractedData["id"],
                                    order_id: extractedData["increment_id"],
                                  ));
                            } else {
                              _stopAnimation();
                              Flushbar(
                                messageText: Row(
                                  children: [
                                    Container(
                                      width:
                                          StaticData.get_width(context) * 0.7,
                                      child: Wrap(
                                        children: [
                                          Text(
                                            '${tap_extractedData["errors"][0]["description"]}',
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
                              )..show(_drawerKey.currentState!.context);
                            }
                          });
                          break;
                        case 'tamara_pay_by_instalments':
                          customAnimatedPushNavigation(
                              context,
                              TamaraPaymentScreen(
                                redirect_url: extractedData["payment_config"]
                                    ["redirect_url"],
                                increment_id: extractedData["increment_id"],
                              ));
                          break;
                        case 'mestores_applepay':
                          setState(() {
                            _show = true;
                          });

                          widget.guestShipmentAddressModel!.totals!.totalSegments!
                              .forEach((element) {
                            if (element.code == "grand_total") {
                              grand_total = double.parse(
                                  element.value.toStringAsFixed(2));
                            }
                          });
                          increment_order_id = extractedData["increment_id"];
                          _paymentItems = [
                            PaymentItem(
                              label: 'Almajed 4 Oud',
                              amount: grand_total.toString(),
                              status: PaymentItemStatus.final_price,
                            )
                          ];
                          break;
                      }
                    });
                  } else {}
                });
              }
            }
          },
          child: Container(
              height: height(context),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: checkoutHeader(context: context,title: "Summary"),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0),
                      child: topPageIndicator(
                          context: context,
                          isPayment: true,
                          isAddress: true,
                          indicatorWidth: 1,
                          isSummary: true),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: width(context),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: ListView.builder(
                        itemCount: widget
                            .guestShipmentAddressModel!.totals!.items!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return   singleProductSummaryCard(
                              context: context,
                              prod_name: widget.guestShipmentAddressModel!
                                  .totals!.items![index].name,
                              prod_price: widget.guestShipmentAddressModel!
                                  .totals!.items![index].rowTotalInclTax,
                              prod_qty: widget.guestShipmentAddressModel!
                                  .totals!.items![index].qty,
                              prod_image: widget
                                  .guestShipmentAddressModel!
                                  .totals!
                                  .items![index]
                                  .extensionAttributes['product_image']);
                        },
                      ),
                    ),
                  ),

                  Expanded(
                    flex:2,
                    child:   SingleChildScrollView(
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              width: width(context) * .9,
                              child: Divider(
                                color: greyColor,
                                thickness: 2,
                              )),
                          singleOrderSummaryItem(
                              context: context,
                              isAddress: true,
                              title: "Address",
                              details: StaticData.order_address),
                          Container(
                              width: width(context) * .9,
                              child: Divider(
                                color: greyColor,
                                thickness: 2,
                              )),
                        ],
                      ),
                        )
                  ),
                  Expanded(
                    flex: 1,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          singleOrderSummaryItem(
                              context: context,
                              title: "Payment Method",
                              details:
                              "${widget.payment_method == "Split into 3 payments, without fees with Tamara" ? translator.translate("Tamara") : widget.payment_method == "Credit Card" ? translator.translate("Credit/Debit Card") : widget.payment_method} ",
                              guestShipmentAddressModel:
                              widget.guestShipmentAddressModel),
                          Container(
                              width: width(context) * .9,
                              child: Divider(
                                color: greyColor,
                                thickness: 2,
                              )),
                        ],
                      ),
                    )
                  ),

                  Expanded(
                    flex: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: ListView(

                        children: [

                          orderSummaryWidget(
                              context: context,
                              total_segments: widget
                                  .guestShipmentAddressModel!.totals!.totalSegments,
                              cash: widget.payment_method),
                        ],
                      ),
                    )
                  ),
                  // responsiveSizedBox(context: context, percentageOfHeight: .04),
                  Expanded(flex: 1, child: doneButton(context: context))
                ],
              )),
        ),
        bottomSheet: _showBottomSheet(),
      ))),)
    );
  }

  doneButton({BuildContext? context,}) {
    return StaggerAnimation(
        titleButton: translator.translate("Place Order"),
        buttonController: _loginButtonController,
        btn_width: width(context) ,
        checkout_color: true,
        product_details_page:true ,
        onTap: () async {
          await sharedPreferenceManager
              .readString(CachingKey.CHOSSED_PAYMENT_METHOD)
              .then((value) {
            if (value == 'stc_pay') {
              customAnimatedPushNavigation(context!, StcPayPhoneScreen());
            } else {
              orderBloc.add(CreateOrderEvent(context: context));
            }
          });
        },
      );
  }

  Future<String> getQuote() async {
    return StaticData.vistor_value == 'visitor'
        ? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)
        : await sharedPreferenceManager.readString(CachingKey.CART_QUOTE);
  }

  Widget? _showBottomSheet() {
    if (_show!) {
      return BottomSheet(
        onClosing: () {
          _stopAnimation();
        },
        builder: (context) {
          return apple_pay_loading
              ? Container(
                  width: width(context),
                  height: width(context) * 0.6,
                  //color: greenColor,
                  child: Center(
                    child: SpinKitFadingCube(
                      color: Theme.of(context).primaryColor,
                      size: width(context) * 0.1,
                    ),
                  ),
                )
              : Container(
                  height: width(context) * 0.45,
                  decoration: BoxDecoration(
                      color: small_grey,
                      borderRadius: BorderRadius.circular(20)),
                  alignment: Alignment.center,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      Container(
                          width: width(context) * .8,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customDescriptionText(
                                  context: context,
                                  text: "Total to pay",
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                  percentageOfHeight: .020),
                              customDescriptionText(
                                  context: context,
                                  text:
                                      " $grand_total ${MyApp.country_currency}",
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                  percentageOfHeight: .025),
                            ],
                          )),
                      SizedBox(height: width(context) * 0.1),
                      FutureBuilder<bool>(
                        future: _payClient!.userCanPay(PayProvider.apple_pay),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            if (snapshot.data == true) {
                              return ApplePayButton(
                                paymentConfigurationAsset:
                                    'apple_pay/default_payment_profile_apple_pay.json',
                                paymentItems: _paymentItems,
                                style: ApplePayButtonStyle.black,
                                type: ApplePayButtonType.buy,
                                height: width(context) * 0.1,
                                margin: const EdgeInsets.only(top: 15.0),
                                onPaymentResult: onApplePayResult,
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else {
                              return ApplePayButton(
                                style: ApplePayButtonStyle.black,
                                type: ApplePayButtonType.setUp,
                                height: width(context) * 0.1,
                                margin: const EdgeInsets.only(top: 15.0),
                                loadingIndicator: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                                onPressed: () {},
                                paymentConfigurationAsset: '',
                                onPaymentResult: (Map<String, dynamic> result) {  },
                                paymentItems: [],
                              );
                            }
                          }
                          return Center(
                            child: SpinKitFadingCube(
                              color: Theme.of(context).primaryColor,
                              size: 15.0,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15)
                    ],
                  ),
                );
        },
      );
    } else {
      return null;
    }
  }

  void onApplePayResult(paymentResult) {
    setState(() {
      apple_pay_loading = true;
    });
    final token = json.decode(paymentResult["token"]);

    final Future<http.Response> response =
        payment_repository.getPayfortApplePayValidation(
      apple_data: token["data"],
      apple_signature: token["signature"],
      apple_publicKeyHash: token["header"]["publicKeyHash"],
      apple_transactionId: token["header"]["transactionId"],
      apple_ephemeralPublicKey: token["header"]["ephemeralPublicKey"],
      apple_displayName: "Almajed",
      apple_network: paymentResult["paymentMethod"]["network"],
      apple_version: token["version"],
      order_id: increment_order_id,
    );

    response.then((res) {
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData["status"]) {
        setState(() {
          apple_pay_loading = false;
        });
        customAnimatedPushNavigation(
            context,
            SubmitSuccessfulScreen(
              order_id: increment_order_id,
            ));
      } else {
        setState(() {
          apple_pay_loading = false;
        });
        customAnimatedPushNavigation(context, SubmitFaieldScreen());
      }
    });
  }
}
