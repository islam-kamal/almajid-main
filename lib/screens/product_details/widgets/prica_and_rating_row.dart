import 'package:almajidoud/utils/file_export.dart';
import 'package:rating_bar/rating_bar.dart';

priceAndRatingRow({BuildContext context , var price}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: customDescriptionText(
              context: context,
              text: "$price \$",
              textAlign: TextAlign.start,
              maxLines: 2,
              textColor: mainColor,
              percentageOfHeight: .03,
              fontWeight: FontWeight.bold),
        ),
        RatingBar.readOnly(
          initialRating: 5.0,
          maxRating: 5,
          isHalfAllowed: true,
          halfFilledIcon: Icons.star_half,
          filledIcon: Icons.star,
          emptyIcon: Icons.star_border,
          size: StaticData.get_width(context) * 0.03,
          filledColor: Colors.yellow.shade700,
        ),
      ],
    ),
  );
}
