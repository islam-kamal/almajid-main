import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/add_review_screen.dart';
reviewsHeader({BuildContext? context, String? title , var product_id}) {
  return Directionality(
      textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr ,
      child: Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
        top: isLandscape(context)
            ? 2 * height(context) * .002
            : height(context) * .002),
    width: width(context),
    color: whiteColor,
    height: isLandscape(context)
        ? 2 * height(context) * .12
        : height(context) * .08,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            customAnimatedPushNavigation(context!,ProductDetailsScreen(
                product_id :product_id
            ));
          },
          child: Icon(
            Icons.navigate_before,
            color: mainColor,
            size: 30,
          ),
        ),
        customDescriptionText(
            context: context,
            textColor: mainColor,
            text: "Reviews",
            percentageOfHeight: .025),
        GestureDetector(
            onTap: () {
              customPushNamedNavigation(context, AddReviewScreen(
                product_id: product_id,
              ));
            },
            child:  Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  border: Border.all(color: mainColor, width: 2),
                  shape: BoxShape.circle),
              child: Center(child: Icon(Icons.add, color: mainColor)),
            ) )
      ],
    ),
  ));
}
