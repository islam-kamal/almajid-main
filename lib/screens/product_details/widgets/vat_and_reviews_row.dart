import 'package:almajidoud/screens/Reviews/product_reviews_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

vatAndReviewsRow({BuildContext context , var product_sku , var product_id, bool review_status}) {
  print("product_sku : ${product_sku}");
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: customDescriptionText(
              context: context,
              text: translator.translate("this price includes VAT"),
              textAlign: TextAlign.start,
              maxLines: 2,
              textColor: greyColor,
              percentageOfHeight: .015,
              fontWeight: FontWeight.bold),
        ),
        review_status?  InkWell(
          onTap: (){
            reviewsBloc.add(GetProductReviewsEvent(
                product_sku: product_sku,

            ));
            customAnimatedPushNavigation(context, ProductReviewsScreen(
                product_suk: product_sku,
              product_id: product_id,
            ));
          },
          child:    Container(
            child: customDescriptionText(
                context: context,
                text: "Reviews",
                textAlign: TextAlign.start,
                decoration: TextDecoration.underline,
                maxLines: 2,
                textColor: greyColor,
                percentageOfHeight: .015,
                fontWeight: FontWeight.bold),
          ),
        ) : Container()
      ],
    ),
  );
}
