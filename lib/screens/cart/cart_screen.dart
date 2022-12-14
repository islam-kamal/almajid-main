

import 'package:almajidoud/Base/Shimmer/shimmer_notification.dart';
import 'package:almajidoud/Bloc/ShippmentAddress_Bloc/shippment_address_bloc.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart'
as cart_details_model;
import 'package:almajidoud/Model/ShipmentAddressModel/client/address_model.dart';
import 'package:almajidoud/Provider/cart_provider.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Widgets/cart_screen_app_bar.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_widget.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/screens/checkout/widgets/bags_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  FocusNode fieldNode = FocusNode();
  var   tax , subtotal, grandtotal , shipping;
  var product_image;
  var edit_cart_status = false;
  SharedPreferences? sharedPreferences;

  late AnimationController _loginButtonController;
  bool isLoading = false;
  ShoppingCartBloc shoppingCartBloc = new ShoppingCartBloc();

  var discount_amount = '';

  @override
  void initState() {
    shoppingCartBloc.add(GetCartDetailsEvent());
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }
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
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: ()async=>false,
        child: NetworkIndicator(
            child: PageContainer(
                child: Directionality(
                    textDirection: MyApp.app_langauge  == 'ar'
                        ?TextDirection.rtl
                        : TextDirection.ltr,
                    child: Scaffold(
                      key: _scaffoldKey,
                      backgroundColor: whiteColor,
                      body: BlocListener<ShipmentAddressBloc,AppState>(
                          bloc: shipmentAddressBloc,
                          listener: (context,state) {
                            if(state is Loading){
                              if(state.indicator == "GetAllAddressesEvent"){
                                _playAnimation();
                              }

                            }
                            else if(state is Done){
                              if(state.indicator == "GetAllAddressesEvent"){
                                var data = state.general_model as List<AddressModel>;
                                _stopAnimation();
                                customAnimatedPushNavigation(context, CheckoutAddressScreen());
                              }
                            }
                            else if(state is ErrorLoading){
                              if(state.indicator == "GetAllAddressesEvent"){
                                _stopAnimation();
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
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            responsiveSizedBox(context: context, percentageOfHeight: .06),
                                            BlocBuilder(
                                              bloc: shoppingCartBloc,
                                              builder: (context, state) {
                                                if (state is Loading) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(top: width(context) * 0.4, ),
                                                    child: Center(
                                                      child: SpinKitFadingCube(
                                                        color: Theme.of(context).primaryColor,
                                                        size: width(context) * 0.1,
                                                      ),
                                                    ),
                                                  );
                                                }
                                                else if (state is Done) {
                                                  var data = state.model as CartDetailsModel;
                                                  if (data.message?.isEmpty != null ||
                                                      data.items == null || data.items!.length == 0) {
                                                    return no_data_widget(context: context);
                                                  } else {
                                                    data.totalSegments!.forEach((element) {
                                                      if(element.code == "discount"){
                                                        discount_amount = element.value.toString();
                                                      }else if(element.code == "tax"){
                                                        tax = element.value;
                                                      }else if(element.code == "subtotal"){
                                                        subtotal = element.value;
                                                      }else if(element.code == "grand_total"){
                                                        grandtotal = element.value;
                                                      }
                                                      else if(element.code == "shipping"){
                                                        shipping = element.value;
                                                      }
                                                    });
                                                    int? bags_number = 0;

                                                    data.items!.forEach((element) {
                                                      bags_number = bags_number! + int.parse(element.qty.toString());
                                                    });
                                                    return Column(
                                                      children: [
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount: data.items!.length,
                                                            scrollDirection: Axis.vertical,
                                                            itemBuilder: (context, index) {

                                                              return Stack(
                                                                children: [

                                                                  Column(children: [
                                                                    SizedBox(
                                                                      height: width(context) * .002,
                                                                    ),
                                                                    singleCartItem(
                                                                        context: context,
                                                                        item: data.items![index],
                                                                        image: "${Urls.BASE_URL}/media/catalog/product/cache/089af6965a318f5bf47750f284c40786"+data.items![index].extensionAttributes!.productImage
                                                                    ),
                                                                    SizedBox(
                                                                      height: width(context) * .002,
                                                                    ),
                                                                  ]),
                                                                  positionedRemove(
                                                                      itemId: data.items![index].itemId),
                                                                ],
                                                              );
                                                            }),
                                                        responsiveSizedBox(
                                                            context: context, percentageOfHeight: .02),
                                                        divider(context: context),
            // --------- Bags Number ----------
                                         MyApp.app_location == 'sa' || MyApp.app_location == 'kw' ?
                                               BagsWidget(
                                                      product_numbers: bags_number,
                                                            ) : Container(),
                                                        responsiveSizedBox(
                                                            context: context, percentageOfHeight: .01),
                                                        PromoCodeWidget(
                                                          scafffoldKey: _scaffoldKey,
                                                        ),
                                                        responsiveSizedBox(context: context, percentageOfHeight: .02),
                                                        divider(context: context),
                                                        responsiveSizedBox(
                                                            context: context, percentageOfHeight: .01),
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: "Sub Total",
                                                                  percentageOfHeight: .018),
                                                              Spacer(),
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: " ${subtotal} ${MyApp.country_currency} ",
                                                                  percentageOfHeight: .018,
                                                                  fontWeight: FontWeight.bold),
                                                            ],
                                                          ),
                                                        ),
                                                        discount_amount != ''?Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: "Discount",
                                                                  percentageOfHeight: .018),
                                                              Spacer(),
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: " ${discount_amount} ${MyApp.country_currency} ",
                                                                  percentageOfHeight: .018,
                                                                  fontWeight: FontWeight.bold),
                                                            ],
                                                          ),
                                                        ):Container(),

                                                        data.items![0].taxPercent == 0?   Container()
                                                            :    Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: "TAX",
                                                                  percentageOfHeight: .018),
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: " (${data.items![0].taxPercent}%) ",
                                                                  percentageOfHeight: .018),
                                                              Spacer(),
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: " ${tax} ${MyApp.country_currency} ",
                                                                  percentageOfHeight: .018,
                                                                  fontWeight: FontWeight.bold),
                                                            ],
                                                          ),
                                                        ),

                                                        shipping == 0 ? Container() :        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text:   "Shipping",
                                                                  percentageOfHeight: .022),
                                                              Spacer(),
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: " ${shipping} ${MyApp.country_currency} ",
                                                                  percentageOfHeight: .022,
                                                                  fontWeight: FontWeight.bold),
                                                            ],
                                                          ),
                                                        ),

                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 2.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: "Grand Total",
                                                                  percentageOfHeight: .022),
                                                              Spacer(),
                                                              customDescriptionText(
                                                                  context: context,
                                                                  textColor: mainColor,
                                                                  text: " ${grandtotal} ${MyApp.country_currency} ",
                                                                  percentageOfHeight: .022,
                                                                  fontWeight: FontWeight.bold),
                                                            ],
                                                          ),
                                                        ),

                                                        responsiveSizedBox(context: context, percentageOfHeight: .04),
                                                        proceedToCheckoutButton(context: context),
                                                        responsiveSizedBox(
                                                            context: context, percentageOfHeight: .01),
                                                      ],
                                                    );
                                                  }
                                                }
                                                else if (state is ErrorLoading) {
                                                  if (state.indicator == 'GetCartDetails') {
                                                    if (state.message == "The consumer isn't authorized to access %resources.") {
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
                                                }
                                                else {
                                                  return Padding(
                                                    padding: EdgeInsets.only(top:  width(context ) * 0.3),
                                                    child: SpinKitFadingCube(
                                                      color: Theme.of(context).primaryColor,
                                                      size: width(context) * 0.1,
                                                    ),

                                                  );
                                                }

                                                return no_data_widget(context: context);
                                              },
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  Container(
                                    height: height(context),
                                    width: width(context),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CartScreenAppBar(
                                          onTapCategoryDrawer: () {
                                            _scaffoldKey.currentState!.openDrawer();
                                          },
                                          right_icon: 'cart',
                                          screen: CustomCircleNavigationBar(
                                            page_index: 2,
                                          ),
                                          category_name: translator.translate("Cart"),
                                        ),
                                      ],
                                    ),
                                  ) ,
                                ],
                              ))
                      ),

                      drawer: SettingsDrawer(
                        node: fieldNode,
                      ),
                    )
                )        ))
    );
  }

  proceedToCheckoutButton({BuildContext? context}) {
    return StaggerAnimation(
      titleButton: translator.translate("Proceed to checkout"),
      buttonController: _loginButtonController,
      btn_width: width(context) * .8,
      checkout_color: true,
      onTap: () {
        _playAnimation();
        if(StaticData.vistor_value == 'visitor' ){
          customAnimatedPushNavigation(context!, CheckoutAddressScreen());

        }else{
          shipmentAddressBloc.add(
              GetAllAddressesEvent(context: context)
          );
        }
        _stopAnimation();
      },
    );
  }

  void delete_cart_item({var cart_item_id}) async {
    final response = await cartRepository.delete_product_from_cart(
      item_id: cart_item_id,
    );
    if (response!) {
      var cart_provider = Provider.of<CartProvider>(context,listen:false);

      cart_provider.update_cart_grand_total (
          grand: cart_provider.cart_grand_total! - 50
      );
      shoppingCartBloc.add(GetCartDetailsEvent());
    } else {
    }
  }

  singleCartItem({BuildContext? context, cart_details_model.Items? item,String? image}) {
    var qty;
    List<String> qantity_numbers = [];
    for (int i = 1; i < 20; i++) {
      qantity_numbers.add(i.toString());
    }
    qty =item!.qty;
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
                            item.extensionAttributes?.minimalPrice == null
                                || item.extensionAttributes?.minimalPrice == '0.0000'?           Container(
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
                                          image??   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),
                                      fit: BoxFit.fill)),
                            ) : Stack(
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
                                             image??   "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),
                                         fit: BoxFit.fill)),
                               ),
                               positionedPercentage(
                                 percentage: (1 -
                                     (double.parse(item.extensionAttributes?.minimalPrice ) /
                                         double.parse(item.rowTotalInclTax.toString()))) *
                                     100

                               )
                             ],
                           ),
                            Directionality(
                                textDirection:
                                translator.activeLanguageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: width(context) * .02,
                                      left: width(context) * .02),
                                  width: width(context) * .6,
                                  //   height: isLandscape(context) ? 2 * height(context) * .17 : height(context) * .17,
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
                                          textAlign: translator.activeLanguageCode == 'ar' ? TextAlign.end : TextAlign.start),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .02),
                                      Row(
                                        children: [
                                      item.extensionAttributes?.minimalPrice == null
                                      || item.extensionAttributes?.minimalPrice == '0.0000'?    Container(
                                            child: customDescriptionText(
                                                context: context,
                                                textColor: mainColor,
                                                text:
                                                " ${item.rowTotalInclTax} ${MyApp.country_currency}",
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.bold),
                                          )

                                          : Row(
                                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Wrap(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                                children: [
                                                  MyText(
                                                    text:
                                                    "${item.extensionAttributes?.minimalPrice}",
                                                    size: StaticData.get_height(
                                                        context!) *
                                                        .017,
                                                    color:
                                                    blackColor,
                                                    maxLines:
                                                    2,
                                                    weight: FontWeight
                                                        .bold,
                                                  ),
                                                  SizedBox(width:5),
                                                  MyText(
                                                    text:
                                                    " ${MyApp.country_currency}",
                                                    size: StaticData.get_height(
                                                        context) *
                                                        .011,
                                                    color:
                                                    blackColor,
                                                    maxLines:
                                                    2,
                                                    weight: FontWeight
                                                        .normal,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: width(
                                                context) *
                                                0.03,
                                          ),
                                         Text(
                                           " ${item.rowTotalInclTax} ${MyApp.country_currency}",
                                            style: TextStyle(
                                                decoration:
                                                TextDecoration
                                                    .lineThrough,
                                                fontSize:
                                                StaticData.get_height(context) *
                                                    .016,
                                                color:
                                                old_price_color),
                                          ),
                                        ],
                                      ),

                                        ],
                                      ),
                                      responsiveSizedBox(context: context, percentageOfHeight: .01),
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
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  MaterialButton(
                                                    height: 5,
                                                    minWidth:
                                                    StaticData.get_width(context!) *
                                                        0.15,
                                                    onPressed: () async {
                                                      if (qty == 20) {
                                                        errorDialog(
                                                          context: context,
                                                          text: translator.translate("You cannot exceed the available quantity." ),
                                                        );
                                                      }
                                                      else {
                                                        setState(() {
                                                          qty++;
                                                        });
                                                        final response =
                                                        await cartRepository.update_product_quantity_cart(
                                                            item_id: item.itemId, product_quantity: qty);
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
                                                                  TextDirection.rtl,
                                                                  style: TextStyle(
                                                                      color:
                                                                      whiteColor),
                                                                ),
                                                              ],
                                                            ),
                                                            flushbarPosition:
                                                            FlushbarPosition.BOTTOM,
                                                            backgroundColor: redColor,
                                                            flushbarStyle:
                                                            FlushbarStyle.FLOATING,
                                                            duration:
                                                            Duration(seconds: 3),
                                                          )..show(_scaffoldKey
                                                              .currentState!.context);
                                                        } else {
                                                          shoppingCartBloc.add(GetCartDetailsEvent());
                                                        }
                                                      }
                                                    },
                                                    color: whiteColor,
                                                    textColor: greyColor,
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 18,
                                                      color: blackColor,
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    shape: CircleBorder(),
                                                  ),
                                                  Text(
                                                    '${qty}',
                                                    style: TextStyle(
                                                      color: mainColor,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                    ),
                                                  ),

                                                  MaterialButton(
                                                    height: 5,
                                                    minWidth: StaticData.get_width(context) * 0.15,

                                                    onPressed: qty <= 1 ? (){} :() async {
                                                      setState(() {
                                                        qty--;
                                                      });

                                                      final response =
                                                      await cartRepository.update_product_quantity_cart(
                                                          item_id: item.itemId, product_quantity: qty);
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
                                                                TextDirection.rtl,
                                                                style: TextStyle(
                                                                    color:
                                                                    whiteColor),
                                                              ),
                                                            ],
                                                          ),
                                                          flushbarPosition:
                                                          FlushbarPosition.BOTTOM,
                                                          backgroundColor: redColor,
                                                          flushbarStyle:
                                                          FlushbarStyle.FLOATING,
                                                          duration:
                                                          Duration(seconds: 3),
                                                        )..show(_scaffoldKey
                                                            .currentState!.context);
                                                      } else {
                                                        shoppingCartBloc.add(GetCartDetailsEvent());
                                                      }

                                                    },
                                                    color: qty <= 1 ? greyColor : whiteColor,
                                                    textColor: Colors.white,
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 18,
                                                      color: blackColor,
                                                    ),
                                                    padding: EdgeInsets.all(5),
                                                    shape: CircleBorder(),
                                                  ),
                                                ],
                                              )
                                          )



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

  Widget positionedRemove({int? itemId}) {
    return Directionality(
        textDirection:
        translator.activeLanguageCode == 'ar'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child:  Positioned(
          top: width(context) * 0.15,
          left:translator.activeLanguageCode == 'ar'
              ?  0 : null,
          right:translator.activeLanguageCode == 'ar'
              ?  null : 0,
          child: Container(
            height: 30,
            width: 30,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                padding: EdgeInsets.all(0.0),
                color: mainColor,
                child: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () => {

                  delete_cart_item(cart_item_id: itemId),
                }),
          ),
        )  );
  }



  Widget positionedPercentage({var percentage}) {
    return Directionality(
        textDirection:
        translator.activeLanguageCode == 'ar'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child:  Positioned(
            top: width(context) * 0.05,
            right:translator.activeLanguageCode == 'ar'
                ?  0 : null,
            left:translator.activeLanguageCode == 'ar'
                ?  null : 0,
            child: Container(
                width: width(context) * 0.1,
                decoration: BoxDecoration(
                    color: greyColor,
                    borderRadius: BorderRadius.circular(5)),
                child: MyText(
                  text: "${percentage.round()} %",
                )
            ),
        )  );
  }

}
