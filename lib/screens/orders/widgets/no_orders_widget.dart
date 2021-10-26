import 'package:almajidoud/utils/file_export.dart';

noOrdersWidget({BuildContext context}){
  return Center(
    child: Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .1),
        Image.asset("assets/icons/Group 10.png" , width: width(context)*.7,),
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        customDescriptionText(context: context , textColor: mainColor ,
            text: "Emoty menu !" , percentageOfHeight: .03) ,
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        Container(child: customDescriptionText(context: context , textColor: greyColor ,percentageOfHeight: .027,maxLines: 2,
            text: "Looks like you havn\'t made your choice yet !") ,width: width(context)*.9),
        responsiveSizedBox(context: context , percentageOfHeight: .1),
        Container(
            width: width(context) * .8,
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: customDescriptionText(
                    context: context,
                    text: "Back to menu",
                    percentageOfHeight: .025,
                    textColor: whiteColor)),
            height: isLandscape(context)
                ? 2 * height(context) * .065
                : height(context) * .065),





      ],
    ),
  );
}