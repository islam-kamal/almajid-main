import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/reviews/reviews_screen.dart';
writeReviewButton({BuildContext context}) {
  return GestureDetector(
    onTap: (){
      customPushNamedNavigation(context,ReviewsScreen());

    },
    child: Container(
        width: width(context) * .9,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(8)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.rate_review_outlined, color: mainColor),
            SizedBox(width: 10),
            customDescriptionText(
                context: context,
                text: "Write ReviewModel ",
                percentageOfHeight: .025,
                textColor: mainColor),
          ],
        ),
        height: isLandscape(context)
            ? 2 * height(context) * .065
            : height(context) * .065),
  );
}
