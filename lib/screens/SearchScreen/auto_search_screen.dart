import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
    as product_model;
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_bar/rating_bar.dart';

class AutoSearchScreen extends StatefulWidget {
  @override
  _AutoSearchScreenState createState() => _AutoSearchScreenState();
}

class _AutoSearchScreenState extends State<AutoSearchScreen> {
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey();
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    search_bloc.drainStream();
    search_bloc.add(SearchProductsEvent(search_text: ''));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
      key: scaffold_key,
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          ScreenAppBar(
            right_icon: 'cart',
            category_name: translator.translate("Search Result"),
            screen: CustomCircleNavigationBar(),
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
                      background: HomeSlider(gallery: StaticData.slider),
                    ),
                  )
                ];
              },
              body: Container(
                child: BlocBuilder(
                  bloc: search_bloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(
                        child: CircularProgressIndicator(
                        ),
                      );
                    } else if (state is Done) {
                      var data = state.model as ProductModel;
                      print("data : ${data}");

                      if (data.items == null || data.items.isEmpty) {
                        return no_data_widget(context: context);
                      } else {
                        return StreamBuilder<ProductModel>(
                          stream: search_bloc.search_products_subject,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == null) {
                                return no_data_widget(context: context);
                              } else {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.items.length,
                                    itemBuilder: (context, index) {
                                      List<String> gallery = new List<String>();
                                      snapshot
                                          .data.items[index].mediaGalleryEntries
                                          .forEach((element) {
                                        gallery.add(ProductImages
                                            .getProductImageUrlByName(
                                                imageName: element.file));
                                      });
                                      if (index >= snapshot.data.items.length) {
                                        return MyLoader(25, 25);
                                      } else {
                                        return snapshot.data.items[index] ==
                                                null
                                            ? Container()
                                            : snapshot.data.items[index].status == 1? InkWell(
                                            onTap: (){
                                          customAnimatedPushNavigation(context,ProductDetailsScreen(
                                            product_id: snapshot.data.items[index].id,
                                          )
                                          );
                                        },
                                      child:Directionality(
                                                textDirection: translator
                                                            .activeLanguageCode ==
                                                        'ar'
                                                    ? TextDirection.rtl
                                                    : TextDirection.ltr,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        responsiveSizedBox(
                                                            context: context,
                                                            percentageOfHeight:
                                                                .02),
                                                        Neumorphic(
                                                            child: Container(
                                                                width: width(
                                                                        context) *
                                                                    .95,
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          right:
                                                                              3,
                                                                          left:
                                                                              3),
                                                                      width:
                                                                          width(context) *
                                                                              .3,
                                                                      height: isLandscape(
                                                                              context)
                                                                          ? 2 *
                                                                              height(
                                                                                  context) *
                                                                              .15
                                                                          : height(context) *
                                                                              .15,
                                                                      decoration: BoxDecoration(
                                                                          color: backGroundColor,
                                                                          borderRadius: BorderRadius.circular(15),
                                                                          image: DecorationImage(
                                                                              image: NetworkImage(
                                                                                snapshot.data.items[index].customAttributes[0].value,
                                                                              ),
                                                                              fit: BoxFit.fill)),
                                                                    ),
                                                                    Directionality(
                                                                        textDirection: translator.activeLanguageCode ==
                                                                                'ar'
                                                                            ? TextDirection.ltr
                                                                            : TextDirection.rtl,
                                                                        child: Container(
                                                                            padding: EdgeInsets.only(right: width(context) * .02, left: width(context) * .02),
                                                                            width: width(context) * .6,
                                                                            alignment: Alignment.center,
                                                                            height: isLandscape(context) ? 2 * height(context) * .17 : height(context) * .17,
                                                                            child: SingleChildScrollView(
                                                                              child: Column(
                                                                                crossAxisAlignment: translator.activeLanguageCode == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                                                children: [
                                                                                  snapshot.data.items[index].extensionAttributes.stockItem.isInStock ?   CustomWishList(
                                                                                    color: redColor,
                                                                                    product_id: snapshot.data.items[index].id,
                                                                                    qty: snapshot.data.items[index].extensionAttributes.stockItem.qty,
                                                                                    context: context,
                                                                                    screen: AutoSearchScreen(),
                                                                                  ) : Container(),
                                                                                  responsiveSizedBox(context: context, percentageOfHeight: .01),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.only(right: 5, left: 5),
                                                                                    child: customDescriptionText(context: context, textColor: mainColor, maxLines: 2, text: snapshot.data.items[index].name, textAlign: translator.activeLanguageCode == 'ar' ? TextAlign.start : TextAlign.end),
                                                                                  ),
                                                                                  responsiveSizedBox(context: context, percentageOfHeight: .01),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        child: customDescriptionText(context: context, textColor: mainColor, text: "${snapshot.data.items[index].price} ${MyApp.country_currency}", textAlign: TextAlign.start, fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      RatingBar.readOnly(
                                                                                        initialRating: 5.0,
                                                                                        maxRating: 5,
                                                                                        isHalfAllowed: true,
                                                                                        halfFilledIcon: Icons.star_half,
                                                                                        filledIcon: Icons.star,
                                                                                        emptyIcon: Icons.star_border,
                                                                                        size: StaticData.get_width(context) * 0.03,
                                                                                        filledColor: snapshot.data.items[index].extensionAttributes.reviews.isEmpty ? greyColor : Colors.yellow.shade700,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                  responsiveSizedBox(context: context, percentageOfHeight: .01),
                                                                                  BlocBuilder<ShoppingCartBloc, AppState>(
                                                                                    bloc: shoppingCartBloc,
                                                                                    builder: (context, state) {
                                                                                      if (state is ProductLoading && state.indicator == 'search_add_to_cart') {
                                                                                        if (snapshot.data.items[index].sku == state.sku) {
                                                                                          _isLoading = true;
                                                                                        } else {
                                                                                          _isLoading = false;
                                                                                        }
                                                                                      } else if (state is ErrorLoadingProduct && state.indicator == 'search_add_to_cart' && snapshot.data.items[index].sku == state.sku) {
                                                                                        _isLoading = false;
                                                                                        var data = state.model as AddCartModel;
                                                                                        Fluttertoast.showToast(msg: '${data.message}', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP, timeInSecForIosWeb: 1, backgroundColor: Colors.redAccent, textColor: Colors.white, fontSize: 16.0);
                                                                                        state = null;
                                                                                      } else if (state is DoneProductAdded && state.indicator == 'search_add_to_cart' && snapshot.data.items[index].sku == state.sku) {
                                                                                        _isLoading = false;
                                                                                        Fluttertoast.showToast(msg: 'product added successfully to cart', toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.TOP, timeInSecForIosWeb: 1, backgroundColor: Colors.green, textColor: Colors.white, fontSize: 16.0);
                                                                                      }

                                                                                      return _isLoading
                                                                                          ? CircularProgressIndicator(
                                                                                      )
                                                                                          :  snapshot.data.items[index].extensionAttributes.stockItem.isInStock ? InkWell(
                                                                                              onTap: () {
                                                                                                      shoppingCartBloc.add(AddProductToCartEvent(context: context, product_quantity: snapshot.data.items[index].extensionAttributes.stockItem.qty, product_sku: snapshot.data.items[index].sku, indictor: 'search_add_to_cart'));
                                                                                                    },
                                                                                              child: Container(
                                                                                                width: width(context) * .4,
                                                                                                height: isLandscape(context) ? 2 * height(context) * .035 : height(context) * .035,
                                                                                                decoration: BoxDecoration(border: Border.all(color: mainColor)),
                                                                                                child: Row(
                                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                                  children: [
                                                                                                    Icon(Icons.shopping_cart_outlined),
                                                                                                    SizedBox(width: width(context) * .02),
                                                                                                    customDescriptionText(context: context, textColor: mainColor, text: "Add to cart", textAlign: TextAlign.start),
                                                                                                  ],
                                                                                                ),
                                                                                              ),
                                                                                            ) : Container(
                                                                                        height: width(context) * .08,
                                                                                        width: width(context) * .45,
                                                                                        padding: EdgeInsets.all(4),
                                                                                        decoration: BoxDecoration(
                                                                                          border: Border.all(color: greyColor),
                                                                                        ),
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(8)),
                                                                                          child:  Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              customDescriptionText(
                                                                                                  context: context,
                                                                                                  text: translator.translate("Out Of Stock"),                                                                                                  percentageOfHeight:  0.017,
                                                                                                  textColor: mainColor) ,
                                                                                            ],),
                                                                                        ) ,
                                                                                      );
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ))),
                                                                  ],
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color:
                                                                            backGroundColor))),
                                                      ],
                                                    ),
                                                  ],
                                                )

                                      ) ) : null;
                                      }
                                    });
                              }
                            } else if (snapshot.hasError) {
                              return Container(
                                child: Text('${snapshot.error}'),
                              );
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                ),
                              );
                              ;
                            }
                          },
                        );
                      }
                    } else if (state is ErrorLoading) {
                      print("33333333333");
                      return Container();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                        ),
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

class MyLoader extends StatelessWidget {
  final double width;
  final double height;

  MyLoader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
