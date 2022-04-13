import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/custom_widgets/cart_badge.dart';
import 'package:almajidoud/screens/SearchScreen/auto_search_class.dart';
import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_alert_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:flutter/scheduler.dart';

class CartScreenAppBar extends StatefulWidget {
  Function? onTapCategoryDrawer;
  final String? left_icon;
  final String? right_icon;
  final String? category_name;
  Widget? screen;
  final bool? home_logo;
  CartScreenAppBar(
      {this.onTapCategoryDrawer,
      this.left_icon,
      this.right_icon,
      this.category_name,
      this.screen,
      this.home_logo = false});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartScreenAppBarState();
  }
}

class CartScreenAppBarState extends State<CartScreenAppBar> {
  TextEditingController controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: width(context),
        color: whiteColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child:      Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                        onTap: () {
                          customPushNamedNavigation(context, widget.screen);
                        },
                        child: Icon(
                          Icons.navigate_before,
                          color: mainColor,
                          size: 30,
                        ),
                      ),

                Text(
                        widget!.category_name!,
                        style: TextStyle(
                            color: mainColor,
                            fontSize: AlmajedFont.primary_font_size),
                      ),

                GestureDetector(
                            onTap: () {
                              customAnimatedPushNavigation(
                                  context, CustomCircleNavigationBar());
                            },
                            child: Image.asset(
                              "assets/icons/logo.png",
                              color: mainColor,
                              height: isLandscape(context)
                                  ? 2 * height(context) * .03
                                  : height(context) * .03,
                            ))

              ],
            ),
        ),
            Divider(color:mainColor,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
