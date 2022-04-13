import 'package:almajidoud/utils/file_export.dart';

noNotificationsWidget({BuildContext? context}){
  return Container(
    color: whiteColor,
    child: Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .25),
        Image.asset("assets/icons/Group 10.png" , width: width(context)*.7,),
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        customDescriptionText(context: context , textColor: mainColor , text: "No Notifications Yet !" , percentageOfHeight: .03) ,
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        customDescriptionText(context: context , textColor: greyColor , text: "Tap the button below to referesh and check again") ,
        responsiveSizedBox(context: context , percentageOfHeight: .1),
        Container(
            width: width(context) * .8,
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: customDescriptionText(
                    context: context,
                    text: "Refresh",
                    percentageOfHeight: .025,
                    textColor: whiteColor)),
            height: isLandscape(context)
                ? 2 * height(context) * .065
                : height(context) * .065),





      ],
    ),
  );
}