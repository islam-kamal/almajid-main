import 'package:almajidoud/Model/OrderMode/order_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/cupertino.dart';

orderCentralCardStack({BuildContext context, OrderItems order_details}) {
  var payment_method = '';
  order_details.extensionAttributes.paymentAdditionalInfo.forEach((element) {
    if(element.key == "method_title"){
      payment_method  =element.value == "Split into 3 payments, without fees with Tamara" ? "Tamara" : element.value;
    }
  });
  return Container(
    padding: EdgeInsets.only(
        top: isLandscape(context)
            ? 2 * height(context) * .12
            : height(context) * .12),
    height: isLandscape(context) ? 2 * height(context) : height(context),
    child: Center(
      child: Container(
        padding: EdgeInsets.only(
            right: width(context) * .05, left: width(context) * .05),
        height: isLandscape(context)
            ? 2 * height(context) * .6
            : height(context) * .6,
        width: width(context) * .9,
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: mainColor,width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Row(
              children: [
                customDescriptionText(
                    context: context,
                    text: translator.translate( "Items" ),
                    percentageOfHeight: .026,
                    textColor: mainColor),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
           Container(
             height: width(context) * 0.45,
              child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: order_details.items.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                       Row(
                          children: [
                            Expanded(
                              flex:1,
                              child: Container(
                                height: isLandscape(context) ? 2 * height(context) * .08 : height(context) * .08,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage("${Urls.BASE_URL}/pub/media/catalog/product/${order_details.items[index].extensionAttributes['product_image']}"),
                                        fit: BoxFit.cover)),
                              ),),

                            Expanded(
                                flex:4,
                                child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child:   customDescriptionText(
                                            context: context,
                                            text: "${order_details.items[index].name}",
                                            maxLines: 3,
                                            textAlign: TextAlign.start,
                                            percentageOfHeight: .023),
                                      ),
                                      responsiveSizedBox(context: context, percentageOfHeight: .01),

                                      Row(
                                        children: [
                                          customDescriptionText(
                                              context: context,
                                              text: "${translator.translate("Quantity")} :   ${order_details.items[index].qtyOrdered} ",
                                              percentageOfHeight: .020),
                                          SizedBox(width: width(context) *0.04,),
                                          customDescriptionText(
                                              context: context,
                                              text:
                                              "${translator.translate("price")} : ${order_details.items[index].baseRowTotal} ${order_details.orderCurrencyCode}",
                                              percentageOfHeight: .020,
                                              fontWeight: FontWeight.normal),

                                        ],
                                      ),

                                    ],
                                  ),)

                            )
                          ],
                        ),
                 index ==order_details.items.length? Container():       Divider(color: white_gray_color,)
                      ],
                    );
                  },
                  ),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Container(
              width: width(context) * .8,
              child: Divider(
                thickness: 2,
              ),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Row(
              children: [
                customDescriptionText(
                    context: context,
                    text: "${translator.translate("Delivered Address" )}",
                    percentageOfHeight: .02,
                    textColor: mainColor),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .005),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: mainColor,
                ),
                SizedBox(
                  width: 2,
                ),
                Container(
                  width: width(context) * 0.7,
                  child: customDescriptionText(
                      context: context,
                      text: "${order_details.billingAddress.street[0]??''} , ${order_details.billingAddress.city??''}",
                      maxLines: 3,
                      fontWeight: FontWeight.bold,
                      percentageOfHeight: .015,
                      textAlign: TextAlign.start,
                      textColor: mainColor),
                )
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .005),
            Row(
              children: [
               customDescriptionText(
                    context: context,
                    text: "${translator.translate("Payment method")}",
                    percentageOfHeight: .02,
                    textColor: mainColor),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .005),
            Row(
              children: [
                Image.asset(
                  "assets/icons/credit cards.png",
                  height: 20,
                ),
                SizedBox(
                  width: 2,
                ),
                customDescriptionText(
                    context: context,
                    text: "${payment_method}",
                    fontWeight: FontWeight.bold,
                    percentageOfHeight: .015,
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    textColor: mainColor),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Container(
              width: width(context) * .8,
              child: Divider(
                thickness: 2,
              ),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customDescriptionText(
                    context: context,
                    text: "${translator.translate("Subtotal")}",
                    percentageOfHeight: .02,
                    textColor: mainColor),
                customDescriptionText(
                    context: context,
                    text: "${order_details.subtotal} ${MyApp.country_currency}",
                    percentageOfHeight: .02,
                    textColor: mainColor,
                    fontWeight: FontWeight.normal),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customDescriptionText(
                    context: context,
                    text: "${translator.translate("Shippment fees")}",
                    percentageOfHeight: .02,
                    textColor: mainColor),
                customDescriptionText(
                    context: context,
                    text: "${order_details.baseShippingAmount} ${MyApp.country_currency}",
                    percentageOfHeight: .02,
                    textColor: mainColor,
                    fontWeight: FontWeight.normal),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customDescriptionText(
                    context: context,
                    text: "${translator.translate("Coupon discount")} ",
                    percentageOfHeight: .02,
                    textColor: mainColor),
                customDescriptionText(
                    context: context,
                    text: "${order_details.baseDiscountAmount} ${MyApp.country_currency}",
                    percentageOfHeight: .02,
                    textColor: mainColor,
                    fontWeight: FontWeight.normal),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .005),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customDescriptionText(
                    context: context,
                    text: "${translator.translate("VAT")} ",
                    percentageOfHeight: .02,
                    textColor: mainColor),
                customDescriptionText(
                    context: context,
                    text: "${order_details.baseTaxAmount} ${MyApp.country_currency}",
                    percentageOfHeight: .02,
                    textColor: mainColor,
                    fontWeight: FontWeight.normal),
              ],
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .009),

          ],
        ),

      ),
    ),
  );
}
