import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/checkout/checkout_summary_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

nextButtonInPayment({BuildContext context, bool isAddress: true ,
  GuestShipmentAddressModel guestShipmentAddressModel , var pay_method}) {
  return GestureDetector(
    onTap: () {
      customAnimatedPushNavigation(context , CheckoutSummaryScreen(
        guestShipmentAddressModel: guestShipmentAddressModel,
        payment_method: pay_method,
      )
      );
    },
    child: Container(
        width: width(context) * .8,
        decoration: BoxDecoration(
            color: mainColor, borderRadius: BorderRadius.circular(8)
        ),
        child: Center(
            child: customDescriptionText(
                context: context,
                text: "Next",
                percentageOfHeight: .025,
                textColor: whiteColor
            )
        ),
        height: isLandscape(context)
            ? 2 * height(context) * .065
            : height(context) * .065),
  );
}
