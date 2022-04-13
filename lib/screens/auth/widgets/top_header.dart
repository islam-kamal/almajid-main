import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';

topHeader({BuildContext? context}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
        top: width(context) * .0),
    width: width(context),
    color: whiteColor,
    height: isLandscape(context)
        ? 2 * height(context) * .07
        : height(context) * .07,
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            StaticData.vistor_value = "visitor";
            cartRepository.create_quote(context: context);
            customAnimatedPushNavigation(context!, CustomCircleNavigationBar());
          },
          child: Icon(
            Icons.navigate_before,
            color: mainColor,
            size: 30,
          ),
        ),
      ],
    ),
  );
}
