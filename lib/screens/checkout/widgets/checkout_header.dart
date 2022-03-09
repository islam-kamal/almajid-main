import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/scheduler.dart';

checkoutHeader({BuildContext context, String title}) {
  return Container(

    width: width(context),
    color: whiteColor,
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
            color: mainColor,
            size: 30,
          ),
        ),
        customDescriptionText(
            context: context,
            textColor: mainColor,
            text: title,
            percentageOfHeight: .025),
        SizedBox()
      ],
    ),
  );
}
