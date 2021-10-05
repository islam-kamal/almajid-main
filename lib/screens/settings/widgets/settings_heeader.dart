import 'package:almajidoud/utils/file_export.dart';
settingsHeader({BuildContext context}){
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
            isLandscape(context) ?2*height(context)*.035: height(context)*.035),
            customDescriptionText(context: context , text: "Settings" , textColor: whiteColor,percentageOfHeight: .025),
//
            Image.asset("assets/icons/notifi.png" , height:
            isLandscape(context) ?2*height(context)*.04: height(context)*.04,),
          ],
        ),
      ],
    ),)  ;
}