import 'package:almajidoud/utils/file_export.dart';

favouriteAndNameRow({BuildContext context, String product_name}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          width: width(context) * .7,
          child: customDescriptionText(
              context: context,
              text: product_name??"",
              textColor: mainColor,
              percentageOfHeight: .025),
        ),
        Icon(Icons.favorite_border)
      ],
    ),
  );
}
