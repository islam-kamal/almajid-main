import 'package:almajidoud/screens/cart/widgets/cart_bottom_navigation_bar.dart';
import 'package:almajidoud/screens/cart/widgets/cart_top_slider.dart';
import 'package:almajidoud/screens/cart/widgets/proceed_to_checkout_button.dart';
import 'package:almajidoud/screens/cart/widgets/single_cart_item.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    bool switch1 = true;
    return NetworkIndicator(
        child: PageContainer(
            child:Scaffold(
      backgroundColor: whiteColor,
      body: Container(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              Container(
                height: height(context),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .104),
                    cartTopSlider(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    Container(
                      height: isLandscape(context)
                          ? 2 * height(context) * .35
                          : height(context) * .35,
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          return singleCartItem(context: context);
                        },
                        itemCount: 2,
                      ),
                    ),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    Container(
                      width: width(context) * .8,
                      child: Divider(color: greyColor),
                    ),
                    customDescriptionText(
                        context: context,
                        textColor: greyColor,
                        text: "Total To Pay",
                        percentageOfHeight: .025),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    customDescriptionText(
                        context: context,
                        textColor: mainColor,
                        text: " 2.400 \$ ",
                        percentageOfHeight: .03,
                        fontWeight: FontWeight.bold),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    proceedToCheckoutButton(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                  ],
                )),
              ),
              Container(
                height: height(context),
                width: width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ScreenAppBar(
                      onTapCategoryDrawer: () {
                        _drawerKey.currentState.openDrawer();
                      },
                      left_icon: "assets/icons/edit.png",
                      right_icon: 'cart',
                    ),
                    cartBottomNavigationBar(context: context)
                  ],
                ),
              ),
            ],
          )),
      drawer: SettingsDrawer(
        node: fieldNode,
      ),
    )));
  }
}
