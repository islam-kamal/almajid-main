import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/utils/file_export.dart';

orderSummaryWidget({BuildContext context ,   List<TotalSegments> total_segments ,var cash }) {
  var grand_total, subtotal, vat ,shipping, payment_fees;
  print("cash : $cash");
  total_segments.forEach((element) {
    if(element.code ==  "grand_total"){
      grand_total = element.value;
    }
    if(element.code ==  "subtotal" ){
      subtotal = element.value;
    }
    if(element.code ==   "tax"){
      vat = element.value;
    }
    if(element.code == "shipping"){
      shipping = element.value;
    }
    if(element.code ==  "payment_fee"){
      payment_fees = element.value;
    }
  });
  return Column(
    children: [
      Container(
        width: width(context) * .9,
        child: customDescriptionText(
            context: context,
            text: "Order Summary",
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            percentageOfHeight: .022),
      ),
      responsiveSizedBox(context: context, percentageOfHeight: .02),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "Subtotal",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
              customDescriptionText(
                  context: context,
                  text: " ${MyApp.country_currency} ${subtotal} ",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
            ],
          )),
      responsiveSizedBox(context: context, percentageOfHeight: .015),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "VAT",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
              customDescriptionText(
                  context: context,
                  text: " ${MyApp.country_currency} ${vat} ",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
            ],
          )),
      responsiveSizedBox(context: context, percentageOfHeight: .015),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "Shipping",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
              customDescriptionText(
                  context: context,
                  text: shipping== 0 ? translator.translate("Free") : " ${MyApp.country_currency} ${shipping} ",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
            ],
          )),
      responsiveSizedBox(context: context, percentageOfHeight: .015),
     cash == 'الدفع عند التوصيل' || cash == "Cash On Delivery" ? Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "Payment Fees",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
              customDescriptionText(
                  context: context,
                  text: payment_fees== 0 ? translator.translate("Free") : " ${MyApp.country_currency} ${payment_fees} ",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
            ],
          )) : Container()  ,
      Divider(color: greyColor),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "Total to pay",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
              customDescriptionText(
                  context: context,
                  text: "${MyApp.country_currency} $grand_total",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  percentageOfHeight: .020),
            ],
          )),
    ],
  );
}
