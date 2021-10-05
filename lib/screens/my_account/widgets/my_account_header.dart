import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/notifications/notifications_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
myAccountHeader({BuildContext context}){
  return   Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05 ,
      bottom: isLandscape(context)
          ?2*height(context)*.01
          :height(context)*.01),
    width: width(context),color: mainColor,height: isLandscape(context)
        ?2*height(context)*.12:height(context)*.12,child:
    Column(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/icons/category.png" , height:
            isLandscape(context) ?2*height(context)*.035: height(context)*.035,),
            customDescriptionText(context: context , text: "My Account" , textColor: whiteColor,percentageOfHeight: .025),
//
            GestureDetector(onTap: (){customAnimatedPushNavigation(context, NotificationsScreen());},
              child: Image.asset("assets/icons/notifi.png" , height:
              isLandscape(context) ?2*height(context)*.04: height(context)*.04,),
            ),
          ],
        ),
      ],
    ),)  ;
}