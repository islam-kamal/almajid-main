import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/widgets/descriptionAndShareRow.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';
import 'package:almajidoud/screens/product_details/widgets/favourite_and_name_row.dart';
import 'package:almajidoud/screens/product_details/widgets/prica_and_rating_row.dart';
import 'package:almajidoud/screens/product_details/widgets/product_details_name_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/product_details_top_slider.dart';
import 'package:almajidoud/screens/product_details/widgets/quantity_button.dart';
import 'package:almajidoud/screens/product_details/widgets/size_and_quantity_text.dart';
import 'package:almajidoud/screens/product_details/widgets/sizes_listView.dart';
import 'package:almajidoud/screens/product_details/widgets/sold_by_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/vat_and_reviews_row.dart';
import 'package:almajidoud/screens/product_details/widgets/write_review_button.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
class ProductDetailsScreen extends StatefulWidget {
  Items product;
  ProductDetailsScreen({this.product});
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  List product_images = [];
  var selected_size = 0;
  var qty=1;

  @override
  void initState() {
    widget.product.mediaGalleryEntries.forEach((element) {
      product_images.add(
          "${Urls.BASE_URL}/media/catalog/product/cache/089af6965a318f5bf47750f284c40786" +
              element.file);
    });
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    StaticData.product_id = widget.product.id;
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

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
          child: Scaffold(
            key: _drawerKey,
        backgroundColor: whiteColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: BlocListener<ShoppingCartBloc, AppState>(
                    bloc: shoppingCartBloc,
                    listener: (context, state) {
                      var data = state.model as AddCartModel;
                      if (state is Loading) {
                        print("Loading");
                        _playAnimation();
                      } else if (state is ErrorLoading) {
                        var data = state.model as AddCartModel;
                        print("ErrorLoading");
                        _stopAnimation();
                        if(data.message == "The consumer isn't authorized to access %resources." ){
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
                          )..show(_drawerKey.currentState.context);
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
                          )..show(_drawerKey.currentState.context);

                        }
                      } else if (state is Done) {
                        print("done");
                        _stopAnimation();
                        Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation1, animation2) {

                              return translator.activeLanguageCode == 'ar' ?  CustomCircleNavigationBar(
                                page_index: 4,
                              ): CustomCircleNavigationBar(
                                page_index: 0,
                              );
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
                    },
                    child: Column(
                      children: [
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        productDetailsNameWidget(
                            context: context,
                            product_name: widget.product.name),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .03),
                        HomeSlider(
                          gallery: product_images,
                        ),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .05),
                        favouriteAndNameRow(
                            context: context,
                            product_name: widget.product.name),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        descriptionAndShareRow(
                            context: context,
                            description:
                                widget.product.customAttributes[5].value,
                            product_name: widget.product.name),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        priceAndRatingRow(
                            context: context, price: widget.product.price),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        vatAndReviewsRow(context: context),
                        divider(context: context),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                   /*     sizeAndQuantityText(context: context, text: "Size"),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),*/
                  //      sizesListView(context: context),
                   //     divider(context: context),
                        sizeAndQuantityText(context: context, text: "Quantity"),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: width(context) * .05, left: width(context) * .05),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: mainColor, width: 2),
                                    borderRadius: BorderRadius.circular(8)),
                                width: width(context) * .4,
                                height: isLandscape(context)
                                    ? 2 * height(context) * .06
                                    : height(context) * .06,
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        MaterialButton(
                                          height: 5,
                                          minWidth: StaticData.get_width(context) * 0.15,
                                          onPressed: () {
                                            setState(() {
                                              if (qty <= 1) {
                                                errorDialog(
                                                  context: context,
                                                  text:
                                                  "لقد نفذت الكمية من هذا المنتج",
                                                );
                                              } else {
                                                setState(() {
                                                  qty--;
                                                  StaticData.product_qty = qty;
                                                });
                                              }
                                            });
                                          },
                                          textColor: Colors.white,
                                          child: Icon(
                                            Icons.remove,
                                            size: 18,
                                            color: blackColor,
                                          ),

                                        ),
                                        quantity(),
                                        MaterialButton(
                                          height: 5,
                                          minWidth:
                                          StaticData.get_width(context) *
                                              0.15,
                                          onPressed: () {
                                            setState(() {
                                              print("prod_main_quantity : ${widget.product.extensionAttributes.stockItem.qty}");
                                              if (qty == widget.product.extensionAttributes.stockItem.qty) {
                                                errorDialog(
                                                  context: context,
                                                  text:
                                                  "لا يمكنك تخطى الكمية المتاحة",
                                                );
                                              } else {
                                                setState(() {
                                                  qty++;
                                                  StaticData.product_qty = qty;

                                                });
                                              }
                                            });
                                          },
                                          textColor: greyColor,
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                            color: blackColor,
                                          ),

                                        ),

                                      ],
                                    )),
                              ),
                            ),
                          ],
                        ),
                        //divider(context: context),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .06),
                        AddProductToCartWidget(
                            product_sku: widget.product.sku,
                            product_quantity:  StaticData.product_qty ,
                           instock_status: widget.product.extensionAttributes.stockItem.isInStock,
                          scaffoldKey: _drawerKey,
                            ),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .06),
                      Container(
                           height: height(context) * .1,
                           color: mainColor,
                           alignment: Alignment.bottomCenter,
                           child: Column(
                             children: [
                               responsiveSizedBox(
                                   context: context, percentageOfHeight: .01),
                               writeReviewButton(
                                   context: context,
                                 product_suk: widget.product.sku
                              ),
                               responsiveSizedBox(
                                   context: context, percentageOfHeight: .005),
                               soldByWidget(context: context)
                             ],
                           ),
                         ),

                      ],
                    )
                ))),
      )),
    );
  }
  Widget quantity() {
    return Text(
      '${qty}',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
  sizesListView({BuildContext context}) {
    return Container(
      width: width(context),
      height: isLandscape(context)
          ? 2 * height(context) * .07
          : height(context) * .07,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  selected_size = index;
                });
              },
              child: Row(
                children: [
                  SizedBox(width: width(context) * .02),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                selected_size == index ? mainColor : greyColor,
                            width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    width: width(context) * .2,
                    child: Center(
                      child: customDescriptionText(
                          context: context,
                          text: "90 ml",
                          percentageOfHeight: .02),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
          scrollDirection: Axis.horizontal),
    );
  }
}
