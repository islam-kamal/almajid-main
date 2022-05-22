import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

priceAndRatingRow({BuildContext? context , var new_price ,var old_price, var minimal_price ,bool? review_status}) {
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
                             old_price.toString()  :
                              double.parse(minimal_price).toStringAsFixed(2)
                                  : double.parse(new_price)} ",
                          size: StaticData.get_height(context!) * .024,
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
                new_price == null?  Container()   : Text(
                  "${old_price} ${MyApp.country_currency}",
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: StaticData.get_height(context)  * .014,
                      color: old_price_color),
                ),
              ],
            ),



        RatingBar.builder(
          initialRating: review_status! ?  5.0 : 0.0,
          minRating: 5,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemSize: 15.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating){

          },
        ),
      ],
    ),
  );
}
