
import 'package:almajidoud/utils/file_export.dart';

class ThanksForRatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(child:
    Center(child: Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .2),
        Image.asset("assets/icons/Group 10.png" , width: width(context)*.7,),
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        customDescriptionText(context: context , textColor: mainColor ,
            text: "Thanks For Your Review !" , percentageOfHeight: .035) ,
        responsiveSizedBox(context: context , percentageOfHeight: .02),

        responsiveSizedBox(context: context , percentageOfHeight: .05),
        Container(
            width: width(context) * .5,
            decoration: BoxDecoration(
                color: mainColor, borderRadius: BorderRadius.circular(8)),
            child: Center(
                child: customDescriptionText(
                    context: context,
                    text: "Tell Us More",
                    percentageOfHeight: .025,
                    textColor: whiteColor)),
            height: isLandscape(context)
                ? 2 * height(context) * .065
                : height(context) * .065),
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        Container(child: customDescriptionText(context: context , textColor: greyColor ,percentageOfHeight: .027,maxLines: 2,
            text: "No thanks") ,width: width(context)*.9),





      ],
    ),),),);
  }
}
