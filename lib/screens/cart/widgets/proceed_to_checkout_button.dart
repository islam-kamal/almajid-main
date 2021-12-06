import 'package:almajidoud/Repository/ShippmentAdressRepo/shipment_address_repository.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

proceedToCheckoutButton({BuildContext context}) {
  return GestureDetector(onTap: ()async{
  await   shipmentAddressRepository.get_all_saved_addresses(context: context);
      print("addresses length : ${StaticData.saved_addresses_count}");

  customAnimatedPushNavigation(context, CheckoutAddressScreen());

  },
    child: Container(
        width: width(context) * .8,
        decoration: BoxDecoration(
            color: mainColor, borderRadius: BorderRadius.circular(8)),
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
