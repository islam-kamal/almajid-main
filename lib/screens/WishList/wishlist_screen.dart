import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/WishList_Bloc/wishlist_bloc.dart';
import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart';
import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart'
    as wishlist_model;
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';

import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class WishListScreen extends StatefulWidget {
  @override
  _WishListScreenState createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  List<String> gallery = new List<String>();

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
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          ScreenAppBar(
            right_icon: 'cart',
            category_name: translator.translate("WishList"),
            screen: CustomCircleNavigationBar(
              page_index: 4,
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
                    expandedHeight: isLandscape(context)
                        ? 2 * height(context) * .2
                        : height(context) * .2,
                    floating: false,
                    backgroundColor: whiteColor,
                    elevation: 0,
                    pinned: false,
                    flexibleSpace: FlexibleSpaceBar(
                      background: HomeSlider(gallery: StaticData.images),
                    ),
                  )
                ];
              },
              body: Container(
                // height: isLandscape(context) ? 2 * height(context) * .65 : height(context) * .65,
                child: BlocBuilder(
                  bloc: wishlist_bloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is Done) {
                      if (state.indicator == 'get_fav') {
                        var data = state.model as GetAllWishListModel;
                        if (data.items == null || data.items.isEmpty) {
                          return Container();
                        } else {
                          return StreamBuilder<GetAllWishListModel>(
                            stream: wishlist_bloc.wishlist_subject,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                if (snapshot.data == null) {
                                  return Container();
                                } else {
                                  print("length : ${snapshot.data.itemsCount}");

                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: snapshot.data.itemsCount,
                                      itemBuilder: (context, index) {
                                        print(
                                            "image : ${Urls.BASE_URL}/pub/media/catalog/product/${snapshot.data.items[index].product.customAttributes[1].value}");
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Column(
                                              children: [
                                                responsiveSizedBox(
                                                    context: context,
                                                    percentageOfHeight: .02),
                                                Neumorphic(
                                                    child: Container(
                                                        width: width(context) *
                                                            .95,
                                                        child: Row(
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right: 3,
                                                                      left: 3),
                                                              height: StaticData
                                                                      .get_height(
                                                                          context) *
                                                                  .17,
                                                              width: StaticData
                                                                      .get_width(
                                                                          context) *
                                                                  .3,
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      backGroundColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  image: DecorationImage(
                                                                      image: NetworkImage(
                                                                          "${Urls.BASE_URL}/pub/media/catalog/product/${snapshot.data.items[index].product.customAttributes[1].value}"),
                                                                      fit: BoxFit
                                                                          .fill)),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.only(right: width(context) * .02, left: width(context) * .02),
                                                              width: width(context) * .6,
                                                              height: isLandscape(context) ? 2 * height(context) * .18: height(context) * .18,
                                                              child: Column(
                                                                children: [
                                                                  CustomWishList(
                                                                    color: redColor,
                                                                    product_id: snapshot.data.items[index].id,
                                                                    qty: snapshot.data.items[index].qty,
                                                                    context: context,
                                                                    screen: WishListScreen(),
                                                                  ),
                                                                  responsiveSizedBox(
                                                                      context: context, percentageOfHeight: .01),
                                                                  customDescriptionText(
                                                                      context:
                                                                          context,
                                                                      textColor:
                                                                          mainColor,
                                                                      maxLines:
                                                                          2,
                                                                      text: snapshot
                                                                          .data
                                                                          .items[
                                                                              index]
                                                                          .product
                                                                          .name,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .start),
                                                                  responsiveSizedBox(
                                                                      context:
                                                                          context,
                                                                      percentageOfHeight:
                                                                          .01),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        child: customDescriptionText(
                                                                            context:
                                                                                context,
                                                                            textColor:
                                                                                mainColor,
                                                                            text:
                                                                                "${snapshot.data.items[index].product.price} ${MyApp.country_currency}",
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            fontWeight: FontWeight.bold),
                                                                      ),
                                                                      RatingBar
                                                                          .readOnly(
                                                                        initialRating:
                                                                            5.0,
                                                                        maxRating:
                                                                            5,
                                                                        isHalfAllowed:
                                                                            true,
                                                                        halfFilledIcon:
                                                                            Icons.star_half,
                                                                        filledIcon:
                                                                            Icons.star,
                                                                        emptyIcon:
                                                                            Icons.star_border,
                                                                        size: StaticData.get_width(context) *
                                                                            0.03,
                                                                        filledColor: (snapshot.data.items[index].product.visibility.toDouble() >=
                                                                                1)
                                                                            ? Colors.yellow.shade700
                                                                            : Colors.yellow.shade700,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  responsiveSizedBox(
                                                                      context:
                                                                          context,
                                                                      percentageOfHeight:
                                                                          .02),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          print(
                                                                              "------- id ------- : ${snapshot.data.items[index].id}");
                                                                          wishlist_bloc.add(AddToCarFromWishListEvent(
                                                                              context: context,
                                                                              qty: snapshot.data.items[index].qty,
                                                                              wishlist_product_id: snapshot.data.items[index].id));
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              width(context) * .4,
                                                                          height: isLandscape(context)
                                                                              ? 2 * height(context) * .035
                                                                              : height(context) * .035,
                                                                          decoration:
                                                                              BoxDecoration(border: Border.all(color: mainColor)),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(Icons.shopping_cart_outlined),
                                                                              SizedBox(width: width(context) * .02),
                                                                              customDescriptionText(context: context, textColor: mainColor, text: "Add to cart", textAlign: TextAlign.start),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {
                                                                          final RenderBox
                                                                              box =
                                                                              context.findRenderObject();
                                                                          Share.share(
                                                                              '${snapshot.data.items[index].product.name ?? ''}',
                                                                              subject: 'Welcome To Amajed Oud',
                                                                              sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
                                                                        },
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              width(context) * .15,
                                                                          height: isLandscape(context)
                                                                              ? 2 * height(context) * .035
                                                                              : height(context) * .035,
                                                                          decoration:
                                                                              BoxDecoration(border: Border.all(color: mainColor)),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            children: [
                                                                              Icon(Icons.share_outlined)
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                backGroundColor))),
                                              ],
                                            ),
                                          ],
                                        );
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
                                ;
                              }
                            },
                          );
                        }
                      } else if (state.indicator == 'remove_fav') {
                      } else if (state.indicator == 'add_cart') {
                        customAnimatedPushNavigation(
                            context,
                            CustomCircleNavigationBar(
                              page_index: 0,
                            ));
                      }
                    } else if (state is ErrorLoading) {
                      if (state.indicator == 'get_fav') {
                        return no_data_widget(context: context);
                      } else if (state.indicator == 'remove_fav') {
                      } else if (state.indicator == 'add_cart') {}
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          )
        ],
      )),
    )));
  }
}
