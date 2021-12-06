import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/utils/file_export.dart';
paymentMethodCard({BuildContext context ,  List<PaymentMethods> paymentMethods}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    width: width(context) * .9,
    decoration:
        BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: [
        responsiveSizedBox(context: context, percentageOfHeight: .005),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                singleSmallCard(context: context , title: "Cash" , image: "assets/icons/cash icon.png"),
                singleRadioButton(context: context)
              ],
            ),
            Row(
              children: [
                singleSmallCard(context: context , title: "Credit Card" , image:  "assets/icons/credit cards.png"),
                singleRadioButton(context: context , )
              ],
            )
          ],
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .005),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                singleSmallCard(context: context , title: "Pay" , image: "assets/icons/apple pay.png" ),
                singleRadioButton(context: context)
              ],
            ),
           SizedBox()
          ],
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .005),
      ],
    ),
  );
}

singleSmallCard({BuildContext context, String image :"", String title}) {
  return Container(
    height: isLandscape(context)
        ? 2 * height(context) * .05
        : height(context) * .05,
    width: width(context) * .25,
    decoration: BoxDecoration(
        color: whiteColor, borderRadius: BorderRadius.circular(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
        image,
          height: 23,
        ),
        SizedBox(width: width(context) * .01),
        customDescriptionText(context: context, text: title , percentageOfHeight: .015)
      ],
    ),
  );
}

singleRadioButton({BuildContext context, bool radioValue: false}) {
  return  Radio(value:radioValue , onChanged: (v){} , activeColor: Colors.blue) ;
}
