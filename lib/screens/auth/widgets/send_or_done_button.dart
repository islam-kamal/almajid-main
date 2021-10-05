import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/auth/reset_password_screen.dart';
import 'package:almajidoud/screens/auth/login_with_phone_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

sendAndDoneButton({BuildContext context, bool isResetScreen: false}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: isResetScreen
              ? () {}
              : () {
                  customAnimatedPushNavigation(
                      context, VerificationCodeScreen());
                },
          child: Container(
            height: isLandscape(context)
                ? 2 * height(context) * .06
                : height(context) * .06,
            width: width(context) * .3,
            decoration: BoxDecoration(
                color: blackColor, borderRadius: BorderRadius.circular(30)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customDescriptionText(
                      context: context,
                      text: isResetScreen ? "Done" : "Send",
                      textColor: whiteColor),
                  SizedBox(width: width(context) * .03),
                  Container(
                      padding: EdgeInsets.all(isLandscape(context)
                          ? 2 * height(context) * .005
                          : height(context) * .005),
                      height: isLandscape(context)
                          ? 2 * height(context) * .08
                          : height(context) * .08,
                      width: width(context) * .055,
                      decoration: BoxDecoration(
                          color: whiteColor, shape: BoxShape.circle),
                      child: Center(
                          child: isResetScreen == true
                              ? Icon(
                                  Icons.check,
                                  color: blackColor,
                                  size: isLandscape(context)
                                      ? 2 * height(context) * .02
                                      : height(context) * .02,
                                )
                              : Image.asset("assets/icons/send.png")))
                ],
              ),
            ),
          ),
        )
      ],
    ),
  );
}
