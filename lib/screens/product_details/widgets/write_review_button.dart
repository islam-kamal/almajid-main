import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/product_reviews_screen.dart';
writeReviewButton({BuildContext context , var product_suk , var product_id}) {
  return GestureDetector(
    onTap: (){
      customPushNamedNavigation(context,ProductReviewsScreen(
        product_id: product_id,
        product_suk: product_suk,
      ));

    },
    child: Container(
        width: width(context) * .95,
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.only(right: width(context)* 0.05 , left: width(context) * 0.05),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.rate_review_outlined, color: mainColor),
            SizedBox(width: 10),
            customDescriptionText(
                context: context,
                text: "Write A Review",
                percentageOfHeight: .025,
                textColor: mainColor),
          ],
        ),
        height: isLandscape(context)
            ? 2 * height(context) * .065
            : height(context) * .065),
  );
}
