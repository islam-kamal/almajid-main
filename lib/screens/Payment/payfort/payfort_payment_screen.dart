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
        "</form> <head> <meta name='viewport' content='width=device-width, initial-scale=1'> <style>.loader {"
            "border: 25px solid #f3f3f3;border-radius: 50%;"
            "border-top: 16px solid blue;border-right: 16px solid green;border-bottom: 16px solid red;"
            "height: 120px; -webkit-animation: spin 2s linear infinite;"
            "animation: spin 2s linear infinite;}@-webkit-keyframes spin {0% { -webkit-transform: rotate(0deg); }100% { -webkit-transform: rotate(360deg); }}"
        "@keyframes spin {0% { transform: rotate(0deg); }100% { transform: rotate(360deg); }}"
            "</style></head> </body> </html>";
  }

  void getData() {
    _webController.evaluateJavascript("document.body.innerText").then((data) {
      var decodedJSON = jsonDecode(data);
      Map<String, dynamic> responseJSON = jsonDecode(decodedJSON);
      final responseCode = responseJSON["response_code"];
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
          order_id: widget.order_number,
        );
      case STATUS_CHECKSUM_FAILED:
        return SubmitFaieldScreen();
      case STATUS_FAILED:
        return SubmitFaieldScreen(
          faield_type: 'PaymentFailed',
        );
    }
    return SubmitSuccessfulScreen(
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
                  _responseStatus = STATUS_CHECKSUM_FAILED;
                  this.setState(() {
                    _loadingPayment = false;
                  });
                }
                if (page.contains("authenticat") || page.contains("secure") || page.contains("3d") || page.contains("Cancel")) {
                  setState(() {
                    _loadingPayment = false;
                  });
                }
                if (page.contains("return3DsTnxStatus")) {
                  setState(() {
                    _loadingPayment = true;
                  });
                }
                if (page.contains("/flutterresponseonline")) {
                  setState(() {
                    _loadingPayment = true;
                  });
                  var data = await _webController
                      .evaluateJavascript("document.body.innerText");
                  var decodedJSON = jsonDecode(data);

                  Map<String, dynamic> responseJSON = {};
                  if (Platform.isAndroid) {
                    responseJSON = jsonDecode(decodedJSON);
                  } else if (Platform.isIOS) {
                    responseJSON = decodedJSON;
                  }

                  final responseCode = responseJSON["response_code"];
                  if (responseCode.substring(2) == '000') {
                    final merchantReference =
                        responseJSON["merchant_reference"];
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
              ? Center(
                  child: CircularProgressIndicator(
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



