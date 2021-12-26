import 'dart:convert';

import 'package:flutter/material.dart';
import 'Constants.dart';
import 'tamara_payment_screen.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Paytm',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _amountController = TextEditingController();

  Future<http.Response> getPayFortSettings() async {
    final url =
        '${ORDER_DATA['website_domain']}/rest/V1/mstore/update-order-type';
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
        title: Text("Tap Payments"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TamaraPaymentScreen()));
              },
              color: Colors.blue,
              child: Text(
                "Proceed to Checkout",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
