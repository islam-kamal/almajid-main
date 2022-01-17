import 'dart:convert';

import 'package:almajidoud/Base/Shimmer/list_shimmer.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
as product_model;
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:http/http.dart' as http;
class HomeListProducts extends StatefulWidget {
  final String type;
  GlobalKey<ScaffoldState> homeScaffoldKey;
  Items items;
  HomeListProducts({this.type, this.homeScaffoldKey,this.items});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeListProductsState();
  }
}

class HomeListProductsState extends State<HomeListProducts> with TickerProviderStateMixin{
  TextEditingController qty_controller = new TextEditingController();
  String cvv;
  var sku;

  AnimationController _loginButtonController;
  bool isLoading = false;
  final home_bloc = HomeBloc(null);
  var product_image;
  var _subject;
  List<product_model.Items> related_product_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    readJson();
    switch(widget.type){
      case "best-seller":
        _subject = home_bloc.best_seller_products_subject;
        break;
      case "New Arrivals":
        _subject = home_bloc.new_arrivals_products_subject;
        break;
      case "weekly-deal":
        _subject = home_bloc.weekly_deal_products_subject;
        break;
      case "testahel-collection":
        _subject = home_bloc.testahel_collection_products_subject;
        break;

      case 'related products':
        widget.items.productLinks.forEach((element) async {
          print("element.linkedProductSku : ${element.linkedProductSku}");
          var response = await categoryRepository.getProduct(sku: element.linkedProductSku);
          related_product_list.add(response.items[0]);
          home_bloc.related_products_subject.sink.add(response.items);
        });
        _subject = home_bloc.related_products_subject;
        print("_subject : ${_subject}");
        break;
    }
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }


  Future<void> readJson() async {
    if (StaticData.data != null) {
      home_bloc.add(GetHomeNewArrivals(
          category_id: StaticData.data['new-arrival']['id'],
          offset: 1
      ));
      home_bloc.add(GetHomeBestSeller(
          category_id: StaticData.data['best-seller']['id'],
          offset: 1
      ));
      home_bloc.add(GetWeeklyDealSeller(
          category_id: StaticData.data['weekly-deal']['id'],
          offset: 1
      ));
     home_bloc.add(GetTestahelCollectionEvent(
          category_id: StaticData.data['testahel-collection']['id'],
          offset: 1
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:StreamBuilder<List<product_model.Items>>(
        stream: _subject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isEmpty) {
              return no_data_widget(
                context: context,
                image_status: true
              );
            } else {
             if(widget.type ==  'related products'){
               snapshot.data.clear();
               related_product_list.forEach((element) {
                 element.productLinks.forEach((e) {
                   if(e.linkType == "related"){
                     snapshot.data.add(element) ;
                   }
                 });

               });
             }
              return  Container(
                  width: width(context),
                  height: isLandscape(context) ? 2 * height(context) * .27 : height(context) * .27,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String special_price;
                        var percentage;

                        snapshot.data[index].customAttributes.forEach((element) {
                          if(element.attributeCode == 'special_price' || element.attributeCode == 'minimal_price'){
                            special_price = element.value == snapshot.data[index].price ? null : element.value;
                          }
                        });
                        if(special_price != null){
                          percentage = (1 - (double.parse(special_price)  / snapshot.data[index].price) )* 100;
                        }
                        snapshot.data[index].customAttributes.forEach((element) {
                          if(element.attributeCode == "thumbnail")
                            product_image = element.value;
                        });
                        if(snapshot.data[index].status == 1){
                          return Padding(
                            padding: EdgeInsets.only(left: 5, right: 5,),
                            child: Neumorphic(
                              style: NeumorphicStyle(
                                border:
                                NeumorphicBorder(color: mainColor),
                                shape: NeumorphicShape.flat,
                                color: whiteColor,
                                depth: 5,
                                shadowDarkColor: greyColor,
                                lightSource: LightSource.left,
                              ),
                              child: Container(
                                width: width(context) * .37,
                                height: isLandscape(context)
                                    ? 2 * height(context) * .35
                                    : height(context) * .35,
                                decoration: BoxDecoration(
                                    border: Border.all(color: mainColor.withOpacity(.2)),
                                    borderRadius: BorderRadius.circular(0)),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                            onTap: () {
                                              customAnimatedPushNavigation(
                                                  context,
                                                  ProductDetailsScreen(
                                                    product_id: snapshot.data[index].id,
                                                  ));
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: width(context) * .35,
                                                  height: isLandscape(context) ? 2 * height(context) * .12 : height(context) * .12,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              product_image??''),
                                                          fit: BoxFit.contain)),
                                                ),


                                              ],
                                            )
                                        ),
                                        Container(
                                          width: width(context) * .35,
                                          height: isLandscape(context) ? 2 * height(context) * .15 : height(context) * .08,
                                          color: whiteColor,
                                          child: Column(
                                            children: [
                                              responsiveSizedBox(context: context, percentageOfHeight: .008),
                                              customDescriptionText(
                                                  context: context,
                                                  textColor: mainColor,
                                                  text: snapshot.data[index].name,
                                                  maxLines: 2,
                                                  percentageOfHeight: .017),

                                              Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Wrap(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              MyText(
                                                                text: "${special_price == null ?snapshot.data[index].price : double.parse(special_price)} ",
                                                                size: StaticData.get_height(context) * .017,
                                                                color: blackColor,
                                                                maxLines: 2,
                                                                weight: FontWeight.normal,
                                                              ),
                                                              MyText(
                                                                text: " ${translator.translate("SAR")}",
                                                                size: StaticData.get_height(context) * .011,
                                                                color: blackColor,
                                                                maxLines: 2,
                                                                weight: FontWeight.normal,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(width: width(context) * 0.005,),
                                                      special_price == null ?  Container()   :       Text(
                                                        "${snapshot.data[index].price} ${translator.translate("SAR")}",
                                                        style: TextStyle(
                                                            decoration: TextDecoration.lineThrough,
                                                            fontSize: StaticData.get_height(context)  * .011,
                                                            color: greyColor),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              )

                                            ],
                                          ),
                                        ),
                                        snapshot.data[index].extensionAttributes.stockItem.isInStock ?   AddProductToCartWidget(
                                          product_sku: snapshot.data[index].sku,
                                          product_quantity:   1,
                                          instock_status: snapshot.data[index].extensionAttributes.stockItem.isInStock,
                                          scaffoldKey: widget.homeScaffoldKey,
                                          btn_height: width(context) * .08,
                                          btn_width: width(context) * .37,
                                          text_size: 0.017,
                                          home_shape: true,
                                          product_image: product_image,
                                          product_id:  snapshot.data[index].id,

                                        ) :
                                        Container(
                                          height: width(context) * .1,
                                          width: width(context) * .37,
                                          padding: EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(15.0))
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color:redColor ,
                                                borderRadius: BorderRadius.circular(8)),
                                            child:  Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                customDescriptionText(
                                                    context: context,
                                                    text: "Out Of Stock",
                                                    percentageOfHeight:  0.017,
                                                    textColor: whiteColor) ,
                                              ],),
                                          ) ,
                                        )



                                      ],
                                    ),

                                    // ------------------ here ----------------------
                                    snapshot.data[index].extensionAttributes.stockItem.isInStock ?     CustomWishList(
                                      color: redColor,
                                      product_id:
                                      snapshot.data[index].id,
                                      qty: snapshot
                                          .data[index]
                                          .extensionAttributes
                                          .stockItem
                                          .qty,
                                      context: context,
                                      screen:
                                      CustomCircleNavigationBar(),
                                    ) : Container(),
                                  ],
                                ),

                              ),
                            ),
                          );
                        }else{

                        }

                      })
              );
            }
          }
          else if (snapshot.hasError) {
            return Container(
              child: Text('${snapshot.error}'),
            );
          } else {
            return ListShimmer(
              type: 'horizontal',
            );
          }
        },
      ),
    );
  }

}

