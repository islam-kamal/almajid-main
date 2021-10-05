import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/auth/get_started_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

confirmationButtonInVerificationCode({BuildContext context}){
  return
     GestureDetector(onTap: (){
       customAnimatedPushNavigation(context, GetStartedScreen());
     },
       child: Container(
        decoration: BoxDecoration(color: greyColor ,borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.only(right: width(context)*.0 , left: width(context)*.02),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customDescriptionText(context: context , text: "Confirm" , percentageOfHeight: .025 ),
            Container(decoration: BoxDecoration(color: whiteColor ,borderRadius:
            BorderRadius.circular(5), border: Border.all(color: mainColor , width: 2)) ,
              child: Center(child: Icon(Icons.check , size:isLandscape(context)
                  ? 2 * height(context) * .05
                  : height(context) * .05 ,),),
              height:isLandscape(context)
                ? 2 * height(context) * .07
                : height(context) * .07
                , width: width(context)*.16,),



          ],),
        width: width(context)*.5,height:isLandscape(context)
            ? 2 * height(context) * .07
            : height(context) * .07,
  ),
     ) ;
}