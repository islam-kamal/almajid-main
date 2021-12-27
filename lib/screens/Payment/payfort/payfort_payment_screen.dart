import 'dart:convert';

import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/order_sucessful_dialog.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Constants.dart';
import 'dart:io' show Platform;

class PayfortPaymentScreen extends StatefulWidget {
  final String amount;
  final String merchantIdentifier;
  final String accessCode;
  final String merchantReference;
  final String language;
  final String serviceCommand;
  final String returnUrl;
  final String signature;
  final String url;
  final String order_number;
  PayfortPaymentScreen(
      {this.amount,
      this.merchantIdentifier,
      this.accessCode,
      this.merchantReference,
      this.language,
      this.serviceCommand,
      this.returnUrl,
      this.signature,
      this.url,
      this.order_number});

  @override
  _PayfortPaymentScreenState createState() => _PayfortPaymentScreenState();
}

class _PayfortPaymentScreenState extends State<PayfortPaymentScreen> {
  WebViewController _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='post' action='${widget.url}'>"
            "<input type='hidden' name='card_number' value='${ StaticData.card_number}' />" +
        "<input type='hidden' name='card_holder_name' value='${ StaticData.card_holder_name}' />" +
        "<input type='hidden' name='card_security_code' value='${ StaticData.card_security_code}' />" +
        "<input type='hidden' name='expiry_date' value='${StaticData.expiry_date}' />" +
        "<input type='hidden' name='merchant_identifier' value='${widget.merchantIdentifier}' />" +
        "<input type='hidden' name='access_code' value='${widget.accessCode}' />" +
        "<input type='hidden' name='merchant_reference' value='${widget.merchantReference}' />" +
        "<input type='hidden' name='language' value='${widget.language}' />" +
        "<input type='hidden' name='service_command' value='${widget.serviceCommand}' />" +
        "<input type='hidden' name='return_url' value='${widget.returnUrl}' />" +
        "<input type='hidden' name='signature' value='${widget.signature}' />" +
        "</form> </body> </html>";
  }

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      print("result: " + decodedJSON);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      final responseCode = responseJSON["response_code"];
      print('response code' + responseCode);
      print('success code' + responseCode.substring(2));
      if (responseCode.substring(2) != '000') {
        _responseStatus = STATUS_FAILED;
      } else {
        _responseStatus = STATUS_SUCCESSFUL;
      }
      this.setState(() {});
    });
  }

  Widget getResponseScreen() {
    switch (_responseStatus) {
      case STATUS_SUCCESSFUL:
        return PaymentSuccessfulScreen(
          order_id: widget.order_number,
        );
      case STATUS_CHECKSUM_FAILED:
        return CheckSumFailedScreen();
      case STATUS_FAILED:
        return PaymentFailedScreen();
    }
    return PaymentSuccessfulScreen(
      order_id: widget.order_number,
    );
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("card name : ${StaticData.card_holder_name}");
    print("card number : ${StaticData.card_number}");
    print("card expire : ${StaticData.expiry_date}");
    print("card cvv : ${StaticData.card_security_code}");
    print("order_number  : ${widget.order_number}");
    print("amount  : ${widget.amount}");
    print('html: ' + _loadHTML());
    return SafeArea(
      child: Scaffold(
          body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: WebView(
              debuggingEnabled: false,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (controller) {
                _webController = controller;
                _webController.loadUrl(
                    new Uri.dataFromString(_loadHTML(), mimeType: 'text/html')
                        .toString());
              },
              onPageFinished: (page) async {
                print("pay 1");
              if (page.contains("/checkout/cart")) {
                  print("pay 2");
                  print('am in cart page');
                  _responseStatus = STATUS_CHECKSUM_FAILED;
                  this.setState(() {
                    _loadingPayment = false;
                  });
                  print("pay 3");
                }
                if (page.contains("authenticat") || page.contains("secure") || page.contains("3d") || page.contains("Cancel")) {
                  setState(() {
                    _loadingPayment = false;
                  });
                  print("pay 4");
                }
                if (page.contains("/flutterresponseonline")) {
                  print("pay 5");
                  setState(() {
                    _loadingPayment = true;
                  });
                  var data = await _webController
                      .evaluateJavascript("document.body.innerText");
                  print("pay 6");
                  var decodedJSON = jsonDecode(data);

                  print("result: " + decodedJSON.toString());
                  // Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
                  Map<String, dynamic> responseJSON = {};
                  print("pay 7");
                  if (Platform.isAndroid) {
                    print("pay 8");
                    responseJSON = jsonDecode(decodedJSON);
                    print("android responseJSON : ${responseJSON}");
                  } else if (Platform.isIOS) {
                    print("pay 9");
                    responseJSON = jsonDecode(decodedJSON);
                    print("ios responseJSON : ${responseJSON}");
                  }

                  final responseCode = responseJSON["response_code"];
                  print('response code' + responseCode.toString());
                  print('success code' + responseCode.substring(2).toString());
                  _loadingPayment = false;
                  if (responseCode.substring(2) == '000') {
                    print("pay 10");
                    final merchantReference =
                        responseJSON["merchant_reference"];
                    print("merchantReference: " + merchantReference);
                    _responseStatus = STATUS_SUCCESSFUL;
                    print("pay 11");
                  } else {
                    print("pay 12");
                    _responseStatus = STATUS_FAILED;
                  }
                  setState(() {
                    _loadingPayment = false;
                  });
                  // if (page.contains("/flutterresponseonline")) {
                  //   print('success page');
                  //   getData();
                  // }
                }
              },
            ),
          ),

          (_loadingPayment)
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Center(),
          (_responseStatus != STATUS_LOADING)
              ? Center(child: getResponseScreen())
              : Center()
        ],
      )),
    );
  }
}

class PaymentSuccessfulScreen extends StatelessWidget {
  var order_id;
  PaymentSuccessfulScreen({this.order_id});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Great!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Thank you making the payment!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if( StaticData.vistor_value == 'visitor') {

                      customPushNamedNavigation(context, CustomCircleNavigationBar());
                    }
                    else{
                      customPushNamedNavigation(context, OrdersScreen(
                        increment_id: order_id,
                      ));
                    }


                  })
            ],
          ),
        ),
      ),
    );
  }
}

class PaymentFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "OOPS!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Payment was not successful, Please try again Later!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    customPushNamedNavigation(context, CustomCircleNavigationBar());

                  })
            ],
          ),
        ),
      ),
    );
  }
}

class CheckSumFailedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Oh Snap!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                   /* cartRepository.check_quote_status().then((value){
                      final extractedData = json.decode(value.body) as Map<String, dynamic>;
                      if (extractedData["status"]) {
                        print("cart quote is active");
                      }else if(extractedData["message"] != null){
                        print("cart quote is  not found");
                        cartRepository.create_quote(context: context); // used to create new quote for guest
                      }
                      else{
                        print("cart quote is not active");
                        cartRepository.create_quote(context: context); // used to create new quote for guest
                      }
                    });*/
                    customPushNamedNavigation(context, CustomCircleNavigationBar());
                  })
            ],
          ),
        ),
      ),
    );
  }
}
