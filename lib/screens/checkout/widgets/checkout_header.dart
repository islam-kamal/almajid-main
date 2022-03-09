import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/scheduler.dart';

checkoutHeader({BuildContext context, String title}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
  ),
    width: width(context),
    color: mainColor,
    height: isLandscape(context)
        ? 2 * height(context) * .07
        : height(context) * .07,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
           Navigator.of(context).pop();

          },
          child: Icon(
            Icons.navigate_before,
            color: whiteColor,
            size: 30,
          ),
        ),
        customDescriptionText(
            context: context,
            textColor: whiteColor,
            text: title,
            percentageOfHeight: .025),
        SizedBox()
      ],
    ),
  );
}
