import 'package:almajidoud/utils/file_export.dart';

chooseCountryWidgetInResetPassword({BuildContext context}) {
  return Neumorphic(
    child: Container(
      padding: EdgeInsets.only(
          right: width(context) * .02, left: width(context) * .02),
      color: whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            "assets/icons/flag.png",
            height: isLandscape(context)
                ? 2 * height(context) * .04
                : height(context) * .04,
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
      width: width(context) * .8,
      height: isLandscape(context)
          ? 2 * height(context) * .07
          : height(context) * .07,
    ),
  );
}
