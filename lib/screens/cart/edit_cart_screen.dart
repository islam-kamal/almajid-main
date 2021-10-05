import 'package:almajidoud/screens/cart/widgets/cancel_button.dart';
import 'package:almajidoud/screens/cart/widgets/cart_bottom_navigation_bar.dart';
import 'package:almajidoud/screens/cart/widgets/cart_top_slider.dart';
import 'package:almajidoud/screens/cart/widgets/edi-tcart_header.dart';
import 'package:almajidoud/screens/cart/widgets/single_edit_cart_item.dart';
import 'package:almajidoud/utils/file_export.dart';

class EditCartScreen extends StatefulWidget {
  @override
  _EditCartScreenState createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen> {
  @override
  Widget build(BuildContext context) {
    bool checkValue = true;
    return Scaffold(
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
                              ? 2 * height(context) * .45
                              : height(context) * .45,
                          child: ListView.builder(
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index) {
                              return singleEditCartItem(context: context ,checkValue: checkValue);
                            },
                            itemCount: 2,
                          ),
                        ),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .03),
                    cancelButton(context: context),
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
                    editCartHeader(context: context),
                    cartBottomNavigationBar(context: context)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
