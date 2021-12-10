import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';

noOrdersWidget({BuildContext context}){
  return Center(
    child: Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .1),
        Image.asset("assets/icons/Group 10.png" , width: width(context)*.7,),
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        customDescriptionText(context: context , textColor: mainColor ,
            text: translator.translate( "Empty menu !") , percentageOfHeight: .03) ,
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        Container(child: customDescriptionText(context: context , textColor: greyColor ,percentageOfHeight: .027,maxLines: 2,
            text: translator.translate("Looks like you have not made your orders yet !")) ,width: width(context)*.9),
        responsiveSizedBox(context: context , percentageOfHeight: .1),
     /*   InkWell(
          onTap: (){
            customAnimatedPushNavigation(context,CustomCircleNavigationBar());
          },
          child: Container(
              width: width(context) * .8,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: customDescriptionText(
                      context: context,
                      text: translator.translate("Back to Home" ),
                      percentageOfHeight: .025,
                      textColor: whiteColor)),
              height: isLandscape(context)
                  ? 2 * height(context) * .065
                  : height(context) * .065),
        )*/





      ],
    ),
  );
}