import 'package:almajidoud/utils/file_export.dart';

singleVerificationCodeButton(
    {BuildContext context, bool isFilled: false, int interredNumber: 5 }) {
  return Container(
    height: isLandscape(context)
        ? 2 * height(context) * .1
        : height(context) * .1,
    width: width(context) * .18,
    decoration: BoxDecoration(color: isFilled == false ? greyColor : mainColor , borderRadius: BorderRadius.circular(10)),
    child: Center(
      child: customDescriptionText(
          context: context, text: isFilled == true ?   interredNumber.toString() :'-',
          textColor: isFilled == true ? greyColor : mainColor , fontWeight: FontWeight.bold , percentageOfHeight: .05),
    ),
  );
}
