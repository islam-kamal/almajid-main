import 'package:almajidoud/custom_widgets/cart_badge.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';

productDetailsNameWidget({BuildContext context , String product_name , Widget category_screen}) {
  return     Directionality(
      textDirection:
      translator.activeLanguageCode == 'en'
      ? TextDirection.ltr
          : TextDirection.rtl,
      child:Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
    Padding(
    padding: EdgeInsets.symmetric(horizontal: 10),
        child:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InkWell(
                  child: Icon(Icons.arrow_back_ios),
                  onTap: (){
                    category_screen== null?  customAnimatedPushNavigation(context, CustomCircleNavigationBar())
                        : customAnimatedPushNavigation(context, category_screen) ;
                  },
                ),
                Container(
                  width: width(context) * .7,
                  child: customDescriptionText(
                      context: context,
                      maxLines: 2,
                      text: product_name??"",
                      percentageOfHeight: .020),
                )
              ],
            ),
            CartBadge(iconColor: Colors.black,)
          ],
        ) ),
        Divider(color:mainColor,
          thickness: 1,
        ),
      ],
    )
      ) );
}
