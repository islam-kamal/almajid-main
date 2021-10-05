import 'package:almajidoud/utils/file_export.dart';

typeTheVerificationCodeText({BuildContext context , String number}) {
  return Container(
      width: width(context) * .9,
      child: customDescriptionText(
          context: context,
          text: "${translator.translate("Please type the verification code sent to")} (${number})",
          textColor: greyColor,
         maxLines: 3,
          textAlign: TextAlign.start,
          percentageOfHeight: .027));
}
