import 'package:almajidoud/screens/Reviews/product_reviews_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

vatAndReviewsRow({BuildContext context , var product_sku}) {
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
        InkWell(
          onTap: (){
            reviewsBloc.add(GetProductReviewsEvent(
                product_sku: product_sku
            ));
            customAnimatedPushNavigation(context, ProductReviewsScreen());
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
        )
      ],
    ),
  );
}
