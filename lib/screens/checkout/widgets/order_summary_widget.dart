import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/utils/file_export.dart';

orderSummaryWidget({BuildContext? context ,   List<TotalSegments>? total_segments ,var cash   }) {
  var grand_total, subtotal, vat ,shipping, payment_fees=0 , discount;
  if(cash == 'الدفع عند الإستلام' || cash == "Cash On Delivery"){
    if(MyApp.app_location == 'sa') payment_fees= 15;
    if(MyApp.app_location == 'kw') payment_fees= 1;
    if(MyApp.app_location == 'uae') payment_fees= 11;
  }

  total_segments!.forEach((element) {
    if(element.code ==  "grand_total"){
      grand_total = double.parse((element.value + payment_fees).toStringAsFixed(2));
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
    if(element.code == "discount"){
      discount = element.value;
    }
  });


  return ListView(
    shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 10),
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
                    text: " ${subtotal} ${MyApp.country_currency}   ",
                    textAlign: TextAlign.start,
                    percentageOfHeight: .020),
              ],
            )),
        responsiveSizedBox(context: context, percentageOfHeight: .015),
        discount == null ? Container() :   Container(
            width: width(context) * .9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customDescriptionText(
                    context: context,
                    text: "Discount",
                    textAlign: TextAlign.start,
                    percentageOfHeight: .020),
                customDescriptionText(
                    context: context,
                    text:  " ${discount} ${MyApp.country_currency}   ",
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
                    text: " ${vat} ${MyApp.country_currency}   ",
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
                    text: shipping== 0 ? translator.translate("Free") : " ${shipping} ${MyApp.country_currency}   ",
                    textAlign: TextAlign.start,
                    percentageOfHeight: .020),
              ],
            )),

        responsiveSizedBox(context: context, percentageOfHeight: .015),
        cash == 'الدفع عند الإستلام' || cash == "Cash On Delivery" ? Container(
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
                    text: payment_fees== 0 ? translator.translate("Free") : " ${payment_fees} ${MyApp.country_currency}   ",
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
                    text: " $grand_total ${MyApp.country_currency}  ",
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.start,
                    percentageOfHeight: .020),
              ],
            )),

      ],

  );
}
