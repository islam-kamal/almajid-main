import 'package:almajidoud/screens/auth/sing_in_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

sendCodeTopHeader({BuildContext context}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
        top: isLandscape(context)
            ? 2 * height(context) * .01
            : height(context) * .01),
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
            customPushNamedNavigation(context,SignInScreen());
          },
          child: Icon(
            Icons.navigate_before,
            color: mainColor,
            size: 30,
          ),
        ),
        SizedBox()
      ],
    ),
  );
}
