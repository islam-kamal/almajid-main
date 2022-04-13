import 'package:flutter/cupertino.dart';
import 'package:almajidoud/custom_widgets/responsive_sized_box.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
import 'package:almajidoud/custom_widgets/custom_description_text.dart';
import 'package:almajidoud/utils/file_export.dart';

Future showCustomAlertDialog(

    {BuildContext? context,
      bool withSecondTitle : false ,
      String secondTitle : "" ,
      Widget icon : const Icon(Icons.close),
    Color circleColor: mainColor,
    String alertTitle: '',
    String alertSubtitle: '',
    bool withTwoButtons: false,
      int  maxLines : 2 ,
    String secondButtoText : "" ,
      VoidCallback ? onTapSecondButton}) {
  return showDialog<void>(
    context: context!,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: whiteColor,
        content: Container(
          width: isLandscape(context)
              ? .7 * width(context) * .85
              : width(context) * .85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              Container(
                  height: isLandscape(context)
                      ? 2 * height(context) * .1
                      : height(context) * .1,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: circleColor ),
                  child: Center(child: icon)),
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              customDescriptionText(context: context, text: translator.translate(alertTitle) , percentageOfHeight: .03 ,textColor: whiteColor, fontWeight: FontWeight.bold),

                  responsiveSizedBox(context: context, percentageOfHeight:  withSecondTitle == true ? .01:0.0 ),
             withSecondTitle == true ? customDescriptionText(context: context, text: translator.translate(secondTitle) , textColor: whiteColor, percentageOfHeight: .02 , maxLines: maxLines
              ) : SizedBox(),
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              customDescriptionText(context: context, text: translator.translate(alertSubtitle) , percentageOfHeight: .02 , textColor: mainColor,maxLines: maxLines
              )
            ],
          ),
        ),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.all(
              height(context) * .02,
            ),
            child: Row(
              children: [
                Container(
                  child: withTwoButtons == true
                      ? GestureDetector(
                          child:
                          customDescriptionText(context: context, text: secondButtoText ,
                              textColor: mainColor
                              , percentageOfHeight: .025 , fontWeight: FontWeight.bold ),
                       onTap: onTapSecondButton)
                      : SizedBox(),
                ),
                SizedBox(
                  width: width(context) * .05,
                ),
                GestureDetector(
                  child:
                  customDescriptionText(context: context, text: "Close" , textColor: whiteColor , percentageOfHeight: .023),
                  onTap: () {
                    Navigator.of(context).pop();
//                    customPushNamedNavigation(context, HomeScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
