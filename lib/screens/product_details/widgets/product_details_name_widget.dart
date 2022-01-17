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
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: Icon(Icons.arrow_back_ios),
              onTap: (){
                print("category_screen : ${category_screen}");
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
    ),
      ) );
}
