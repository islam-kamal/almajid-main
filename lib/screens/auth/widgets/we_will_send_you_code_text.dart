import 'package:almajidoud/utils/file_export.dart';

weWillSendYouCode({BuildContext context}) {
  return Container(
    width: width(context) * .75,
    child: customDescriptionText(
        context: context,
        textColor: greyColor,
        text: "We will send you a verification code to your phone number",
        maxLines: 6,

        percentageOfHeight: .025),
  );
}
