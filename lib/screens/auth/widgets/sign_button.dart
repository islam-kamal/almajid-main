import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

signButton({BuildContext context, bool isSignUp: true}) {
  return GestureDetector(
    onTap: () {
      customAnimatedPushNavigation(context, HomeScreen());
    },
    child: Container(
      width: width(context) * .7,
      height: isLandscape(context)
          ? 2 * height(context) * .07
          : height(context) * .07,
      child: Center(
        child: customDescriptionText(
            context: context,
            textColor: whiteColor,
            fontWeight: FontWeight.bold,
            text: isSignUp == true ? "Sign Up" : "Sign In",
            percentageOfHeight: .025),
      ),
      decoration: BoxDecoration(
          color: blackColor, borderRadius: BorderRadius.circular(10)),
    ),
  );
}
