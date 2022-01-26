import 'package:almajidoud/Repository/ShippmentAdressRepo/shipment_address_repository.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

proceedToCheckoutButton({BuildContext context}) {
  return GestureDetector(
    onTap: ()async{
      print("  EEE  StaticData.vistor_value  : ${    StaticData.vistor_value }");
      StaticData.vistor_value == 'visitor' ? null :  await shipmentAddressRepository.get_all_saved_addresses(context: context);

  customAnimatedPushNavigation(context, CheckoutAddressScreen());

  },
    child: Container(
        width: width(context) * .8,
        decoration: BoxDecoration(
            color: greenColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: customDescriptionText(
                context: context,
                text: translator.translate("Proceed to checkout"),percentageOfHeight: .025,
                textColor: whiteColor)),
        height: isLandscape(context)
            ? 2 * height(context) * .065
            : height(context) * .065),
  );
}
