import 'package:almajidoud/custom_widgets/custom_push_named_navigation.dart';
import 'package:almajidoud/screens/auth/sign_up_screen.dart';
import 'package:almajidoud/screens/auth/sing_in_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

alreadyHaveAnAccount({BuildContext context, bool isSignUp: true}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Padding(padding: EdgeInsets.only(left: 10,right: 10),
     child:  customDescriptionText(
       context: context,
       text: isSignUp == true
           ? "Already have an account?"
           : "Don't have an account ?",
     ),),
      GestureDetector(
        onTap: () {
          isSignUp == true
              ? customPushNamedNavigation(context, SignInScreen())
              : customPushNamedNavigation(context, SignUpScreen());
        },
        child: customDescriptionText(
            context: context,
            text: isSignUp == true ? "Sign In" : "Sign Up",
            fontWeight: FontWeight.bold),
      )
    ],
  );
}
