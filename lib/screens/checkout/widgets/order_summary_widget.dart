import 'package:almajidoud/utils/file_export.dart';

orderSummaryWidget({BuildContext context , var subtotal , var vat,var total}) {
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
      responsiveSizedBox(context: context, percentageOfHeight: .01),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "Subtotal",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .022),
              customDescriptionText(
                  context: context,
                  text: " ${translator.translate("SAR")} ${subtotal} ",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .022),
            ],
          )),
      Container(
          width: width(context) * .9,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customDescriptionText(
                  context: context,
                  text: "VAT",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .022),
              customDescriptionText(
                  context: context,
                  text: " ${translator.translate("SAR")} ${vat} ",
                  textAlign: TextAlign.start,
                  percentageOfHeight: .022),
            ],
          )),
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
                  percentageOfHeight: .022),
              customDescriptionText(
                  context: context,
                  text: "${translator.translate("SAR")} $total",
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.start,
                  percentageOfHeight: .022),
            ],
          )),
    ],
  );
}
