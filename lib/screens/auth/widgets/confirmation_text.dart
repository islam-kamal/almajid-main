import 'package:almajidoud/utils/file_export.dart';

confirmationText({BuildContext context}) {
  return Container(
      width: width(context) * .9,
      child: customDescriptionText(
          context: context,
          text: "Confirmation",
          textColor: mainColor,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.start,
          percentageOfHeight: .03));
}
