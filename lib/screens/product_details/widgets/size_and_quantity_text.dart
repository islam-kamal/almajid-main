import 'package:almajidoud/utils/file_export.dart';

titleText({BuildContext? context, String text: ""}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.only(
            right: width(context) * .05, left: width(context) * .05),
        child: customDescriptionText(
            context: context,
            textAlign: TextAlign.start,
            textColor: mainColor,
            text: text,
            percentageOfHeight: .022,
            fontWeight: FontWeight.bold),
      ),
    ],
  );
}
