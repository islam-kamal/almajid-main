import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/scheduler.dart';

checkoutHeader({BuildContext? context, String? title}) {
  return  SingleChildScrollView(
      child:Container(

    width: width(context),
    color: whiteColor,
    child: Column(
      children: [
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context!).pop();

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
    ),
        Divider(color:mainColor,
          thickness: 1,
        ),
      ],
    ))


  );
}
