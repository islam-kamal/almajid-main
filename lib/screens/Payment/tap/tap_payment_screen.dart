import 'dart:convert';

import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Constants.dart';
import 'dart:io' show Platform;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TapPaymentScreen extends StatefulWidget {
  var public_key , order_incremental_id;
  var order_id;
  TapPaymentScreen({this.public_key,this.order_incremental_id,this.order_id});
  @override
  _TapPaymentScreenState createState() => _TapPaymentScreenState();
}

class _TapPaymentScreenState extends State<TapPaymentScreen> {
  WebViewController _webController;
  bool _loadingPayment = true;
  String _responseStatus = STATUS_LOADING;

  String _loadHTML()  {
    return "<html> <body onload='document.f.submit();'> "
        "<form id='f' name='f' method='get' action='${"https://test.almajed4oud.com/en-kw/tap/Standard/Redirect"}'>"
            "<input type='hidden' name='order_id' value='${widget.order_incremental_id}' />" +
        "<input type='hidden' name='token' value='${widget.public_key}' />" +
        "</form>  <head> <meta name='viewport' content='width=device-width, initial-scale=1'> <style>.loader {"
            "border: 25px solid #f3f3f3;border-radius: 50%;"
            "border-top: 16px solid blue;border-right: 16px solid green;border-bottom: 16px solid red;"
            "height: 120px; -webkit-animation: spin 2s linear infinite;"
            "animation: spin 2s linear infinite;}@-webkit-keyframes spin {0% { -webkit-transform: rotate(0deg); }100% { -webkit-transform: rotate(360deg); }}"
            "@keyframes spin {0% { transform: rotate(0deg); }100% { transform: rotate(360deg); }}"
            "</style></head></body> </html>";
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
          order_id: widget.order_id,
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
      order_id: widget.order_id,
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
                if (page.contains("/checkout/cart")) {
                  print('am in cart page');
                  _responseStatus = STATUS_CHECKSUM_FAILED;
                  this.setState(() {
                    _loadingPayment = false;
                  });
                }
                if (page.contains("authenticat") ||
                    page.contains("secure") ||
                    page.contains("3d") ||
                    page.contains("Cancel")) {
                  setState(() {
                    _loadingPayment = false;
                  });
                }
                if (page.contains("/FlutterResponse")) {
                  setState(() {
                    _loadingPayment = true;
                  });
                  var data = await _webController
                      .evaluateJavascript("document.body.innerText");
                  final decodedJSON = jsonDecode(data);
                  print("result: " + decodedJSON.toString());

             //     print("decodedJSON[status] : ${decodedJSON["status"].runtimeType  } :  ${decodedJSON["status"]}");


                  var responseCode = decodedJSON.toString().substring(10,14) ;
                  print('response code:  ${responseCode}  ,, ${responseCode.runtimeType}');
                  print("status--- : ${responseCode == "true"}");
                  StaticData.order_payment_refused_reason =  decodedJSON.toString().substring(24);
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

class PaymentResult {
  bool status;
  String reason;

  PaymentResult({this.status, this.reason});

  PaymentResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    reason = json['reason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['reason'] = this.reason;
    return data;
  }
}



