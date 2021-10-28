import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/add_review_screen.dart';
reviewsHeader({BuildContext context, String title}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
        top: isLandscape(context)
            ? 2 * height(context) * .002
            : height(context) * .002),
    width: width(context),
    color: mainColor,
    height: isLandscape(context)
        ? 2 * height(context) * .12
        : height(context) * .08,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.navigate_before,
            color: whiteColor,
            size: 30,
          ),
        ),
        customDescriptionText(
            context: context,
            textColor: whiteColor,
            text: "Reviews",
            percentageOfHeight: .025),
  GestureDetector(
  onTap: () {
    customPushNamedNavigation(context, AddReviewScreen());
  },
  child:  Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
              border: Border.all(color: whiteColor, width: 2),
              shape: BoxShape.circle),
          child: Center(child: Icon(Icons.add, color: whiteColor)),
  ) )
      ],
    ),
  );
}
