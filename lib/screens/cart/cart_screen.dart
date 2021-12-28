import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart'
    as cart_details_model;
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';

import 'package:almajidoud/screens/cart/widgets/proceed_to_checkout_button.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_widget.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();
  String _dropDownValue;

  var edit_cart_status = false;

  @override
  void initState() {
    shoppingCartBloc.add(GetCartDetailsEvent());
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
                        context: context, percentageOfHeight: .055),
                    HomeSlider(gallery: StaticData.images),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .04),
                    BlocBuilder(
                      bloc: shoppingCartBloc,
                      builder: (context, state) {
                        if (state is Loading) {
                          if (state.indicator == 'GetCartDetails') {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        } else if (state is Done) {
                          if (state.indicator == 'GetCartDetails') {
                            var data = state.model as CartDetailsModel;
                            if (data.message?.isEmpty != null) {
                              return no_data_widget(context: context);
                            } else {
                              return Column(
                                children: [
                                  StreamBuilder<CartDetailsModel>(
                                    stream:
                                        shoppingCartBloc.cart_details_subject,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data.items.isEmpty) {
                                          return no_data_widget(
                                              context: context);
                                        } else {
                                          print("cart length : ${snapshot.data.items.length}");

                                          return Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                  right: width(context) * .05,
                                                  left: width(context) * .05,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: whiteColor),
                                                child: Column(
                                                  children: [
                                                    textSwipeLeft(),
                                                    divider(context: context),
                                                  ],
                                                ),
                                              ),
                                              ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: snapshot
                                                      .data.items.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Slidable(
                                                      actionPane:
                                                          SlidableDrawerActionPane(),
                                                      actionExtentRatio: 0.25,
                                                      child: Column(children: [
                                                        SizedBox(
                                                          height:
                                                              width(context) *
                                                                  .002,
                                                        ),
                                                        singleCartItem(
                                                            context: context,
                                                            item: snapshot.data
                                                                .items[index]),
                                                        SizedBox(
                                                          height:
                                                              width(context) *
                                                                  .002,
                                                        ),
                                                      ]),
                                                      secondaryActions: [
                                                        IconSlideAction(
                                                          caption: translator
                                                              .translate(
                                                                  "Delete"),
                                                          color: Colors.red,
                                                          icon: Icons.delete,
                                                          onTap: () => delete_cart_item(
                                                              cart_item_id:
                                                                  snapshot
                                                                      .data
                                                                      .items[
                                                                          index]
                                                                      .itemId),
                                                        ),
                                                      ],
                                                    );
                                                  }),
                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .02),
                                              divider(context: context),
                                              PromoCodeWidget(),
                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .02),
                                              divider(context: context),
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
                                                      " ${snapshot.data.baseGrandTotal.toString()} ${MyApp.country_currency} ",
                                                  percentageOfHeight: .03,
                                                  fontWeight: FontWeight.bold),
                                              responsiveSizedBox(
                                                  context: context,
                                                  percentageOfHeight: .02),
                                              proceedToCheckoutButton(
                                                  context: context),
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
                          if (state.indicator == 'GetCartDetails') {
                            if (state.message ==
                                "The consumer isn't authorized to access %resources.") {
                              return Column(
                                children: [
                                  responsiveSizedBox(
                                      context: context,
                                      percentageOfHeight: .03),
                                  no_data_widget(
                                      context: context,
                                      message: state.message,
                                      token_status: 'token_expire'),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  responsiveSizedBox(
                                      context: context,
                                      percentageOfHeight: .03),
                                  no_data_widget(context: context),
                                ],
                              );
                            }
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
                      right_icon: 'cart',
                      screen: CustomCircleNavigationBar(
                        page_index: 2,
                      ),
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

  void delete_cart_item({var cart_item_id}) async {
    final response = await cartRepository.delete_product_from_cart(
      item_id: cart_item_id,
    );
    if (response) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => translator.activeLanguageCode == 'ar'
                  ? CustomCircleNavigationBar(
                      page_index: 4,
                    )
                  : CustomCircleNavigationBar(
                      page_index: 0,
                    )));
    } else {
      print("item can't be deleted");
    }
  }
  Widget textSwipeLeft() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(left: width * .075),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            "assets/images/swipe.png",
            height: height * .03,
          ),
          Text(
            translator.translate("swipe"),
            style: TextStyle(
                fontSize: height * .015,
                fontWeight: FontWeight.bold,
                color: mainColor),
          ),
        ],
      ),
    );
  }
  singleCartItem({BuildContext context, cart_details_model.Items item}) {
    List<String> qantity_numbers = [];
    for (int i = 1; i < 20; i++) {
      qantity_numbers.add(i.toString());
    }
    return Directionality(
        textDirection: translator.activeLanguageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                responsiveSizedBox(context: context, percentageOfHeight: .02),
                Neumorphic(
                    child: Container(
                        width: width(context) * .95,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3, left: 3),
                              width: width(context) * .3,
                              height: isLandscape(context)
                                  ? 2 * height(context) * .15
                                  : height(context) * .15,
                              decoration: BoxDecoration(
                                  color: backGroundColor,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),
                                      fit: BoxFit.fill)),
                            ),
                            Directionality(
                                textDirection:
                                    translator.activeLanguageCode == 'ar'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: width(context) * .02,
                                      left: width(context) * .02),
                                  width: width(context) * .6,
                                  height: isLandscape(context)
                                      ? 2 * height(context) * .17
                                      : height(context) * .17,
                                  child: Column(
                                    crossAxisAlignment:
                                        translator.activeLanguageCode == 'ar'
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.start,
                                    children: [
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .021),
                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          maxLines: 2,
                                          text: item.name ?? '',
                                          textAlign:
                                              translator.activeLanguageCode ==
                                                      'ar'
                                                  ? TextAlign.end
                                                  : TextAlign.start),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .02),
                                      Row(
                                        children: [
                                          Container(
                                            child: customDescriptionText(
                                                context: context,
                                                textColor: mainColor,
                                                text:
                                                    " ${item.price} ${MyApp.country_currency}",
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .02),
                                      Row(
                                        children: [
                                          customDescriptionText(
                                              context: context,
                                              textColor: mainColor,
                                              text:
                                                  "${translator.translate("Qty")} : ",
                                              textAlign: TextAlign.start,
                                              fontWeight: FontWeight.bold),
                                          SizedBox(
                                            width: width(context) * .01,
                                          ),
                                          Container(
                                            width: width(context) * .15,
                                            height: isLandscape(context)
                                                ? 2 * height(context) * .035
                                                : height(context) * .035,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: mainColor)),
                                            child: DropdownButton(
                                              hint: _dropDownValue == null
                                                  ? Text(
                                                      "   ${item.qty.toString()}   ",
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  : Text("  $_dropDownValue  ",
                                                      style: TextStyle(
                                                          color: mainColor),
                                                      textAlign:
                                                          TextAlign.center),
                                              isExpanded: true,
                                              iconSize: 30.0,
                                              style:
                                                  TextStyle(color: Colors.blue),
                                              items: qantity_numbers.map(
                                                (val) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: val,
                                                    child: Text(
                                                      "  $val  ",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  );
                                                },
                                              ).toList(),
                                              onChanged: (val) async{
                                                _dropDownValue = val;
                                                final response = await cartRepository
                                                    .update_product_quantity_cart(
                                                    item_id:
                                                    item.itemId,
                                                    product_quantity:
                                                    _dropDownValue);
                                                if (response.message != null) {
                                                  Flushbar(
                                                    messageText: Row(
                                                      children: [
                                                        Container(
                                                          width: StaticData
                                                              .get_width(
                                                              context) *
                                                              0.7,
                                                          child: Wrap(
                                                            children: [
                                                              Text(
                                                                '${"There is Error"}',
                                                                textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                                style: TextStyle(
                                                                    color:
                                                                    whiteColor),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          translator.translate(
                                                              "Try Again"),
                                                          textDirection:
                                                          TextDirection
                                                              .rtl,
                                                          style: TextStyle(
                                                              color:
                                                              whiteColor),
                                                        ),
                                                      ],
                                                    ),
                                                    flushbarPosition:
                                                    FlushbarPosition
                                                        .BOTTOM,
                                                    backgroundColor:
                                                    redColor,
                                                    flushbarStyle:
                                                    FlushbarStyle
                                                        .FLOATING,
                                                    duration: Duration(
                                                        seconds: 3),
                                                  )..show(_drawerKey
                                                      .currentState
                                                      .context);
                                                } else {
                                                  print(
                                                      "UpdateProductQuantityCart Done");
                                                  customAnimatedPushNavigation(
                                                      context,
                                                      translator.activeLanguageCode ==
                                                          'ar'
                                                          ? CustomCircleNavigationBar(
                                                        page_index: 4,
                                                      )
                                                          : CustomCircleNavigationBar(
                                                        page_index: 0,
                                                      ));
                                                }


                                              },
                                            ),
                                          )

                                          /* Container(
                                  width: width(context) * .15,
                                  height: isLandscape(context)
                                      ? 2 * height(context) * .035
                                      : height(context) * .035,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: mainColor)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          text: "${item.qty}",
                                          textAlign: TextAlign.start),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                )*/
                                        ],
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                        decoration: BoxDecoration(color: backGroundColor))),
              ],
            ),
          ],
        ));
  }


}
