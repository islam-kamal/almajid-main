import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/custom_widgets/cart_badge.dart';
import 'package:almajidoud/screens/SearchScreen/auto_search_class.dart';
import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_alert_dialog.dart';
import 'package:almajidoud/screens/home/widgets/categories_tap.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/scheduler.dart';

class ScreenAppBar extends StatefulWidget {
  Function onTapCategoryDrawer;
  final String left_icon;
  final String right_icon;
  final String category_name;
  Widget screen;
  final bool home_logo;
  ScreenAppBar(
      {this.onTapCategoryDrawer,
        this.left_icon,
        this.right_icon,
        this.category_name,
        this.screen,
        this.home_logo= false});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ScreenAppBarState();
  }
}

class ScreenAppBarState extends State<ScreenAppBar> {
  TextEditingController controller = new TextEditingController();
  final FocusNode focusNode = new FocusNode();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: width(context),
        color: whiteColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child:      Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.right_icon == null
                      ? GestureDetector(
                    onTap: widget.onTapCategoryDrawer,
                    child: Image.asset(
                      "assets/icons/category.png",
                      height: isLandscape(context)
                          ? 2 * height(context) * .04
                          : height(context) * .03,
                      color: mainColor,
                    ),
                  )
                      : GestureDetector(
                    onTap: () {
                      customPushNamedNavigation(context, widget.screen);
                    },
                    child: Icon(
                      Icons.navigate_before,
                      color: blackColor,
                      size: 30,
                    ),
                  ),

                  Padding(padding: EdgeInsets.only(right: translator.activeLanguageCode == 'ar'? 15 : 0,left: translator.activeLanguageCode == 'en'? 15 : 0),
                    child:  widget.category_name == null
                      ?  MyTextField(controller, focusNode)
                      : Text(
                    widget.category_name,
                    style: TextStyle(
                        color: blackColor,
                        fontSize: AlmajedFont.primary_font_size),
                  ),
                  ),



                  widget.category_name != null || widget.home_logo == true
                      ? widget.left_icon == null
                      ?
                  CartBadge()
                      : GestureDetector(
                    onTap: () {
                      customAnimatedPushNavigation(
                          context, NotificationsScreen());

                    },
                    child: Image.asset(
                      widget.left_icon,
                      height: isLandscape(context)
                          ? 2 * height(context) * .03
                          : height(context) * .03,
                    ),
                  )
                      : Container(),
                ],
              ),
            ),
            Divider(color:mainColor,
              thickness: 1,
            ),
            widget.home_logo ?  CategoriesTap() : Container(),
          ],
        ),
      ),
    );
  }
}
