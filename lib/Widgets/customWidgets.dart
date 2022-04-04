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

      case "dispatched_01":
        return translator.translate("dispatched_01");
        break;
      case "in_transit":
        return translator.translate("in_transit");
        break;
      case "rejected":
        return translator.translate("rejected");
        break;
      case "rejected_by_ajeek":
        return translator.translate("rejected_by_ajeek");
        break;
      case "rejected_by_customer":
        return translator.translate("rejected_by_customer");
        break;
      case "not_delivered":
        return translator.translate("not_delivered");
        break;
      case "invoiced":
        return translator.translate("invoiced");
        break;
      case "fraud":
        return translator.translate("fraud");
        break;
      case "confirmed101":
        return translator.translate("confirmed101");
        break;
      case "returned_to_almajed":
        return translator.translate("returned_to_almajed");
        break;
      case "canceled_by_al_majed":
        return translator.translate("canceled_by_al_majed");
        break;
      case "pending_payment":
        return translator.translate("pending_payment");
        break;
      case "payment_review":
        return translator.translate("payment_review");
        break;

      case "holded":
        return translator.translate("holded");
        break;
      case "delivered":
        return translator.translate("order_delivered");
        break;
      case "complete":
        return translator.translate("complete");
        break;
      case "collected_by_customer":
        return translator.translate("collected_by_customer");
        break;
      case "return_01":
        return translator.translate("return_01");
        break;
      case "payfort_fort_failed":
        return translator.translate("payfort_fort_failed");
        break;
      case "pending_paypal":
        return translator.translate("pending_paypal");
        break;
      case "paypal_canceled_reversal":
        return translator.translate("paypal_canceled_reversal");
        break;
      case "paypal_reversed":
        return translator.translate("paypal_reversed");
        break;
      case "redbox_portable_failed":
        return translator.translate("redbox_portable_failed");
        break;
      case "redbox_portable_expired":
        return translator.translate("redbox_portable_expired");
        break;

    }

  }

  static Color order_status_color(String status){
    switch(status){
      case "order_delivered":
        return greenColor;
        break;
      case "processing":
        return Colors.yellow;
        break;
      case "pending":
        return Colors.yellow;
        break;
      case "canceled":
        return Colors.red;
        break;
      case "payfort_fort_new":
        return Colors.blue;
        break;
      case "ready_to_dispatched":
        return Colors.purple;
        break;
      case "closed":
        return Colors.black;
        break;

      case "dispatched_01":
        return Colors.purple;
        break;
      case "in_transit":
        return Colors.orangeAccent;
        break;
      case "rejected":
        return Colors.red;
        break;
      case "rejected_by_ajeek":
        return Colors.red;
        break;
      case "rejected_by_customer":
        return Colors.red;
        break;
      case "not_delivered":
        return Colors.yellow;
        break;
      case "invoiced":
        return Colors.lightGreenAccent;
        break;
      case "fraud":
        return Colors.redAccent;
        break;
      case "confirmed101":
        return Colors.greenAccent;
        break;
      case "returned_to_almajed":
        return Colors.lightGreenAccent;
        break;
      case "canceled_by_al_majed":
        return Colors.redAccent;
        break;
      case "pending_payment":
        return Colors.orange;
        break;
      case "payment_review":
        return Colors.orange;
        break;

      case "holded":
        return Colors.orange;
        break;
      case "delivered":
        return greenColor;
        break;
      case "complete":
        return Colors.greenAccent;
        break;
      case "collected_by_customer":
        return Colors.lightGreen;
        break;
      case "return_01":
        return Colors.indigo;
        break;
      case "payfort_fort_failed":
        return Colors.redAccent;
        break;
      case "pending_paypal":
        return Colors.orange;
        break;
      case "paypal_canceled_reversal":
        return Colors.redAccent;
        break;
      case "paypal_reversed":
        return Colors.orange;
        break;

      case "redbox_portable_failed":
        return Colors.redAccent;
        break;
      case "redbox_portable_expired":
        return Colors.redAccent;
        break;

    }

  }
}