import 'package:almajidoud/utils/file_export.dart';
import 'package:rating_bar/rating_bar.dart';

priceAndRatingRow({BuildContext context , var price ,var old_price=89 ,bool review_status}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Row(
              children: [
                Container(
                  child: customDescriptionText(
                      context: context,
                      text: "${double.parse(price)} ",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      textColor: mainColor,
                      percentageOfHeight: .03,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: customDescriptionText(
                      context: context,
                      text: "${MyApp.country_currency}",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      textColor: mainColor,
                      percentageOfHeight: .02,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            SizedBox(width: width(context) * 0.05,),
            Text(
              "${old_price} ${translator.translate("SAR")}",
              style: TextStyle(
                  decoration: TextDecoration.lineThrough,
                  fontSize: StaticData.get_height(context)  * .017,
                  color: greyColor),
            ),
          ],
        ),

        review_status ?  RatingBar.readOnly(
          initialRating: 5.0,
          maxRating: 5,
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          size: StaticData.get_width(context) * 0.03,
          filledColor: Colors.yellow.shade700,
        ) : Container(),
      ],
    ),
  );
}
