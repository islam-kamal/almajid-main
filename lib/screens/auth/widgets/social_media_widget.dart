import 'package:almajidoud/utils/file_export.dart';

socialMediaWidget({BuildContext context}){
  return Column(children: [
    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      customDescriptionText(context: context , text: "Or" ,textColor: greyColor) ,

    ],) ,
    responsiveSizedBox(context: context , percentageOfHeight: .01) ,

    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      customDescriptionText(context: context , text: "Sign up with" ,textColor: greyColor) ,

    ],)
    ,
    responsiveSizedBox(context: context , percentageOfHeight: .02) ,
    Row(mainAxisAlignment: MainAxisAlignment.center,children: [
      Container(
          width: width(context)*.15,height: isLandscape(context)
          ?2*height(context)*.05:height(context)*.05 ,
          child: Image.asset("assets/icons/facebook.png")),
      SizedBox(width: width(context)*.01,)
      ,      Container(
          width: width(context)*.15,height: isLandscape(context)
          ?2*height(context)*.05:height(context)*.05,
          child: Image.asset("assets/icons/twitter.png"))


    ],)
  ],);
}