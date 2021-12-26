import 'dart:convert';

import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class OrderSuccessfulDialog extends StatefulWidget {
  final String order_id;
  OrderSuccessfulDialog({this.order_id=''});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderSuccessfulDialogState();
  }
}

class OrderSuccessfulDialogState extends State<OrderSuccessfulDialog> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          height: height ,
          decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(height * .1)),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: width,
                    height: height / 2,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.4)),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: width * 0.05),
                          alignment: Alignment.center,
                          child: Image.asset(
                            "assets/images/popup_done.png",
                            color: greenColor,
                          ),
                          width: width * 0.30,
                          height: width * 0.30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: width * 0.02),
                          child: Container(
                            margin: EdgeInsets.all(width * 0.02),
                            child: Column(
                              children: [
                                Text(

                                  translator.translate("your order created successfully with this number"),
                                  style: TextStyle(
                                      color: mainColor,
                                      fontSize: AlmajedFont.primary_font_size),
                                  textAlign: TextAlign.center,
                                ),
                                Text(

                                  translator.translate("# ${widget.order_id}  "),
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AlmajedFont.primary_font_size),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(top: width * 0.01),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.all(width * 0.05),
                              child:   InkWell(
                                onTap: (){
                                  if( StaticData.vistor_value == 'visitor') {
                                    cartRepository.check_quote_status().then((value){
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
                                    });
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) {
                                          return CustomCircleNavigationBar(
                                          );
                                        },
                                        transitionsBuilder:
                                            (context, animation8, animation15, child) {
                                          return FadeTransition(
                                            opacity: animation8,
                                            child: child,
                                          );
                                        },
                                        transitionDuration: Duration(milliseconds: 100),
                                      ),
                                    );
                                  }
                                  else{
                                    Navigator.pushReplacement(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation1, animation2) {
                                          return OrdersScreen(
                                          );
                                        },
                                        transitionsBuilder:
                                            (context, animation8, animation15, child) {
                                          return FadeTransition(
                                            opacity: animation8,
                                            child: child,
                                          );
                                        },
                                        transitionDuration: Duration(milliseconds: 100),
                                      ),
                                    );
                                  }
                                  },
                                child:  Container(
                                    width: width * .3,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    child: customDescriptionText(
                                        context: context,
                                        text: translator.translate("Ok"),
                                        percentageOfHeight: .025,
                                        textColor: whiteColor),
                                    height: isLandscape(context)
                                        ? 2 * height * .050
                                        : height * .050),
                              ),

                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
