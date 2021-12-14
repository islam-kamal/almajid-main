import 'dart:convert';

import 'package:almajidoud/Repository/AuthenticationRepo/authentication_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'Constants.dart';
import 'PaymentScreen.dart';
import 'package:http/http.dart' as http;



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _amountController = TextEditingController();

  Future<http.Response> getPayFortSettings() async {
    final url = '${ORDER_DATA['website_domain']}/rest/V1/mstore/update-order-type';
    try {
      final Map<String, dynamic> data = {
       "orderId": ORDER_DATA['orderId'],
      "type": "mobile_android"
      };
      final serializedData = json.encode(data);
      final response = await http.post(Uri.parse(url),
          headers: {
            "content-type": "application/json",
            "Authorization": "Bearer tda5h42j6mke2q43da55wckmoeynz1n1"
          },
          body: serializedData);
      return response;
    } catch (error) {
      throw (error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paytm Payments"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Enter Amount", border: UnderlineInputBorder()),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: () {
              final Future<http.Response> response = getPayFortSettings();
              response.then((response) {
//                print(response.body);
                final extractedData =
                    json.decode(response.body) as Map<String, dynamic>;
                // if (extractedData["success"] && extractedData["payment_config"].length !=0) {
                if (extractedData["success"]) {
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

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                            amount: _amountController.text,
                            merchantIdentifier: merchantIdentifier,
                            accessCode: accessCode,
                            merchantReference: merchantReference,
                            language: language,
                            serviceCommand: serviceCommand,
                            returnUrl: returnUrl,
                            signature: signature,
                            url: url,
                          )));
                } else {
                  print('order not found');
                }
              });
            },
            color: Colors.blue,
            child: Text(
              "Proceed to Checkout",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
