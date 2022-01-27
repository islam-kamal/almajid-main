import 'package:almajidoud/utils/file_export.dart';

weWillSendYouCode({BuildContext context}) {
  return Container(
    width: width(context) ,
    child: customDescriptionText(
        context: context,
        textColor: old_price_color,
        text: "We will send you a verification code to your phone number",
        maxLines: 6,

        percentageOfHeight: .020),
  );
}
