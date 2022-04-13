import 'package:almajidoud/utils/file_export.dart';

paymentTitle({BuildContext? context, String title: ""}) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.only(
            right: width(context) * .05, left: width(context) * .05),
        child: customDescriptionText(
            context: context,
            textColor: mainColor,
            textAlign: TextAlign.start,
            text: title,
            percentageOfHeight: .02),
      ),
    ],
  );
}
