import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/auth/forget_password_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

forgetPasswordButton({BuildContext context }){
  return  Container(width: width(context)*.9,
    child: Row(mainAxisAlignment: MainAxisAlignment.end,
      children: [

GestureDetector(child:
customDescriptionText(context: context ,decoration: TextDecoration.underline, textColor: Colors.red, text: "Forget Password ?" , percentageOfHeight: .02 )
  ,onTap: (){
  customAnimatedPushNavigation(context, ForgetPasswordScreen());
  },)    ],),
  );

}