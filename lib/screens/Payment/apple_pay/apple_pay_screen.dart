import 'dart:convert';

import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:pay/pay.dart';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;

class ApplePayScreen extends StatefulWidget {
  final String order_increment_id;
  var grand_total;
  ApplePayScreen({Key key,this.order_increment_id,this.grand_total}) : super(key: key);

  @override
  _ApplePayScreenState createState() => _ApplePayScreenState();
}

class _ApplePayScreenState extends State<ApplePayScreen> {

  var _paymentItems;
  @override
  void initState() {
     _paymentItems = [
      PaymentItem(
        label: 'Total',
        amount: widget.grand_total.toString(),
        status: PaymentItemStatus.final_price,
      )
    ];
     super.initState();
  }
  void onApplePayResult(paymentResult) {
    final token = json.decode(paymentResult["token"]);

    final Future<http.Response> response = payment_repository.getPayfortApplePayValidation(
      apple_data: token["data"],
      apple_signature: token["signature"],
      apple_publicKeyHash: token["header"]["publicKeyHash"],
      apple_transactionId:token["header"]["transactionId"],
      apple_ephemeralPublicKey: token["header"]["ephemeralPublicKey"],
      apple_displayName: "Almajed",
      apple_network: paymentResult["paymentMethod"]["network"],
      apple_version: token["version"],
      order_id: widget.order_increment_id,
    );

    response.then((res) {
      final extractedData = json.decode(res.body) as Map<String, dynamic>;
      if (extractedData["status"]) {
       /* customAnimatedPushNavigation(context, StaticData.vistor_value == 'visitor'? CustomCircleNavigationBar(): OrdersScreen(
          increment_id: widget.order_increment_id,
        ));*/
        customAnimatedPushNavigation(context, SubmitSuccessfulScreen(
          order_id: widget.order_increment_id,
        ));
      }else{
        customAnimatedPushNavigation(context, SubmitFaieldScreen());
      }
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: const Image(
              image: AssetImage('assets/images/startup 2.png'),
              height: 350,
            ),
          ),
         SizedBox(height:30),
          ApplePayButton(
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
          const SizedBox(height: 15)
        ],
      ),
    );
  }


}



