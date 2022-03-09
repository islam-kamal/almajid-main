import 'package:almajidoud/Base/Shimmer/shimmer_notification.dart';
import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart';
import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart'
    as wishlist_model;
import 'package:almajidoud/Repository/WishListRepo/wishlist_repository.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';

import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:almajidoud/screens/WishList/add_wishlist_item_to_cart.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<String> gallery = new List<String>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var product_image;
  @override
  void initState() {
    wishlist_bloc.add(getAllWishList_click());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
                key: _scaffoldKey,
                backgroundColor: whiteColor,
                body: WillPopScope(
                  onWillPop: () {
                    translator.activeLanguageCode == 'ar'
                        ? customAnimatedPushNavigation(
                            context,
                            CustomCircleNavigationBar(
                              page_index: 4,
                            ))
                        : customAnimatedPushNavigation(
                            context,
                            CustomCircleNavigationBar(
                              page_index: 0,
                            ));
                  },
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      ScreenAppBar(
                        right_icon: 'cart',
                        category_name: translator.translate("WishList"),
                        screen: CustomCircleNavigationBar(
                          page_index: translator.activeLanguageCode == 'ar' ? 4 : 0,
                        ),
                      ),
                      Container(
                        height: height(context),
                        child: NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                leading: null,
                                expandedHeight: isLandscape(context) ? 2 * height(context) * .2 : height(context) * .2,
                                floating: false,
                                backgroundColor: whiteColor,
                                elevation: 0,
                                pinned: false,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: HomeSlider(gallery: StaticData.slider),
                                ),
                              )
                            ];
                          },
                          body: BlocBuilder(
                            bloc: wishlist_bloc,
                            builder: (context, state) {
                              if (state is Loading) {
                                if (state.indicator == 'get_fav') {
                                  return Center(
                                    child: ShimmerNotification(),
                                  );
                                } else if (state.indicator == 'remove_fav') {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state.indicator == 'add_cart') {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              } 
                              else if (state is Done) {
                                if (state.indicator == 'get_fav') {
                                  var data = state.model as GetAllWishListModel;
                                  if (data.items == null ||
                                      data.items.isEmpty) {
                                    return Container();
                                  } else {
                                    return StreamBuilder<GetAllWishListModel>(
                                      stream: wishlist_bloc.wishlist_subject,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data == null) {
                                            return Container();
                                          } else {
                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.itemsCount,
                                                itemBuilder: (context, index) {
                                                  snapshot.data.items[index].product.customAttributes.forEach((element) {
                                                    if (element.attributeCode == 'thumbnail') {
                                                      product_image = element.value;
                                                    }
                                                  });
                                                  String special_price;
                                                  var new_price, minimal_price;
                                                  DateTime startDate, endDate;
                                                  snapshot.data.items[index]
                                                      .product.customAttributes
                                                      .forEach((element) {
                                                    if (element.attributeCode ==
                                                        "thumbnail")
                                                      product_image =
                                                          element.value;
                                                    else if (element
                                                            .attributeCode ==
                                                        "special_from_date") {
                                                      startDate =
                                                          DateTime.parse(element
                                                              .value
                                                              .toString()
                                                              .substring(
                                                                  0, 10));
                                                    } else if (element
                                                            .attributeCode ==
                                                        "special_to_date") {
                                                      endDate = DateTime.parse(
                                                          element.value
                                                              .toString()
                                                              .substring(
                                                                  0, 10));
                                                    } else if (element
                                                            .attributeCode ==
                                                        'special_price') {
                                                      special_price =
                                                          element.value;
                                                    } else if (element
                                                            .attributeCode ==
                                                        'minimal_price') {
                                                      minimal_price =
                                                          element.value;
                                                    }
                                                  });
                                                  if (startDate == null ||
                                                      endDate == null) {
                                                    new_price = null;
                                                  } else {
                                                    if (StaticData
                                                            .isCurrentDateInRange(
                                                                startDate,
                                                                endDate) &&
                                                        double.parse(
                                                                special_price) <=
                                                            double.parse(
                                                                minimal_price) &&
                                                        double.parse(
                                                                    special_price)
                                                                .toStringAsFixed(
                                                                    2) !=
                                                            snapshot
                                                                .data
                                                                .items[index]
                                                                .product
                                                                .price) {
                                                      new_price = special_price;
                                                    } else if (double.parse(
                                                            special_price) >
                                                        double.parse(
                                                            minimal_price)) {
                                                      new_price = minimal_price;
                                                    } else {
                                                      new_price = null;
                                                    }
                                                  }

                                                  return InkWell(
                                                      onTap: () {
                                                        customAnimatedPushNavigation(
                                                            context,
                                                            ProductDetailsScreen(
                                                              product_id: snapshot.data.items[index].product.id,
                                                            ));
                                                      },
                                                      child: Stack(
                                                          children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
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
                                                                              height: isLandscape(context) ? 2 * height(context) * .14 : height(context) * .14,
                                                                              width: StaticData.get_width(context) * .3,
                                                                              decoration: BoxDecoration(color: backGroundColor,
                                                                                  borderRadius: BorderRadius.circular(15),
                                                                                  image: DecorationImage(image: NetworkImage("${Urls.BASE_URL}/pub/media/catalog/product/${product_image}"), fit: BoxFit.fill)),
                                                                            ),
                                                                            Directionality(
                                                                              textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.ltr : TextDirection.rtl,
                                                                              child: Container(
                                                                                padding: EdgeInsets.only(right: width(context) * .02, left: width(context) * .02),
                                                                                width: width(context) * .6,
                                                                                height: isLandscape(context) ? 2 * height(context) * .17 : height(context) * .17,
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: translator.activeLanguageCode == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    CustomWishList(
                                                                                      color: redColor,
                                                                                      product_id: snapshot.data.items[index].product.id,
                                                                                      qty: snapshot.data.items[index].qty,
                                                                                      context: context,
                                                                                      screen: WishListScreen(),
                                                                                      scafffoldKey: _scaffoldKey,
                                                                                      in_wishlist: true,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: EdgeInsets.only(right: 5, left: 5),
                                                                                      child: Align(
                                                                                        child: customDescriptionText(
                                                                                          context: context,
                                                                                          textColor: mainColor,
                                                                                          maxLines: 2,
                                                                                          text: snapshot.data.items[index].product.name,
                                                                                        ),
                                                                                        alignment: translator.activeLanguageCode == 'en' ? Alignment.centerLeft : Alignment.centerRight,
                                                                                      ),
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Row(
                                                                                          children: [
                                                                                            Wrap(
                                                                                              children: [
                                                                                                Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                  children: [
                                                                                                    MyText(
                                                                                                      text: "${new_price == null ? snapshot.data.items[index].product.price.toStringAsFixed(2) : double.parse(new_price)} ",
                                                                                                      size: StaticData.get_height(context) * .017,
                                                                                                      color: blackColor,
                                                                                                      maxLines: 2,
                                                                                                      weight: FontWeight.bold,
                                                                                                    ),
                                                                                                    MyText(
                                                                                                      text: " ${MyApp.country_currency}",
                                                                                                      size: StaticData.get_height(context) * .011,
                                                                                                      color: blackColor,
                                                                                                      maxLines: 2,
                                                                                                      weight: FontWeight.normal,
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            SizedBox(
                                                                                              width: width(context) * 0.03,
                                                                                            ),
                                                                                            new_price == null
                                                                                                ? Container()
                                                                                                : Text(
                                                                                                    "${snapshot.data.items[index].product.price} ${MyApp.country_currency}",
                                                                                                    style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: StaticData.get_height(context) * .011, color: old_price_color),
                                                                                                  ),
                                                                                          ],
                                                                                        ),
                                                                                        RatingBar.readOnly(
                                                                                          initialRating: 5.0,
                                                                                          maxRating: 5,
                                                                                          isHalfAllowed: true,
                                                                                          halfFilledIcon: Icons.star_half,
                                                                                          filledIcon: Icons.star,
                                                                                          emptyIcon: Icons.star_border,
                                                                                          size: StaticData.get_width(context) * 0.03,
                                                                                          filledColor: (snapshot.data.items[index].product.visibility.toDouble() >= 1) ? Colors.yellow.shade700 : Colors.yellow.shade700,
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    AddWishlistItemToCart(
                                                                                      product_id: snapshot.data.items[index].id,
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        decoration: BoxDecoration(color: backGroundColor))),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        positionedRemove(
                                                            itemId: data
                                                                .items[index]
                                                                .id),
                                                      ]));
                                                });
                                          }
                                        } else if (snapshot.hasError) {
                                          return Container(
                                            child: Text('${snapshot.error}'),
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      },
                                    );
                                  }
                                } else if (state.indicator == 'remove_fav') {
                                  wishlist_bloc.add(getAllWishList_click());
                                } else if (state.indicator == 'add_cart') {
                                  wishlist_bloc.add(getAllWishList_click());
                                  Flushbar(
                                    messageText: Container(
                                      child: Text(
                                        translator.translate(
                                            "product added suceesfully to cart"),
                                        maxLines: 2,
                                        textAlign: TextAlign.end,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: greenColor,
                                    duration: Duration(seconds: 2),
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                  ).show(_scaffoldKey.currentState.context);
                                }
                              } 
                              else if (state is ErrorLoading) {
                                if (state.indicator == 'get_fav') {
                                  return no_data_widget(context: context);
                                } else if (state.indicator == 'remove_fav') {
                                  return no_data_widget(context: context);
                                } else if (state.indicator == 'add_cart') {
                                  Flushbar(
                                    messageText: Container(
                                      child: Text(
                                        translator.translate(
                                            "The wishlist item does not exist."),
                                        maxLines: 2,
                                        textAlign: TextAlign.end,
                                        textDirection: TextDirection.rtl,
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                    flushbarPosition: FlushbarPosition.BOTTOM,
                                    backgroundColor: greenColor,
                                    duration: Duration(seconds: 2),
                                    flushbarStyle: FlushbarStyle.FLOATING,
                                  )..show(_scaffoldKey.currentState.context);
                                }
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                        ),
                      )
                    ],
                  )),
                ))));
  }

  void delete_cart_item({var wishlist_item_id}) async {
    final response = await wishListRepository.removeProudctToWishList(
      wishlist_item_id: wishlist_item_id,
    );
    if (response) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => super.widget));
    } else {}
  }

  Widget positionedRemove({int itemId}) {
    return Directionality(
        textDirection: translator.activeLanguageCode == 'ar'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: Positioned(
          top: width(context) * 0.15,
          right: translator.activeLanguageCode == 'ar' ? 0 : null,
          left: translator.activeLanguageCode == 'ar' ? null : 0,
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
                onPressed: () {
                  wishlist_bloc
                      .add(removeFromWishListEvent(wishlist_item_id: itemId));
                  //       delete_cart_item(wishlist_item_id: itemId),
                }),
          ),
        ));
  }
}
