import 'package:almajidoud/screens/Reviews/add_review_screen.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/product_reviews_screen.dart';
class ThanksForRatingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              responsiveSizedBox(context: context, percentageOfHeight: .2),
              Image.asset(
                "assets/icons/Group 10.png",
                width: width(context) * .7,
              ),
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              customDescriptionText(
                  context: context,
                  textColor: mainColor,
                  text: translator.translate("Thanks For Your Review !"),
                  percentageOfHeight: .035),
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              responsiveSizedBox(context: context, percentageOfHeight: .05),
             InkWell(
               onTap: (){
                 customAnimatedPushNavigation(context, AddReviewScreen());
               },
               child:  Container(
                   width: width(context) * .5,
                   decoration: BoxDecoration(
                       color: mainColor, borderRadius: BorderRadius.circular(8)),
                   child: Center(
                       child: customDescriptionText(
                           context: context,
                           text: translator.translate("Tell Us More"),
                           percentageOfHeight: .025,
                           textColor: whiteColor)),
                   height: isLandscape(context)
                       ? 2 * height(context) * .065
                       : height(context) * .065),
             ),
              responsiveSizedBox(context: context, percentageOfHeight: .02),
          InkWell(
            onTap: (){
              customAnimatedPushNavigation(context, CustomCircleNavigationBar());
            },
            child: Container(
                  child: customDescriptionText(
                      context: context,
                      textColor: greyColor,
                      percentageOfHeight: .027,
                      maxLines: 2,
                      text: translator.translate("No thanks")),
                  width: width(context) * .9
            )),
            ],
          ),
        ),
      ),
    );
  }
}
