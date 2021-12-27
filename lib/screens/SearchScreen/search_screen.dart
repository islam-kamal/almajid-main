import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/Products/product_slider.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  GlobalKey<ScaffoldState> scaffold_key = GlobalKey();

  @override
  void initState() {
    super.initState();
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
                                  background:     HomeSlider(
                                      gallery:StaticData.images
                                  ),
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
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is Done) {
                                  var data = state.model as SearchModel;
                                  print("data : ${data}");

                                  if (data.items == null || data.items.isEmpty) {
                                    print("11111111111");
                                    return no_data_widget(
                                        context: context
                                    );
                                  } else {
                                    return StreamBuilder<SearchModel>(
                                      stream: search_bloc.search_products_subject,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data == null) {
                                            print("222222");
                                            return no_data_widget(
                                              context: context
                                            );
                                          } else {
                                            print("length : ${snapshot.data.items.length}");

                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.items.length,
                                                itemBuilder: (context, index) {
                                                  List<String> gallery = new List<String>();
                                                  snapshot.data.items[index].mediaGalleryEntries.forEach((element) {
                                                    gallery
                                                        .add(ProductImages.getProductImageUrlByName(imageName: element.file));
                                                  });
                                                  if (index >= snapshot.data.items.length) {
                                                    return MyLoader(25, 25);
                                                  } else {
                                                    return snapshot.data.items[index] == null
                                                      ? Container()
                                                      :   Directionality(
                                                      textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr ,
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
                                                                            margin: EdgeInsets.only(right: 3,left: 3),
                                                                            width: width(context) * .3,
                                                                            height: isLandscape(context)
                                                                                ? 2 * height(context) * .15
                                                                                : height(context) * .15,
                                                                            decoration: BoxDecoration(
                                                                                color: backGroundColor,
                                                                                borderRadius: BorderRadius.circular(15),
                                                                                image: DecorationImage(
                                                                                    image: NetworkImage(
                                                                                        snapshot.data.items[index].customAttributes[0].value,
                                                                                    ),
                                                                                    fit: BoxFit.fill)),
                                                                            ) ,

                                                                          Directionality(
                                                                              textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                                                                              child: Container(
                                                                            padding: EdgeInsets.only(
                                                                                right: width(context) * .02,
                                                                                left: width(context) * .02),
                                                                            width: width(context) * .6,
                                                                            height: isLandscape(context)
                                                                                ? 2 * height(context) * .17
                                                                                : height(context) * .17,
                                                                            child: SingleChildScrollView(
                                                                              child: Column(
                                                                                crossAxisAlignment: translator.activeLanguageCode == 'ar' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomWishList(
                                                                                    color: redColor,
                                                                                    product_id: snapshot.data.items[index].id,
                                                                                    qty: snapshot.data.items[index].extensionAttributes.stockItem.qty,
                                                                                    context: context,
                                                                                    screen: SearchScreen(),

                                                                                  ),
                                                                                  responsiveSizedBox(
                                                                                      context: context, percentageOfHeight: .01),
                                                                                  Padding(padding: EdgeInsets.only(right: 5,left: 5),
                                                                                    child:  customDescriptionText(
                                                                                        context: context,
                                                                                        textColor: mainColor,
                                                                                        maxLines: 2,
                                                                                        text: snapshot.data.items[index].name,
                                                                                        textAlign: translator.activeLanguageCode == 'ar' ? TextAlign.start :TextAlign.end),),
                                                                                  responsiveSizedBox(
                                                                                      context: context, percentageOfHeight: .01),
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      Container(
                                                                                        child: customDescriptionText(
                                                                                            context: context,
                                                                                            textColor: mainColor,
                                                                                            text: "${snapshot.data.items[index].price} ${MyApp.country_currency}",
                                                                                            textAlign: TextAlign.start,
                                                                                            fontWeight: FontWeight.bold),
                                                                                      ),
                                                                                      RatingBar.readOnly(
                                                                                        initialRating:
                                                                                        5.0,
                                                                                        maxRating: 5,
                                                                                        isHalfAllowed: true,
                                                                                        halfFilledIcon: Icons.star_half,
                                                                                        filledIcon: Icons.star,
                                                                                        emptyIcon: Icons.star_border,
                                                                                        size: StaticData.get_width(context) * 0.03,
                                                                                        filledColor:
                                                                                        (snapshot.data.items[index].visibility.toDouble() >= 1)
                                                                                            ? Colors.yellow.shade700
                                                                                            : Colors.yellow.shade700,
                                                                                      ),


                                                                                    ],
                                                                                  ),
                                                                                  responsiveSizedBox(
                                                                                      context: context, percentageOfHeight: .01),
                                                                                  Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                    children: [
                                                                                      InkWell(
                                                                                        onTap:  snapshot.data.items[index].extensionAttributes.stockItem.isInStock == false ? (){
                                                                                          Flushbar(messageText: Container(width: StaticData.get_width(context) * 0.7,
                                                                                            child:
                                                                                            Wrap(
                                                                                              children: [
                                                                                                Text(
                                                                                                  'There is no quantity of this product in stock',
                                                                                                  textDirection: TextDirection.rtl,
                                                                                                  style: TextStyle(color: whiteColor),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                            flushbarPosition:
                                                                                            FlushbarPosition.BOTTOM,
                                                                                            backgroundColor:
                                                                                            redColor,
                                                                                            flushbarStyle:
                                                                                            FlushbarStyle.FLOATING,
                                                                                            duration:
                                                                                            Duration(seconds: 3),
                                                                                          )..show(scaffold_key
                                                                                              .currentState
                                                                                              .context);
                                                                                        } : () {
                                                                                          shoppingCartBloc.add(AddProductToCartEvent(
                                                                                              context: context,
                                                                                              product_quantity: snapshot.data.items[index].extensionAttributes.stockItem.qty,
                                                                                              product_sku: snapshot.data.items[index].sku));
                                                                                        },
                                                                                        child:  Container(
                                                                                          width: width(context) * .4,
                                                                                          height: isLandscape(context)
                                                                                              ? 2 * height(context) * .035
                                                                                              : height(context) * .035,
                                                                                          decoration: BoxDecoration(
                                                                                              border: Border.all(color: mainColor)),
                                                                                          child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(Icons.shopping_cart_outlined),
                                                                                              SizedBox(width: width(context) * .02),
                                                                                              customDescriptionText(
                                                                                                  context: context,
                                                                                                  textColor: mainColor,
                                                                                                  text: "Add to cart",
                                                                                                  textAlign: TextAlign.start),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          final RenderBox box =
                                                                                          context.findRenderObject();
                                                                                          Share.share('${snapshot.data.items[index].name}',
                                                                                              subject: 'Welcome To Amajed Oud',
                                                                                              sharePositionOrigin:
                                                                                              box.localToGlobal(Offset.zero) &
                                                                                              box.size);
                                                                                        },
                                                                                        child: Container(
                                                                                          width: width(context) * .15,
                                                                                          height: isLandscape(context)
                                                                                              ? 2 * height(context) * .035
                                                                                              : height(context) * .035,
                                                                                          decoration: BoxDecoration(
                                                                                              border: Border.all(color: mainColor)),
                                                                                          child: Row(
                                                                                            mainAxisAlignment:
                                                                                            MainAxisAlignment.spaceAround,
                                                                                            children: [Icon(Icons.share_outlined)],
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            )
                                                                          )),
                                                                        ],
                                                                      ),
                                                                      decoration: BoxDecoration(color: backGroundColor))),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                /*      Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          responsiveSizedBox(context: context, percentageOfHeight: .02),
                                                          Neumorphic(
                                                              child: Container(
                                                                  width: width(context) * .9,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        height: StaticData.get_height(context) * .23,
                                                                        width: StaticData.get_width(context) * .3,
                                                                        child: MyProductSlider(
                                                                          data: gallery,
                                                                          viewportFraction: 1.0,
                                                                          aspect_ratio: 3.0,
                                                                          border_radius: 5.0,
                                                                          indicator: false,
                                                                          motion: false,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            right: width(context) * .02,
                                                                            left: width(context) * .02),
                                                                        width: width(context) * .6,
                                                                        height: isLandscape(context)
                                                                            ? 2 * height(context) * .23
                                                                            : height(context) * .23,
                                                                        child: Column(
                                                                          children: [
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .01),
                                                                            CustomWishList(
                                                                              color: redColor,
                                                                              favourite_status:
                                                                              snapshot.data.items[index].status == 0 ? false : true,
                                                                              product_id: snapshot.data.items[index].id,
                                                                            ),
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .01),
                                                                            customDescriptionText(
                                                                                context: context,
                                                                                textColor: mainColor,
                                                                                maxLines: 2,
                                                                                text: snapshot.data.items[index].name,
                                                                                textAlign: TextAlign.start),
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .012),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  child: customDescriptionText(
                                                                                      context: context,
                                                                                      textColor: mainColor,
                                                                                      text: "${snapshot.data.items[index].price} ${MyApp.country_currency}",
                                                                                      textAlign: TextAlign.start,
                                                                                      fontWeight: FontWeight.bold),
                                                                                ),


                                                                                Container(
                                                                                  width: width(context) * 0.3,
                                                                                  height: 30,
                                                                                  child:     ProductReviews(
                                                                                    product_sku: snapshot.data.items[index].sku,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .02),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: width(context) * .4,
                                                                                  height: isLandscape(context)
                                                                                      ? 2 * height(context) * .05
                                                                                      : height(context) * .05,
                                                                                  decoration: BoxDecoration(
                                                                                      border: Border.all(color: mainColor)),
                                                                                  child: Row(
                                                                                    mainAxisAlignment:
                                                                                    MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Icon(Icons.shopping_cart_outlined),
                                                                                      SizedBox(width: width(context) * .02),
                                                                                      customDescriptionText(
                                                                                          context: context,
                                                                                          textColor: mainColor,
                                                                                          text: "Add to cart",
                                                                                          textAlign: TextAlign.start),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    final RenderBox box =
                                                                                    context.findRenderObject();
                                                                                    Share.share('${snapshot.data.items[index].name}',
                                                                                        subject: 'Welcome To Ezhyper',
                                                                                        sharePositionOrigin:
                                                                                        box.localToGlobal(Offset.zero) &
                                                                                        box.size);
                                                                                  },
                                                                                  child: Container(
                                                                                    width: width(context) * .15,
                                                                                    height: isLandscape(context)
                                                                                        ? 2 * height(context) * .05
                                                                                        : height(context) * .05,
                                                                                    decoration: BoxDecoration(
                                                                                        border: Border.all(color: mainColor)),
                                                                                    child: Row(
                                                                                      mainAxisAlignment:
                                                                                      MainAxisAlignment.spaceAround,
                                                                                      children: [Icon(Icons.share_outlined)],
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
                                                                  decoration: BoxDecoration(color: backGroundColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  )*/
                                                  );
                                                  }

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
                                } else if (state is ErrorLoading) {
                                  print("33333333333");
                                  return Container();
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
            backgroundColor: mainColor,
          ),
        ),
      ),
    );
  }
}
