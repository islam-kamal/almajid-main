import 'package:almajidoud/utils/file_export.dart';

descriptionAndShareRow({BuildContext context}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: width(context) * .7,
          child: customDescriptionText(
              context: context,
              text:
                  "Lorim ipsum is simply dummy text Lorim ipsum is simply dummy text",
              textAlign: TextAlign.start,
              maxLines: 2,
              textColor: greyColor,
              percentageOfHeight: .023),
        ),
        Icon(Icons.share)
      ],
    ),
  );
}
