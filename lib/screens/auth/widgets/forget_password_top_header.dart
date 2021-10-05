import 'package:almajidoud/utils/file_export.dart';

passwordTopHeader({BuildContext context, bool isResetScreen: false}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
      top: width(context) * .05,
      ),
    width: width(context),
    color: mainColor,
    height: isLandscape(context)
        ? 2 * height(context) * .09
        : height(context) * .09,
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
        isResetScreen == true
            ? customDescriptionText(
                context: context,
                textColor: whiteColor,
                text: "Reset passsword")
            : SizedBox(),
        GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Image.asset(
              "assets/icons/notifi.png",
              height: isLandscape(context)
                  ? 2 * height(context) * .03
                  : height(context) * .03,
            )),
      ],
    ),
  );
}
