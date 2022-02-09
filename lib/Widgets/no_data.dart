import 'package:almajidoud/utils/file_export.dart';

Widget no_data_widget(
    {BuildContext context,
    var message = "No Products Yet !",
    var token_status,
    var image_status = false}) {
  return Center(
//    color: whiteColor,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image_status
            ? Container()
            : Container(
                child: Image.asset(
                  "assets/images/search.png",
                  width: width(context) * .7,
                  height: width(context) * .6,
                  // color: mainColor,
                ),
              ),
        responsiveSizedBox(context: context, percentageOfHeight: .04),
        token_status == 'token_expire'
            ? customDescriptionText(
                context: context,
                textColor: mainColor,
                text: message,
                maxLines: 2,
                percentageOfHeight: .015
        ) : customDescriptionText(
                context: context,
                textColor: mainColor,
                text: message,
                percentageOfHeight: .02
        ),
        responsiveSizedBox(context: context, percentageOfHeight: .05),
        token_status == 'token_expire'
            ? InkWell(
                onTap: () {
                  customAnimatedPushNavigation(context, SignInScreen());
                },
                child: Container(
                    width: width(context) * .8,
                    decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Center(
                        child: customDescriptionText(
                            context: context,
                            text: translator.translate("Back to Sign In Page"),
                            percentageOfHeight: .020,
                            textColor: whiteColor)),
                    height: isLandscape(context)
                        ? 2 * height(context) * .065
                        : height(context) * .065),
              )
            : Container()
      ],
    ),
  );
}
