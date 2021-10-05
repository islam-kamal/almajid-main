import 'package:almajidoud/utils/file_export.dart';
doneButton({BuildContext context, bool isAddress: true}) {
  return GestureDetector(
    onTap: () {
//      customAnimatedPushNavigation(context, isAddress == true
//          ? CheckoutPaymentScreen() : CheckoutSummaryScreen());
    },
    child: Container(
        width: width(context) * .8,
        decoration: BoxDecoration(
            color: mainColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: customDescriptionText(
                context: context,
                text: "Done",
                percentageOfHeight: .025,
                textColor: whiteColor)),
        height: isLandscape(context)
            ? 2 * height(context) * .065
            : height(context) * .065),
  );
}
