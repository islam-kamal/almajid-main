import 'dart:io';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Provider/cart_provider.dart';
import 'package:almajidoud/utils/colors.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twemoji/twemoji.dart';

class PageContainer extends StatelessWidget {
  final Widget? child;
  final String? name;

   PageContainer({this.child, this.name});
    bool? _isLoading = false;

  @override
  Widget build(BuildContext context) {
    var cart_provider = Provider.of<CartProvider>(context,listen:true);
    print("cart_provider.cart_grand_total : ${cart_provider.cart_grand_total}");
    return Container(
        color: Platform.isIOS ? Colors.white : Colors.white,
        child: SafeArea(
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Directionality(
                textDirection: translator.activeLanguageCode == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Column(
                  children: [
                    Column(
                      children: [
                         Container(
                                color: Colors.grey.shade200,
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: free_shipping_ads(
                                    grand_total: cart_provider.cart_grand_total
                                )
                            ),
                        name == "HomeScreen"
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  "assets/images/charity1.png",
                                  height:
                                      MediaQuery.of(context).size.width * 0.04,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.center,
                                ))
                            : Container(),
                      ],
                    ),
                    Expanded(
                      child: child!,
                    )
                  ],
                ),
              )),
        ));
  }

  Widget? free_shipping_ads({var grand_total}) {
    double? country_shipping;
    switch (MyApp.app_location) {
      case 'sa':
        country_shipping = 199;
        break;
      case 'kw':
        country_shipping = 15;
        break;
      case 'uae':
        country_shipping = 199;
        break;
      case 'bh':
        country_shipping = 20;
        break;
    }

    if (grand_total == 0) {
      return TwemojiText(
        text:
            "  شحن مجانى على الطلب فوق ${country_shipping!} ${MyApp.country_currency}  🙂",
        style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
      );
    } else if (grand_total < country_shipping) {
      return TwemojiText(
        text:
            "باقى لك ${(country_shipping! - grand_total).toStringAsFixed(2)} ${MyApp.country_currency} لتتمتع بشحن مجانى 😎 ",
        style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
      );
    } else if (grand_total > country_shipping) {
      return TwemojiText(
        text: 'شحن مجانى! 🎉🎉 ',
        style: TextStyle(fontWeight: FontWeight.bold, color: mainColor),
      );
    }
  }
}
