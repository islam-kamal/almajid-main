import 'package:almajidoud/utils/file_export.dart';

passwordTopHeader({BuildContext context, bool isResetScreen: false}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: width(context) * .05),
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
        isResetScreen == true
            ? customDescriptionText(
                context: context,
                textColor: mainColor,
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
              color: mainColor,
            )),
      ],
    ),
  );
}
