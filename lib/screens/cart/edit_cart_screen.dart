import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/cart/widgets/edi-tcart_header.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart'
    as cart_details_model;

class EditCartScreen extends StatefulWidget {
  @override
  _EditCartScreenState createState() => _EditCartScreenState();
}

class _EditCartScreenState extends State<EditCartScreen>
    with TickerProviderStateMixin {
  var item_id;
  String _dropDownValue;
  List<Map> selected_products_quantity;

  @override
  void initState() {
    selected_products_quantity = [];
    shoppingCartBloc.add(GetCartDetails());
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }


  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool checkValue = true;
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      backgroundColor: whiteColor,
      body: BlocListener<ShoppingCartBloc, AppState>(
          bloc: shoppingCartBloc,
          listener: (context, state) {
            if (state is Loading) {
              if (state.indicator == "UpdateProductQuantity") _playAnimation();
            } else if (state is ErrorLoading) {
              if (state.indicator == "UpdateProductQuantity") {
                _stopAnimation();
                Flushbar(
                  messageText: Row(
                    children: [
                      Container(
                        width: StaticData.get_width(context) * 0.7,
                        child: Wrap(
                          children: [
                            Text(
                              '${"There is Error"}',
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: whiteColor),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Text(
                        translator.translate("Try Again"),
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: whiteColor),
                      ),
                    ],
                  ),
                  flushbarPosition: FlushbarPosition.BOTTOM,
                  backgroundColor: redColor,
                  flushbarStyle: FlushbarStyle.FLOATING,
                  duration: Duration(seconds: 3),
                )..show(_drawerKey.currentState.context);
              }
            } else if (state is Done) {
              if (state.indicator == "UpdateProductQuantity") {
                _stopAnimation();
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) {
                      return translator.activeLanguageCode == 'ar' ? customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 0,))
                            : customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 4,));
                    },
                    transitionsBuilder:
                        (context, animation8, animation15, child) {
                      return FadeTransition(
                        opacity: animation8,
                        child: child,
                      );
                    },
                    transitionDuration: Duration(milliseconds: 10),
                  ),
                );
              }
            }
          },
          child: Container(
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
                              if (state.indicator == 'UpdateProductQuantity') {
                              } else if (state.indicator ==
                                  'DeleteProductFromCart') {
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            } else if (state is Done) {
                              if (state.indicator == 'UpdateProductQuantity') {
                              } else if (state.indicator ==
                                  'DeleteProductFromCart') {
                              } else {
                                var data = state.model as CartDetailsModel;
                                if (data.message != null) {
                                  return no_data_widget(context: context);
                                } else {
                                  return Column(
                                    children: [
                                      StreamBuilder<CartDetailsModel>(
                                        stream: shoppingCartBloc
                                            .cart_details_subject,
                                        builder: (context, snapshot) {
                                          if (snapshot.hasData) {
                                            if (snapshot.data.items.isEmpty) {
                                              return no_data_widget(
                                                  context: context);
                                            } else {

                                              return ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: snapshot
                                                      .data.items.length,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return singleEditCartItem(
                                                        context: context,
                                                        item: snapshot.data.items[index],
                                                        index: snapshot.data.items[index].itemId);
                                                  });
                                            }
                                          } else if (snapshot.hasError) {
                                            return Container(
                                              child: Text('${snapshot.error}'),
                                            );
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                            ;
                                          }
                                        },
                                      ),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .01),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .06),
                                      updateProductQtyCartButton(
                                          context: context),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .01),
                                    ],
                                  );
                                }
                              }
                            } else if (state is ErrorLoading) {
                              if (state.indicator == 'UpdateProductQuantity') {
                              } else if (state.indicator ==
                                  'DeleteProductFromCart') {
                              } else {
                                return Column(
                                  children: [
                                    responsiveSizedBox(
                                        context: context,
                                        percentageOfHeight: .01),
                                    no_data_widget(context: context),
                                  ],
                                );
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
                        editCartHeader(context: context, item_id: item_id),
                      ],
                    ),
                  ),
                ],
              ))),
    )));
  }

  updateProductQtyCartButton({
    BuildContext context,
  }) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: StaggerAnimation(
        //   titleButton: translator.translate("Send") ,
        buttonController: _loginButtonController.view,
        btn_height: width(context) * .13,
        //     image: "assets/icons/right-arrow.png",
        titleButton: item_id == null ? "Cancel" : "Update",
        //    isResetScreen:false,
        onTap: () {
          shoppingCartBloc.add(UpdateProductQuantityCartEvent(
              context: context,
              product_quantity: _dropDownValue,
              item_id: item_id));
        },
      ),
    );
  }

  singleEditCartItem(
      {BuildContext context,
      bool checkValue: false,
      cart_details_model.Items item,
      var index}) {
    List<String> qantity_numbers = [];


    for (int i = 1; i < 20; i++) {
      qantity_numbers.add(i.toString());
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Neumorphic(
                child: Container(
              width: width(context) * .9,
              decoration: BoxDecoration(
                  color: item_id == index ? greyColor : backGroundColor),
              child: Row(
                children: [
                  Container(
                    width: width(context) * .1,
                    height: isLandscape(context)
                        ? 2 * height(context) * .15
                        : height(context) * .15,
                    child: Center(
                      child: Checkbox(
                        value: item_id == item.itemId ? true : false,
                        activeColor: whiteColor,
                        checkColor: mainColor,
                        onChanged: (v) {
                          setState(() {
                            item_id = item.itemId;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: width(context) * .3,
                    height: isLandscape(context)
                        ? 2 * height(context) * .13
                        : height(context) * .13,
                    decoration: BoxDecoration(
                        color: backGroundColor,
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),
                            fit: BoxFit.cover)),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        right: width(context) * .02,
                        left: width(context) * .02),
                    width: width(context) * .5,
                    height: isLandscape(context)
                        ? 2 * height(context) * .15
                        : height(context) * .15,
                    child: Column(
                      children: [
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .01),
                        customDescriptionText(
                            context: context,
                            textColor: mainColor,
                            maxLines: 2,
                            text: item.name ?? '',
                            textAlign: TextAlign.start),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .01),
                        Row(
                          children: [
                            Container(
                              child: customDescriptionText(
                                  context: context,
                                  textColor: mainColor,
                                  text:
                                      "${MyApp.country_currency}${item.price}",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .01),
                        Row(
                          children: [
                            customDescriptionText(
                                context: context,
                                textColor: mainColor,
                                text: "${translator.translate("Qty")}:",
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
                                  border: Border.all(color: mainColor)),
                              child: DropdownButton(
                                hint: _dropDownValue == null
                                    ? Text(
                                        item.qty.toString(),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text(_dropDownValue,
                                        style: TextStyle(color: mainColor),
                                        textAlign: TextAlign.center),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.blue),
                                items: qantity_numbers.map(
                                  (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                    () {
                                      _dropDownValue = val;
                                    },
                                  );
                                },
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }
}
