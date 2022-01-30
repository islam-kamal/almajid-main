import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rating_bar/rating_bar.dart';

priceAndRatingRow({BuildContext context , var new_price ,var old_price, var minimal_price ,bool review_status}) {
  print("price@@@ :${new_price}");
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [

            Row(
              children: [
                Wrap(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        MyText(
                          text: "${
                              new_price == null ?
                              double.parse(old_price.toString()) <  double.parse(minimal_price) ?
                             old_price.toStringAsFixed(2)  :
                              double.parse(minimal_price).toStringAsFixed(2)
                                  : double.parse(new_price)} ",
                          size: StaticData.get_height(context) * .020,
                          color: blackColor,
                          maxLines: 2,
                          weight: FontWeight.bold,
                        ),
                        MyText(
                          text: " ${MyApp.country_currency}",
                          size: StaticData.get_height(context) * .011,
                          color: blackColor,
                          maxLines: 2,
                          weight: FontWeight.normal,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(width: width(context) * 0.03,),
                new_price == null ?  Container()   : Text(
                  "${old_price} ${MyApp.country_currency}",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: StaticData.get_height(context)  * .014,
                      color: old_price_color),
                ),
              ],
            ),


       RatingBar.readOnly(
          initialRating: 5.0,
          maxRating: 5,
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          size: StaticData.get_width(context) * 0.03,
          filledColor: review_status ? Colors.yellow.shade700 : greyColor,
        )
      ],
    ),
  );
}
