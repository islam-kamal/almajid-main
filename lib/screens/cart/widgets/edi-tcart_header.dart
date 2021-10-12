import 'package:almajidoud/utils/file_export.dart';

editCartHeader({BuildContext context}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
        bottom: isLandscape(context)
            ? 2 * height(context) * .01
            : height(context) * .01),
    width: width(context),
    color: mainColor,
    height:
        isLandscape(context) ? 2 * height(context) * .08 : height(context) * .08,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.navigate_before,
                color: whiteColor,
                size: 30,
              ),
            ),
            customDescriptionText(
                context: context,
                text: "Edit Cart",
                textColor: whiteColor,
                fontWeight: FontWeight.normal,
                percentageOfHeight: .025),

            Row(
              children: [
                Image.asset(
                  "assets/icons/heart.png",
                  height: isLandscape(context)
                      ? 2 * height(context) * .05
                      : height(context) * .05,
                ),
                SizedBox(
                  width: width(context) * .02,
                ),
                Image.asset(
                  "assets/icons/delete.png",
                  height: isLandscape(context)
                      ? 2 * height(context) * .04
                      : height(context) * .04,
                ),
              ],
            )
          ],
        ),
      ],
    ),
  );
}
