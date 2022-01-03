import 'dart:convert';

import 'package:almajidoud/Base/Shimmer/list_shimmer.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
as product_model;
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:share/share.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:http/http.dart' as http;

class HomeListProducts extends StatefulWidget {
  final String type;
  GlobalKey<ScaffoldState> homeScaffoldKey;
  HomeListProducts({this.type, this.homeScaffoldKey});
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    readJson();
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
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:StreamBuilder<List<product_model.Items>>(
        stream: widget.type == 'best-seller'
            ? home_bloc.best_seller_products_subject
            : home_bloc.new_arrivals_products_subject,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == null) {
              return Container();
            } else {
              return Container(
                  width: width(context),
                  height: isLandscape(context) ? 2 * height(context) * .26 : height(context) * .26,
                  child: ListView.builder(
                      itemCount: snapshot.data.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String special_price;
                        var percentage;
                        snapshot.data[index].customAttributes.forEach((element) {
                          if(element.attributeCode == 'special_price'){
                            special_price = element.value;
                          }
                        });

                        snapshot.data[index].customAttributes.forEach((element) {
                          if(element.attributeCode == "thumbnail")
                            product_image = element.value;
                        });
                        if(special_price != null){
                          percentage = (1 - (double.parse(special_price)  / snapshot.data[index].price) )* 100;
                        }
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
                              width: width(context) * .35,
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
                                                product: snapshot
                                                    .data[index],
                                              ));
                                        },
                                        child: Container(
                                          width: width(context) * .32,
                                          height: isLandscape(context)
                                              ? 2 *
                                              height(context) *
                                              .12
                                              : height(context) * .12,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      product_image??''),
                                                  fit: BoxFit.cover)),
                                        ),
                                      ),
                                      Container(
                                        width: width(context) * .32,
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
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            MyText(
                                                              text: " ${snapshot.data[index].price} ",
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
                                                    special_price == null ?  Container()   :  Row(
                                                      children: [
                                                        Text(
                                                          "${double.parse(special_price) } ${translator.translate("SAR")}",
                                                          style: TextStyle(
                                                              decoration: TextDecoration.lineThrough,
                                                              fontSize: StaticData.get_height(context)  * .011,
                                                              color: greyColor),
                                                        ),
                                                        SizedBox(
                                                          width: StaticData.get_width(context) * .02,
                                                        ),
                                                        MyText(
                                                            text: "${percentage}%",
                                                            size: StaticData.get_height(context)  * .011,
                                                            color: greenColor),
                                                      ],
                                                    )  ,
                                                  ],
                                                ),

                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                      AddProductToCartWidget(
                                        product_sku: snapshot.data[index].sku,
                                        product_quantity:   1,
                                        instock_status: snapshot.data[index].extensionAttributes.stockItem.isInStock,
                                        scaffoldKey: widget.homeScaffoldKey,
                                        btn_height: width(context) * .08,
                                        btn_width: width(context) * .35,
                                        text_size: 0.017,
                                        home_shape: true,
                                        product_image: product_image,
                                        product_id:  snapshot.data[index].id,

                                      )
                                    ],
                                  ),

                                  // ------------------ here ----------------------
                                  CustomWishList(
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
                                  ),
                                ],
                              ),

                            ),
                          ),
                        );
                      }));
            }
          } else if (snapshot.hasError) {
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

class MyShareButton extends StatelessWidget {
  final String data;
  const MyShareButton({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons.share_outlined,
        color: mainColor,
      ),
      onTap: () {
        final RenderBox box = context.findRenderObject();
        Share.share('${data}',
            subject: 'Welcome To Amajed Oud',
            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
      },
    );
  }
}
