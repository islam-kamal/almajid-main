import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:pay/pay.dart';

class ApplePayScreen extends StatefulWidget {
  final String order_increment_id;
  var grand_total;
  ApplePayScreen({Key key,this.order_increment_id,this.grand_total}) : super(key: key);

  @override
  _ApplePayScreenState createState() => _ApplePayScreenState();
}

class _ApplePayScreenState extends State<ApplePayScreen> {
  void onGooglePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    customAnimatedPushNavigation(context, StaticData.vistor_value == 'visitor'? CustomCircleNavigationBar(): OrdersScreen(
     increment_id: widget.order_increment_id,
    ));
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
    customAnimatedPushNavigation(context, StaticData.vistor_value == 'visitor'? CustomCircleNavigationBar(): OrdersScreen(
      increment_id: widget.order_increment_id,
    ));
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
          GooglePayButton(
            paymentConfigurationAsset:
            'apple_pay/default_payment_profile_google_pay.json',
            paymentItems: _paymentItems,
            style: GooglePayButtonStyle.black,
            type: GooglePayButtonType.pay,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: onGooglePayResult,
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
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


const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '1.0',
    status: PaymentItemStatus.final_price,
  )
];
