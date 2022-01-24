import 'dart:convert';

import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TamaraPaymentScreen extends StatefulWidget {
  var redirect_url;
  var increment_id;
  TamaraPaymentScreen({this.redirect_url,this.increment_id});
  @override
  _TamaraPaymentScreenState createState() => _TamaraPaymentScreenState();
}

class _TamaraPaymentScreenState extends State<TamaraPaymentScreen> {
  WebViewController _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  String _loadHTML() {
    return "<html> <body onload='document.f.submit();'> <form id='f' name='f' method='get' action='${widget.redirect_url}'>"
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
        return SubmitSuccessfulScreen(
          order_id: widget.increment_id,
        );
      case STATUS_CHECKSUM_FAILED:
        return SubmitFaieldScreen();
      case STATUS_FAILED:
        return SubmitFaieldScreen(
          faield_type: 'PaymentFailed',
          reason: StaticData.order_payment_refused_reason,
        );
    }
    return SubmitSuccessfulScreen(
      order_id: widget.increment_id,
    );
  }

  @override
  void dispose() {
    _webController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                _loadingPayment = false;
                if (page.contains("/checkout/cart")) {
                  print('am in cart page');
                  _responseStatus = STATUS_CHECKSUM_FAILED;
                  this.setState(() {
                    _loadingPayment = false;
                  });
                }
                if (page.contains("tamara")) {
                  setState(() {
                    _loadingPayment = false;
                  });
                }
                if (page.contains("/success")) {
                  setState(() {
                    _loadingPayment = true;
                  });
                  var data = await _webController
                      .evaluateJavascript("document.body.innerText");
                  var decodedJSON = jsonDecode(data);
                  print("result: " + decodedJSON.toString());
                  var responseCode = decodedJSON.toString().substring(10,14) ;
                  print('response code:  ${responseCode}  ,, ${responseCode.runtimeType}');
                  print("status--- : ${responseCode == "true"}");
                  StaticData.order_payment_refused_reason =  decodedJSON.toString().substring(24);
                  print('response code: ' + responseCode.toString());
                  _loadingPayment = false;
                  if (responseCode == "true") {
                    _responseStatus = STATUS_SUCCESSFUL;
                  } else {
                    _responseStatus = STATUS_FAILED;
                  }
                  setState(() {
                    _loadingPayment = false;
                  });
                }
              },
            ),
          ),
          (_loadingPayment)
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.blueGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'please wait while we are processing your order 😉',
                        style: TextStyle(fontSize: 22, color: Colors.black54),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Container(
                        height: 100,
                        child: Center(
                          child: SpinKitFadingCube(
                            color: Theme.of(context).primaryColor,
                            size: 30.0,
                          ),
                        ),
                      )
                    ],
                  ),
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



