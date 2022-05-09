import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/custom_widgets/custom_button.dart';
import 'package:almajidoud/screens/Reviews/product_reviews_screen.dart';
import 'package:almajidoud/screens/my_account/widgets/logout_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/thanks_for_review_screen.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class AddReviewScreen extends StatefulWidget {
  var product_id;
  AddReviewScreen({this.product_id});
  @override
  _AddReviewScreenState createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen>
    with TickerProviderStateMixin {
  double ratingSmell = 0.0;
  double ratingLongLast = 0.0;
  double ratingPrice = 0.0;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nickname = new TextEditingController();
  TextEditingController summary = new TextEditingController();
  TextEditingController review = new TextEditingController();

  @override
  void initState() {
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController? _loginButtonController;
  bool isLoading = false;

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController!.forward();
    } on TickerCanceled {
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController!.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:   customDescriptionText(
            context: context,
            textColor: mainColor,
            text: "Add Review",
            percentageOfHeight: .025),
        centerTitle: true,
        elevation: 0,
        backgroundColor: whiteColor,
        leading:      GestureDetector(
          onTap: () {
            customAnimatedPushNavigation(context, ProductReviewsScreen(
              product_id: widget.product_id,
            ));
          },
          child: Icon(
            Icons.navigate_before,
            color: mainColor,
            size: 30,
          ),
        ),

      ),
        body:  BlocListener<ReviewsBloc, AppState>(
          bloc: reviewsBloc,
          listener: (context, state) {
            if (state is Loading) {
              if(state.indicator ==  "CreateReview")
              _playAnimation();
            }
            else if (state is ErrorLoading) {
              if(state.indicator ==  "CreateReview"){
                var data = state.model as ProductReviewModel;
                _stopAnimation();

                Flushbar(
                  messageText: Container(
                    width: StaticData.get_width(context) * 0.7,
                    child: Wrap(
                      children: [
                        Text(
                          '${data.message}',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  backgroundColor: redColor,
                  flushbarStyle: FlushbarStyle.FLOATING,
                  duration: Duration(seconds: 3),
                )..show(_drawerKey.currentState!.context);
              }

            } else if (state is Done) {
              if(state.indicator ==  "CreateReview") {
                var data = state.model as ProductReviewModel;
                _stopAnimation();
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context){
                      return ThanksForRatingScreen(
                        product_id: data.entityPkValue,
                      );
                    });
              }
            }
          },
          child: Directionality(
            textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
            child:SingleChildScrollView(
              child: Column(
                children: [
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .02),
                  textRateYourExperience(context: context),
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .05),
                  reviewText(context: context),
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .01),
                  singleReviewItem(
                      context: context,
                      rating: ratingSmell,
                      text: translator.translate("Stability")),
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .01),
                  singleReviewItem(
                      context: context,
                      rating: ratingLongLast,
                      text: translator.translate("Smell")),
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .01),
                  singleReviewItem(
                      context: context,
                      rating: ratingPrice,
                      text: translator.translate("Price")),
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .05),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        nickNameTextField(
                          context: context,
                        ),
                        responsiveSizedBox(
                            context: context,
                            percentageOfHeight: .01),
                        summaryTextField(context: context),
                        responsiveSizedBox(
                            context: context,
                            percentageOfHeight: .01),
                        reviewTextField(
                          context: context,
                        ),
                      ],
                    ),
                  ),
                  responsiveSizedBox(
                      context: context,
                      percentageOfHeight: .03),
                  StaggerAnimation(
                    titleButton: "Submit",
                    buttonController: _loginButtonController,
                    btn_width: width(context) * .7,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        reviewsBloc.add(CreateReviewEvent(
                            product_id: widget.product_id,
                            nickname: nickname.text,
                            title: summary.text,
                            detail: review.text));
                      } else {
                      }
                    },
                  )

                ],
              ),
            ),

            /*SingleChildScrollView(
              child: Column(
                children: [
                  addReviewsHeader(context: context,
                  product_id: widget.product_id),
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
                                        context: context,
                                        percentageOfHeight: .02),
                                    textRateYourExperience(context: context),
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .05),
                                    reviewText(context: context),
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .01),
                                    singleReviewItem(
                                        context: context,
                                        rating: ratingSmell,
                                        text: translator.translate("Stability")),
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .01),
                                    singleReviewItem(
                                        context: context,
                                        rating: ratingLongLast,
                                        text: translator.translate("Smell")),
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .01),
                                    singleReviewItem(
                                        context: context,
                                        rating: ratingPrice,
                                        text: translator.translate("Price")),
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .05),
                                    Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          nickNameTextField(
                                            context: context,
                                          ),
                                          responsiveSizedBox(
                                              context: context,
                                              percentageOfHeight: .01),
                                          summaryTextField(context: context),
                                          responsiveSizedBox(
                                              context: context,
                                              percentageOfHeight: .01),
                                          reviewTextField(
                                            context: context,
                                          ),
                                        ],
                                      ),
                                    ),
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .03),
                                    StaggerAnimation(
                                      titleButton: "Submit",
                                      buttonController: _loginButtonController,
                                      btn_width: width(context) * .7,
                                      onTap: () {
                                        if (_formKey.currentState!.validate()) {
                                          reviewsBloc.add(CreateReviewEvent(
                                              product_id: widget.product_id,
                                              nickname: nickname.text,
                                              title: summary.text,
                                              detail: review.text));
                                        } else {
                                        }
                                      },
                                    )

                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),*/
          )
      ),
    );
  }

  addReviewsHeader({BuildContext? context , var product_id}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05,
          left: width(context) * .05,
          top: isLandscape(context)
              ? 2 * height(context) * .062
              : height(context) * .062),
      width: width(context),
      color: whiteColor,
      height: isLandscape(context)
          ? 2 * height(context) * .12
          : height(context) * .12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              customAnimatedPushNavigation(context!, ProductReviewsScreen(
                product_id: product_id,
              ));
            },
            child: Icon(
              Icons.navigate_before,
              color: mainColor,
              size: 30,
            ),
          ),
          customDescriptionText(
              context: context,
              textColor: mainColor,
              text: "Add Review",
              percentageOfHeight: .025),
          SizedBox()
        ],
      ),
    );
  }

  textRateYourExperience({BuildContext? context}) {
    return customDescriptionText(
        context: context,
        textColor: mainColor,
        text: "Rate your experience !",
        fontWeight: FontWeight.bold,
        percentageOfHeight: .03);
  }

  reviewText({BuildContext? context}) {
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
              text: "Rate your experience !",
              percentageOfHeight: .025)
        ],
      ),
    );
  }

  singleReviewItem({BuildContext? context, String? text, double? rating}) {
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
            rating: rating!,
           // isReadOnly: false,
            size: height(context) * .045,
            color: Colors.orangeAccent,
            borderColor: Colors.orangeAccent,
            filledIconData: Icons.star,
            halfFilledIconData: Icons.star_half,
            defaultIconData: Icons.star_border,
            starCount: 5,
            allowHalfRating: true,
            spacing: 5.0,
            onRatingChanged: (value) {
              setState(() {
                rating = value;
              });

            },
          ),
        ],
      ),
    );
  }

  nickNameTextField({BuildContext? context,}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      child: TextFormField(
        controller: nickname,
        style: TextStyle(
            color: mainColor,
            fontSize: isLandscape(context)
                ? 2 * height(context) * .02
                : height(context) * .02),
        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          hintText: translator.translate("nickName"),
          hintStyle: TextStyle(
              color: mainColor,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${"Please enter".tr()} ${"nickName".tr()}';
          }
          return null;
        },
      ),
    );
  }

  summaryTextField({BuildContext? context,}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      child: TextFormField(
        controller: summary,
        style: TextStyle(
            color: mainColor,
            fontSize: isLandscape(context)
                ? 2 * height(context) * .02
                : height(context) * .02),
        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          hintText: translator.translate("summary"),
          hintStyle: TextStyle(
              color: mainColor,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${translator.translate("Please enter")} ${translator.translate("Summary")}';
          }
          return null;
        },
      ),
    );
  }

  reviewTextField({BuildContext? context,}) {
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05, left: width(context) * .05),
      child: TextFormField(
        controller: review,
        style: TextStyle(
            color: mainColor,
            fontSize: isLandscape(context)
                ? 2 * height(context) * .02
                : height(context) * .02),
        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          hintText: translator.translate("Review"),
          hintStyle: TextStyle(
              color: mainColor,
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
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${translator.translate("Please enter")} ${translator.translate("Review")}';
          }
          return null;
        },
      ),
    );
  }
}
