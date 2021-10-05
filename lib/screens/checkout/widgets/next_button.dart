import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/checkout/checkout_payment_screen.dart';
import 'package:almajidoud/screens/checkout/checkout_summary_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

nextButton({BuildContext context, bool isAddress: true}) {
  return GestureDetector(
    onTap: () {
      customAnimatedPushNavigation(context , CheckoutPaymentScreen());
    },
    child: Container(
        width: width(context) * .8,
        decoration: BoxDecoration(
            color: mainColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: customDescriptionText(
                context: context,
                text: "Next",
                percentageOfHeight: .025,
                textColor: whiteColor)),
        height: isLandscape(context)
            ? 2 * height(context) * .065
            : height(context) * .065),
  );
}
