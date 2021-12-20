import 'package:almajidoud/Base/Shimmer/list_shimmer.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
    as product_model;
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:share/share.dart';

class HomeListProducts extends StatefulWidget {
  final String type;
  GlobalKey<ScaffoldState> homeScaffoldKey;
  HomeListProducts({this.type,this.homeScaffoldKey});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeListProductsState();
  }
}

class HomeListProductsState extends State<HomeListProducts> {
  TextEditingController qty_controller = new TextEditingController();
  String cvv;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: home_bloc,
        builder: (context, state) {
          if (state is Loading) {
            return ListShimmer(
              type: 'horizontal',
            );
          } else if (state is Done) {
            var data = state.model as ProductModel;
            if (data.items == null || data.items.isEmpty) {
              return Container();
            } else {
              print("111111111111111");

              return StreamBuilder<List<product_model.Items>>(
                stream: widget.type == 'best-seller'
                    ? home_bloc.best_seller_products_subject
                    : home_bloc.new_arrivals_products_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      print("length : ${snapshot.data.length}");

                      return Container(
                          width: width(context),
                          height: isLandscape(context)
                              ? 2 * height(context) * .25
                              : height(context) * .25,
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  child:  Neumorphic(
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
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: mainColor
                                                      .withOpacity(.2)),
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                          GestureDetector(
                                          onTap: () {
                                      customAnimatedPushNavigation(
                                      context,
                                      ProductDetailsScreen(
                                      product: snapshot.data[index],
                                      ));
                                      },
                                        child:         Container(
                                                    width: width(context) * .32,
                                                    height: isLandscape(context)
                                                        ? 2 *
                                                            height(context) *
                                                            .12
                                                        : height(context) * .12,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snapshot
                                                                    .data[index]
                                                                    .customAttributes[
                                                                        0]
                                                                    .value),
                                                            fit: BoxFit.cover)),
                                                  ),
                                          ),
                                                  Container(
                                                    width: width(context) * .32,
                                                    height: isLandscape(context) ? 2 * height(context) * .12 : height(context) * .12,
                                                      color: whiteColor,
                                                      child: Column(
                                                        children: [
                                                          responsiveSizedBox(
                                                              context: context,
                                                              percentageOfHeight:
                                                                  .005),
                                                          customDescriptionText(
                                                              context: context,
                                                              textColor:
                                                                  mainColor,
                                                              text: snapshot
                                                                  .data[index]
                                                                  .name,
                                                              maxLines: 2,
                                                              percentageOfHeight:
                                                                  .017),
                                                          responsiveSizedBox(
                                                              context: context,
                                                              percentageOfHeight:
                                                                  .005),
                                                          customDescriptionText(
                                                              context: context,
                                                              textColor:
                                                                  mainColor,
                                                              text:
                                                                  " ${translator.translate("SAR")} ${snapshot.data[index].price}",
                                                              maxLines: 1,
                                                              percentageOfHeight:
                                                                  .017,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          responsiveSizedBox(
                                                              context: context,
                                                              percentageOfHeight:
                                                                  .0105),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              MyShareButton(
                                                                data: snapshot.data[index].name,
                                                              ),
                                                              SizedBox(
                                                                width: width(
                                                                        context) *
                                                                    .03,
                                                              ),
                                                              BlocListener<ShoppingCartBloc, AppState>(
                                                                  bloc: shoppingCartBloc,
                                                                  listener: (context, state) async {
                                                                    if (state is Loading) {
                                                                      if(state.indicator == 'home_add_to_cart')
                                                                        print("Loading");
                                                                    } else if (state is ErrorLoading) {
                                                                      if(state.indicator == 'home_add_to_cart') {
                                                                        var data = state.model as AddCartModel;
                                                                        print("ErrorLoading");
                                                                        if(data.message == "The consumer isn't authorized to access %resources." ||
                                                                            data.message == "Current customer does not have an active cart."){
                                                                          Flushbar(
                                                                            messageText:    Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: width(context) * 0.70,
                                                                                  child: Text(
                                                                                    '${data.message}',
                                                                                    maxLines: 2,
                                                                                    textAlign: TextAlign.end,
                                                                                    textDirection: TextDirection.rtl,
                                                                                    style: TextStyle(color: whiteColor),
                                                                                  ),
                                                                                ),
                                                                                InkWell(
                                                                                    onTap: (){
                                                                                      customAnimatedPushNavigation(context, SignInScreen());
                                                                                    },
                                                                                    child: Container(
                                                                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                                                                      decoration: BoxDecoration(
                                                                                        color: whiteColor,
                                                                                        borderRadius: BorderRadius.circular(20),

                                                                                      ),
                                                                                      child:  Text(
                                                                                        translator.translate("Sign In") ,
                                                                                        textDirection: TextDirection.rtl,
                                                                                        style: TextStyle(color: mainColor),
                                                                                      ),
                                                                                    )
                                                                                )
                                                                              ],
                                                                            ),

                                                                            flushbarPosition: FlushbarPosition.BOTTOM,
                                                                            backgroundColor: redColor,
                                                                            flushbarStyle: FlushbarStyle.FLOATING,
                                                                          )..show(widget.homeScaffoldKey.currentState.context);
                                                                        }else{
                                                                          Flushbar(
                                                                            messageText:       Container(
                                                                              width: StaticData.get_width(context) * 0.7,
                                                                              child: Wrap(
                                                                                children: [
                                                                                  Text(
                                                                                    '${data.message}',
                                                                                    textDirection: TextDirection.rtl,
                                                                                    style: TextStyle(color: whiteColor),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            flushbarPosition: FlushbarPosition.BOTTOM,
                                                                            backgroundColor: redColor,
                                                                            flushbarStyle: FlushbarStyle.FLOATING,
                                                                            duration: Duration(seconds: 3),
                                                                          )..show(widget.homeScaffoldKey.currentState.context);

                                                                        }
                                                                      }

                                                                    } else if (state is Done)
                                                                      if(state.indicator == 'home_add_to_cart') {
                                                                        var data = state.model as AddCartModel;
                                                                        customAnimatedPushNavigation(context,translator.activeLanguageCode == 'ar' ?  CustomCircleNavigationBar(
                                                                          page_index: 4,
                                                                        ): CustomCircleNavigationBar(
                                                                          page_index: 0,
                                                                        ));
                                                                      }
                                                                  },
                                                                  child:InkWell(
                                                                    onTap: snapshot.data[index].extensionAttributes.stockItem.isInStock == false ? (){} : () {
                                                                      shoppingCartBloc.add(AddProductToCartEvent(
                                                                          context: context,
                                                                          product_quantity: 1,

                                                                          product_sku: snapshot.data[index].sku,
                                                                          indictor: 'home_add_to_cart'));

                                                                    },
                                                                    child:    Icon(
                                                                      Icons
                                                                          .shopping_cart_outlined,
                                                                      color:
                                                                      mainColor,
                                                                    ),
                                                                  )
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),


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
                                          width: width(context) * .32,
                                          height: isLandscape(context)
                                              ? 2 * height(context) * .3
                                              : height(context) * .3),
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
              );
            }
          } else if (state is ErrorLoading) {
            return Container();
          } else {
            return ListShimmer(
              type: 'horizontal',
            );
          }
        },
      ),
    );
  }
  Widget chosse_product_quantity({var prod_sku}){
    return StatefulBuilder(
      builder: (context, setState) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          height: height / 2.5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height*.1)
          ),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content:  SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: width,
                    height: height / 4,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.1)
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(width * 0.01),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: cvvTextField(context),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: width * 0.05),
                                    child:  InkWell(
                                      onTap:  () {
                                        print("qty_controller.text : ${qty_controller.text}");
                                        shoppingCartBloc.add(AddProductToCartEvent(
                                            context: context,
                                            product_quantity: 1,
                                            product_sku: prod_sku,
                                            indictor: 'category_add_to_cart'));
                                      },
                                      child: Container(
                                        width: width * .3,
                                        alignment: Alignment.center,
                                        height: isLandscape(context)
                                            ? 2 * height * .035
                                            : height * .035,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: mainColor)),
                                        child:       customDescriptionText(
                                            context: context,
                                            textColor: mainColor,
                                            text: "Apply",
                                            textAlign: TextAlign.center),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02,),
                                  Padding(
                                    padding: EdgeInsets.only(top: width * 0.05),
                                    child: InkWell(
                                      onTap: (){
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        width: width * .3,
                                        alignment: Alignment.center,
                                        height: isLandscape(context)
                                            ? 2 * height * .035
                                            : height * .035,
                                        decoration: BoxDecoration(
                                            border: Border.all(color: mainColor)),
                                        child:  customDescriptionText(
                                            context: context,
                                            textColor: mainColor,
                                            text: "Discard",
                                            textAlign: TextAlign.center),


                                      ),
                                    ),
                                  ),


                                ],
                              )
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
      },
    );
  }
  Widget cvvTextField(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: height*.07,
          width: width*.65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(height*.1)
          ),
          child: TextFormField(
            controller: qty_controller,
            keyboardType: TextInputType.number,
            style: TextStyle(color:greyColor,fontSize: AlmajedFont.primary_font_size),
            obscureText: false,
            textAlign: translator.activeLanguageCode=='ar'? TextAlign.right : TextAlign.left,
            cursorColor: greyColor,
            decoration: InputDecoration(
              hintText: translator.translate("Enter Quantity *"),
              hintStyle: TextStyle(color: Color(0xffA0AEC0).withOpacity(.8,),fontSize: height*.018,),
              filled: true,
              fillColor: Colors.white,
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(height*.01),
                  borderSide: BorderSide(color: greyColor,width: height*.002)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height*.01),
                  borderSide: BorderSide(color:greyColor,width: height*.002)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(height*.01),
                  borderSide: BorderSide(color: greenColor,width:height*.002)),),),),
      ],
    );
  }
}
class MyShareButton extends StatelessWidget {
  final String data ;
  const MyShareButton({
    Key key,
    this.data
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(
        Icons
            .share_outlined,
        color:
        mainColor,
      ),
      onTap: () {
        final RenderBox box =
        context.findRenderObject();
        Share.share('${data}',
            subject: 'Welcome To Amajed Oud',
            sharePositionOrigin:
            box.localToGlobal(Offset.zero) &
            box.size);
      },
    );
  }
}


