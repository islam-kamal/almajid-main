import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/custom_widgets/custom_push_named_navigation.dart';
import 'package:almajidoud/screens/auth/sign_up_screen.dart';
import 'package:almajidoud/screens/auth/sing_in_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

topAuthButtons({BuildContext? context, bool? isSignUp: true}) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          customPushNamedNavigation(context, SignUpScreen());
        },
        child: Container(
          width: width(context) * .5,
          height: isLandscape(context) ? 2 * height(context) * .06
              : height(context) * .06,
          color: isSignUp == true ? mainColor : whiteColor,
          child: Center(
            child: customDescriptionText(
                context: context,
                text: "Sign Up",
                textColor: isSignUp == true ? whiteColor : greyColor,
                percentageOfHeight: .025,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          customPushNamedNavigation(context, SignInScreen());
        },
        child: Container(
          width: width(context) * .5,
          height: isLandscape(context)
              ? 2 * height(context) * .06
              : height(context) * .06,
          color: isSignUp == true ? whiteColor : mainColor,
          child: Center(
            child: customDescriptionText(
                context: context,
                text: "Sign In",
                textColor: isSignUp == true ? greyColor : whiteColor,
                percentageOfHeight: .025,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      responsiveSizedBox(context: context, percentageOfHeight: .002),
    ],
  );
}
