import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:almajidoud/screens/cart/edit_cart_screen.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_alert_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';

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
    return Container(
      padding: EdgeInsets.only(
          right: width(context) * .05,
          left: width(context) * .05,
          bottom: isLandscape(context)
              ? 2 * height(context) * .01
              : height(context) * .01),
      width: width(context),
      color: mainColor,
      height: isLandscape(context)
          ? 2 * height(context) * .08
          : height(context) * .08,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.right_icon == null
                  ? GestureDetector(
                      onTap: widget.onTapCategoryDrawer,
                      child: Image.asset(
                        "assets/icons/category.png",
                        height: isLandscape(context)
                            ? 2 * height(context) * .04
                            : height(context) * .04,
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        customPushNamedNavigation(context, widget.screen);
                      },
                      child: Icon(
                        Icons.navigate_before,
                        color: whiteColor,
                        size: 30,
                      ),
                    ),
              widget.category_name == null
                  ? Container(
                      width: width(context) * .5,
                      height: isLandscape(context)
                          ? 2 * height(context) * .04
                          : height(context) * .04,
                      child: TextFormField(
                        controller: controller,
                        style: TextStyle(color: whiteColor, fontWeight: FontWeight.normal,
                            fontSize: 12,decoration: TextDecoration.none),
                        textAlign: TextAlign.right,

                        focusNode: focusNode,
                        cursorColor: greyColor.withOpacity(.5),
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: whiteColor, fontSize: 8,decoration: TextDecoration.none),
                          hintText: translator.translate("Type here to search"),
                          prefixIcon: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 20,
                            ),

                            color: whiteColor,
                            onPressed: () {
                              search_bloc.add(SearchProductsEvent(
                                  search_text: controller.text));

                              customAnimatedPushNavigation(
                                  context, SearchScreen());
                            },
                          ),
                          filled: false,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: whiteColor, width: 2)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: whiteColor, width: 2)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: whiteColor, width: 2)),
                        ),
                      ),
                    )
                  : Text(
                      widget.category_name,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: AlmajedFont.primary_font_size),
                    ),
              widget.category_name != null || widget.home_logo == true
                  ? widget.left_icon == null
                      ? Image.asset(
                          "assets/icons/logo.png",
                          height: isLandscape(context)
                              ? 2 * height(context) * .05
                              : height(context) * .05,
                        )
                      : GestureDetector(
                          onTap: () {
                            if (widget.left_icon == "assets/icons/edit.png") {
                              customAnimatedPushNavigation(
                                  context, EditCartScreen());
                            } else {
                              customAnimatedPushNavigation(
                                  context, NotificationsScreen());
                            }
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
        ],
      ),
    );
  }
}
