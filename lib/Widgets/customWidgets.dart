import 'dart:convert';

import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:pay/pay.dart';
import 'package:http/http.dart' as http;



class CustomComponents{

  static Future<bool> isFirstTime() async {
    bool isFirstTime = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_TIME);
    if (isFirstTime != null && !isFirstTime) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, true);
      return false;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, true);
      return true;
    }
  }
  static Future<bool> isFirstLogin() async {
    bool isFirstLogin = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_LOGIN);
    if (isFirstLogin != null && !isFirstLogin) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_LOGIN, true);
      return true;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_LOGIN, false);
      return false;
    }
  }

  static Future<bool> isLogout() async {
    bool is_Logout = await sharedPreferenceManager.readBoolean(CachingKey.LOGOUT);
    if (is_Logout != null &&  !is_Logout ) {
      sharedPreferenceManager.writeData(CachingKey.LOGOUT, true);
      return true;
    } else {
      sharedPreferenceManager.writeData(CachingKey.LOGOUT, false);
      return false;
    }
  }

  static Widget buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(whiteColor),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  static Widget buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  static Widget buildEmptyListWidget(BuildContext context,String message) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/Splash_Screen/splash_screen.png'),
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              fit: BoxFit.fill,
            ),
            Text("$message",style: TextStyle(color: greenColor),),
          ],
        ));
  }


/*
  static void applePayBottomSheet({BuildContext context, var total}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width ;
   var _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: total.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
    showModalBottomSheet<void>(
        context: context,
        shape: OutlineInputBorder(
          borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return  Directionality(
              textDirection: translator.currentLanguage =='ar'?TextDirection.rtl : TextDirection.ltr,
              child:Container(
                height: width * 0.6,
                child:  Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(left: width * .075, right: width * .075, ),
                        alignment: translator.currentLanguage =='ar'?Alignment.centerRight : Alignment.centerLeft,
                        child:   Image.asset( "assets/icons/apple pay.png",
                            height: MediaQuery.of(context).size.height*.13
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child:  Container(
                          width: StaticData.get_width(context) * .9,
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
                                  text: "${MyApp.country_currency} $total",
                                  fontWeight: FontWeight.bold,
                                  textAlign: TextAlign.start,
                                  percentageOfHeight: .020),
                            ],
                          )),
                    ),
                    Expanded(
                      flex: 1,
                      child:      ApplePayButton(
                        paymentConfigurationAsset: 'apple_pay/default_payment_profile_apple_pay.json',
                        paymentItems: _paymentItems,
                        style: ApplePayButtonStyle.black,
                        type: ApplePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onApplePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }

    );
  }
 static void onApplePayResult(paymentResult,{BuildContext context , var order_incremental_id}) {
    debugPrint(paymentResult.toString());
    final token = json.decode(paymentResult["token"]);
    debugPrint("after extracted data");

    final Future<http.Response> response = payment_repository.getPayfortApplePayValidation(
      apple_data: token["data"],
      apple_signature: token["signature"],
      apple_publicKeyHash: token["header"]["publicKeyHash"],
      apple_transactionId:token["header"]["transactionId"],
      apple_ephemeralPublicKey: token["header"]["ephemeralPublicKey"],
      apple_displayName: "Almajed",
      apple_network: paymentResult["paymentMethod"]["network"],
      apple_version: token["version"],
      order_id: order_incremental_id,
    );

    response.then((res) {
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData["status"]) {
        customAnimatedPushNavigation(context, SubmitSuccessfulScreen(
          order_id: order_incremental_id,
        ));
      }else{
        customAnimatedPushNavigation(context, SubmitFaieldScreen());
      }
    });
  }
*/

  static String order_status(String status){
    switch(status){
      case "order_delivered":
        return translator.translate("Delivered");
        break;
      case "processing":
        return translator.translate("Processing");
        break;
      case "pending":
        return translator.translate("Pending");
        break;
      case "canceled":
        return translator.translate("Canceled");
        break;
      case "payfort_fort_new":
        return translator.translate("New");
        break;
      case "ready_to_dispatched":
        return translator.translate("Dispatched");
        break;
      case "closed":
        return translator.translate("closed");
        break;
    }

  }

}