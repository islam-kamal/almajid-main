import 'package:almajidoud/utils/file_export.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

singleRatingWidget({
  BuildContext? context,
  var title,
  var detail,
  var nickname,
  var createdAt
}) {
  return Container(
    padding:
        EdgeInsets.only(right: width(context) * .0, left: width(context) * .0),
    margin: EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
              "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg"),
        ),
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width(context) * .75,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customDescriptionText(
                      context: context,
                      percentageOfHeight: .020,
                      maxLines: 2,
                      text: "${nickname}",
                      fontWeight: FontWeight.bold,
                      textAlign: TextAlign.start),
                  customDescriptionText(
                      context: context,
                      percentageOfHeight: .015,
                      text: "${createdAt.toString().substring(0,16)}",
                      textColor: greyColor,
                      textAlign: TextAlign.start),
                ],
              ),
            ),
            SmoothStarRating(
              rating: 5.0,
             // isReadOnly: true,
              size: height(context) * .02,
              color: Colors.orangeAccent,
              borderColor: Colors.orangeAccent,
              filledIconData: Icons.star,
              halfFilledIconData: Icons.star_half,
              defaultIconData: Icons.star_border,
              starCount: 5,
              allowHalfRating: true,
              spacing: 5.0,
            ),
            responsiveSizedBox(
                context: context, percentageOfHeight: .005),
            Container(
                width: width(context) * .65,
                child: customDescriptionText(
                    context: context,
                    percentageOfHeight: .017,
                    textColor: greyColor,
                    maxLines: 20,
                    textHeight: 1.1,
                    text: "${detail}",
                    textAlign: TextAlign.start))
          ],
        )
      ],
    ),
  );
}
