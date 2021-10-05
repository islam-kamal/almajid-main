import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/auth/verification_code_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

sendButtonInResetPassword({BuildContext context}){
   return   GestureDetector(onTap: (){
     customAnimatedPushNavigation(context , VerificationCodeScreen());
   },
     child: Container(height:isLandscape(context)
         ? 2 * height(context) * .08
         : height(context) * .08, width: width(context)*.2,decoration: BoxDecoration(color: blackColor , shape: BoxShape.circle),
       child: Center(child: Image.asset("assets/icons/right-arrow.png" , height: isLandscape(context)
           ? 2 * height(context) * .04
           : height(context) * .04),),),
   ) ;
}