import 'package:almajidoud/utils/file_export.dart';

orderSummaryWidget({BuildContext context}){
  return Column(children: [
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
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        customDescriptionText(
            context: context,
            text: "Subtotal",
            textAlign: TextAlign.start,

            percentageOfHeight: .022),
        customDescriptionText(
            context: context,
            text: " \$ 2000 ",
            textAlign: TextAlign.start,

            percentageOfHeight: .022),
      ],)

    ),
    Container(
        width: width(context) * .9,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(
                context: context,
                text: "VAT",
                textAlign: TextAlign.start,

                percentageOfHeight: .022),
            customDescriptionText(
                context: context,
                text: " \$ 1000 ",
                textAlign: TextAlign.start,

                percentageOfHeight: .022),
          ],)

    ),
    Divider(color: greyColor) ,
    Container(
        width: width(context) * .9,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(
                context: context,
                text: "Total to pay",
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,

                percentageOfHeight: .022),
            customDescriptionText(
                context: context,
                text: "\$ 2410",
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.start,

                percentageOfHeight: .022),
          ],)

    ),

  ],);
}