import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart' as cart_details_model;
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';

import 'package:almajidoud/screens/cart/widgets/proceed_to_checkout_button.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_widget.dart';
import 'package:almajidoud/screens/cart/widgets/single_cart_item.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/utils/file_export.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();

  var edit_cart_status = false;
  @override
  void initState() {
    shoppingCartBloc.add(GetCartDetails());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
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
                        context: context, percentageOfHeight: .080),
                    HomeSlider(gallery: StaticData.images),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    BlocBuilder(
                      bloc: shoppingCartBloc,
                      builder: (context, state) {
                        if (state is Loading) {
                          if (state.indicator == "UpdateProductQuantity") {
                          } else if (state.indicator == 'DeleteProductFromCart') {
                          }  else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        } else if (state is Done) {
                          if (state.indicator == "UpdateProductQuantity") {
                          }
                          else if (state.indicator == 'DeleteProductFromCart') {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context)=>translator.activeLanguageCode == 'ar' ? CustomCircleNavigationBar(page_index: 4,) :  CustomCircleNavigationBar(page_index: 0,)
                            ));
                          }
                          else {
                            var data = state.model as CartDetailsModel;
                            if (data.message?.isEmpty != null) {
                              return no_data_widget(context: context);
                            } else {
                              print("111111111111111");

                              return Column(
                                children: [
                                  StreamBuilder<CartDetailsModel>(
                                    stream:
                                        shoppingCartBloc.cart_details_subject,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.items.isEmpty ) {
                                          return no_data_widget(context: context);
                                        } else {
                                          print("car length : ${snapshot.data.items.length}");

                                          return Column(
                                            children: [
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  itemCount: snapshot.data.items.length,
                                                  scrollDirection: Axis.vertical,
                                                  itemBuilder: (context, index) {
                                                    print("snapshot.data.items.length : ${snapshot.data.items.length}");
                                                    return singleCartItem(
                                                        context: context,
                                                        item: snapshot
                                                            .data.items[index]);
                                                  }),

                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .02),
                                              PromoCodeWidget(),
                                              Container(
                                                width: width(context) * .9,
                                                child: Divider(color: greyColor),
                                              ),

                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .01),
                                              customDescriptionText(
                                                  context: context,
                                                  textColor: greyColor,
                                                  text: "Total to pay",
                                                  percentageOfHeight: .025),
                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .01),
                                              customDescriptionText(
                                                  context: context,
                                                  textColor: mainColor,
                                                  text:
                                                  " ${data.baseGrandTotal.toString()} ${translator.translate("SAR")} ",
                                                  percentageOfHeight: .03,
                                                  fontWeight: FontWeight.bold),
                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .01),
                                              proceedToCheckoutButton(context: context),
                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .01),
                                            ],
                                          );

                                        }
                                      } else if (snapshot.hasError) {
                                        return Container(
                                          child: Text('${snapshot.error}'),
                                        );
                                      } else {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                        ;
                                      }
                                    },
                                  ),

                                ],
                              );
                            }
                          }
                        } else if (state is ErrorLoading) {
                          if (state.indicator == "UpdateProductQuantity") {
                          } else if (state.indicator ==
                              'DeleteProductFromCart') {
                          } else {
                            return Column(children: [
                              responsiveSizedBox(
                                  context: context,
                                  percentageOfHeight: .03),
                        no_data_widget(context: context),
                            ],);


                          }
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
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
                      left_icon: edit_cart_status ? "" : "assets/icons/edit.png" ,
                      right_icon: 'cart',
                      screen: CustomCircleNavigationBar(page_index: 2,),
                      category_name: translator.translate("Cart"),
                    ),
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
