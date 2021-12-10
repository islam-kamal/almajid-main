import 'package:almajidoud/utils/file_export.dart';

Widget no_data_widget({BuildContext context , var message = "No Products Yet !", var token_status , var image_status = false}){
  return Container(
//    color: whiteColor,
    child: Column(
      children: [
       // responsiveSizedBox(context: context , percentageOfHeight: .1),
        image_status? Container():  Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width(context) * 0.1),
              color: backGroundColor
          ),
          child: Image.asset("assets/icons/perfume (1).png" ,
            width: width(context)*.7,
            height: width(context)*.6,
            color: mainColor,),
        ),
        responsiveSizedBox(context: context , percentageOfHeight: .04),
        token_status == 'token_expire'? customDescriptionText(context: context ,
            textColor: mainColor ,
            text: message ,
            maxLines: 2,
            percentageOfHeight: .025)
         : customDescriptionText(context: context , textColor: mainColor , text: message , percentageOfHeight: .03) ,
       // responsiveSizedBox(context: context , percentageOfHeight: .02),
        responsiveSizedBox(context: context , percentageOfHeight: .05),
        token_status == 'token_expire'?    InkWell(
          onTap: (){
            customAnimatedPushNavigation(context,SignInScreen());
          },
          child: Container(
              width: width(context) * .8,
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(8)),
              child: Center(
                  child: customDescriptionText(
                      context: context,
                      text: translator.translate("Back to SignIn" ),
                      percentageOfHeight: .025,
                      textColor: whiteColor)),
              height: isLandscape(context)
                  ? 2 * height(context) * .065
                  : height(context) * .065),
        ) : Container()






      ],
    ),
  );
}