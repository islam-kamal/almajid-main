import 'package:almajidoud/Widgets/customWidgets.dart';
import 'package:almajidoud/utils/file_export.dart';

orderIdStack({BuildContext context,var order_id,var status , var createAt}) {

  return Directionality(
      textDirection: translator.activeLanguageCode =='ar'? TextDirection.rtl : TextDirection.ltr,
      child: Container(

          padding: EdgeInsets.only(
              top: isLandscape(context)
                  ? 2 * height(context) * .15
                  : height(context) * .15),
          height: isLandscape(context) ? 2 * height(context) : height(context),
          child: Container(
            padding: EdgeInsets.only(
                right: width(context) * .05, left: width(context) * .05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: width(context) * .60,
                      child: Row(
                        children: [
                          customDescriptionText(
                              context: context,
                              text: "${translator.translate("Order ID")} : ",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              percentageOfHeight: .020,
                              textColor: mainColor),
                          customDescriptionText(
                              context: context,
                              text: "${order_id??''}",
                              maxLines: 1,
                              textAlign: TextAlign.start,
                              percentageOfHeight: .023,
                              textColor: mainColor),
                        ],
                      )
                    ),
                    Container(
                      height: isLandscape(context)
                          ? 2 * height(context) * .06
                          : height(context) * .06,
                      decoration: BoxDecoration(
                          color: mainColor,
                          borderRadius: BorderRadius.circular(20)),
                      width: width(context) * .30,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_outlined,
                            color: whiteColor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          customDescriptionText(
                              context: context,
                              textColor: whiteColor,
                              text: "${CustomComponents.order_status(status)??''}"),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  width: width(context) * .9,
                  child: customDescriptionText(
                      context: context,
                      text: "${translator.translate("Ordered On")} :  ${createAt??''}",
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      percentageOfHeight: .017,
                      textColor: mainColor),
                ),
              ],
            ),
          )));
}

