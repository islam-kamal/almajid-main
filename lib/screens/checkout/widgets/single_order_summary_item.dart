import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/screens/checkout/checkout_payment_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

singleOrderSummaryItem(
    {BuildContext context,
    String title: "",
    String details: "",
    Function onTapChange,
    String image: "",
    bool isAddress: false,
    bool rValue,
    GuestShipmentAddressModel guestShipmentAddressModel}) {
  return Column(
    children: [
      Container(
        width: width(context) * .9,
        child: customDescriptionText(
            context: context,
            text: title,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.bold,
            percentageOfHeight: .020),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 8,
                child: Row(
                  children: [
                    isAddress == false
                        ? Image.asset(
                            "assets/icons/credit cards.png",
                            height: 20,
                          )
                        : Icon(Icons.location_on, color: mainColor),
                    SizedBox(
                      width: width(context) * .02,
                    ),
                    Container(
                        width: width(context) * .55,
                        child: customDescriptionText(
                          context: context,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          text: details,
                          textColor: mainColor,
                        )),
                  ],
                ),
              ),
              Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      if (title == "Address") {
                        customAnimatedPushNavigation(
                            context, CheckoutAddressScreen());
                      } else {
                        customAnimatedPushNavigation(
                            context,
                            CheckoutPaymentScreen(
                              guestShipmentAddressModel:
                                  guestShipmentAddressModel,
                            ));
                      }
                    },
                    child: Container(
                        child: GestureDetector(
                      onTap: onTapChange,
                      child: customDescriptionText(
                          context: context,
                          text: "Change",
                          textAlign: TextAlign.start,
                          fontWeight: FontWeight.bold,
                          percentageOfHeight: .022),
                    )),
                  ))
            ],
          )),
    ],
  );
}
