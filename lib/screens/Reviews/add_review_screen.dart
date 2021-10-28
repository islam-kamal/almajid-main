import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/custom_widgets/custom_button.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/thanks_for_review_screen.dart';

class AddReviewScreen extends StatefulWidget {
  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  double ratingSmell = 5.0;
  double ratingLongLast = 5.0;
  double ratingPrice = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: isLandscape(context) ? 2 * height(context) : height(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            addReviewsHeader(context: context),
            Container(
              height: isLandscape(context)
                  ? 2 * height(context) * .88
                  : height(context) * .88,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        height: isLandscape(context)
                            ? 2 * height(context) * .88
                            : height(context) * .88,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .02),
                              textRateYourExperience(context: context),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .05),
                              reviewText(context: context),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              singleReviewItem(
                                  context: context,
                                  rating: ratingSmell,
                                  text: "Smell"),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              singleReviewItem(
                                  context: context,
                                  rating: ratingLongLast,
                                  text: "Long Last"),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              singleReviewItem(
                                  context: context,
                                  rating: ratingPrice,
                                  text: "Price"),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .1),
                              reviewTextField(
                                  context: context, hint: "NickMame"),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              reviewTextField(
                                  context: context, hint: "Summary"),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              reviewTextField(context: context, hint: "Review"),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .1),
                              CustomButton(
                                  text: "Submit",
                                  onTapButton: () {
                                    customAnimatedPushNavigation(
                                        context, ThanksForRatingScreen());
                                  },
                                  radius: 10)
                            ],
                          ),
                        )),
//            ----------------------------------- top part
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  addReviewsHeader({BuildContext context}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05,
          left: width(context) * .05,
          top: isLandscape(context)
              ? 2 * height(context) * .062
              : height(context) * .062),
      width: width(context),
      color: mainColor,
      height: isLandscape(context)
          ? 2 * height(context) * .12
          : height(context) * .12,
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
              text: "Add Review",
              percentageOfHeight: .025),
          SizedBox()
        ],
      ),
    );
  }

  textRateYourExperience({BuildContext context}) {
    return customDescriptionText(
        context: context,
        textColor: mainColor,
        text: "Rate your your experience !",
        fontWeight: FontWeight.bold,
        percentageOfHeight: .03);
  }

  reviewText({BuildContext context}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      child: Row(
        children: [
          Icon(Icons.rate_review_outlined),
          SizedBox(width: 5),
          customDescriptionText(
              context: context,
              textColor: mainColor,
              text: "Rate your your experience !",
              percentageOfHeight: .025)
        ],
      ),
    );
  }

  singleReviewItem({BuildContext context, String text, double rating}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customDescriptionText(
              context: context,
              textColor: mainColor,
              text: text,
              percentageOfHeight: .025,
              fontWeight: FontWeight.bold),
          SizedBox(width: 5),
          SmoothStarRating(
            rating: rating,
            isReadOnly: false,
            size: height(context) * .045,
            color: Colors.orangeAccent,
            borderColor: Colors.orangeAccent,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            spacing: 5.0,
            onRated: (value) {
              setState(() {
                rating = value;
                print(rating);
              });

              print("rating value -> $value");
              // print("rating value dd -> ${value.truncate()}");
            },
          ),
        ],
      ),
    );
  }

  reviewTextField({BuildContext context, String hint}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      height: isLandscape(context)
          ? 2 * height(context) * .08
          : height(context) * .08,
      child: TextFormField(
        style: TextStyle(
            color: greyColor.withOpacity(.5),
            fontSize: isLandscape(context)
                ? 2 * height(context) * .02
                : height(context) * .02),
        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          hintText: translator.translate(hint),
          hintStyle: TextStyle(
              color: greyColor.withOpacity(.5),
              fontWeight: FontWeight.bold,
              fontSize: isLandscape(context)
                  ? 2 * height(context) * .018
                  : height(context) * .018),
          filled: true,
          fillColor: whiteColor,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blackColor)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blackColor)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: blackColor)),
        ),
      ),
    );
  }
}
