import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class singleCategoryProductItem extends StatefulWidget {
  Items product;
  GlobalKey<ScaffoldState> scafffoldKey;

  singleCategoryProductItem({this.product, this.scafffoldKey});

  @override
  _singleCategoryProductItemState createState() =>
      _singleCategoryProductItemState();
}

class _singleCategoryProductItemState extends State<singleCategoryProductItem> {
  TextEditingController qty_controller = new TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    List<String> gallery = new List<String>();
    widget.product.mediaGalleryEntries.forEach((element) {
      gallery
          .add(ProductImages.getProductImageUrlByName(imageName: element.file));
    });
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
                                        widget
                                            .product.customAttributes[0].value,
                                      ),
                                      fit: BoxFit.fill)),
                            ),
                            Directionality(
                                textDirection:
                                    translator.activeLanguageCode == 'ar'
                                        ? TextDirection.rtl
                                        : TextDirection.ltr,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: width(context) * .02,
                                      left: width(context) * .02),
                                  width: width(context) * .6,
                                  height: isLandscape(context)
                                      ? 2 * height(context) * .17
                                      : height(context) * .17,
                                  child: Column(
                                    crossAxisAlignment:
                                        translator.activeLanguageCode == 'en'
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.start,
                                    children: [
                                      CustomWishList(
                                        color: redColor,
                                        product_id: widget.product.id,
                                        qty: widget.product.extensionAttributes
                                            .stockItem.qty,
                                        context: context,
                                        screen: CategoryProductsScreen(),
                                        scafffoldKey: widget.scafffoldKey,
                                      ),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .01),
                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          maxLines: 2,
                                          text: widget.product.name,
                                          textAlign:
                                              translator.activeLanguageCode ==
                                                      'en'
                                                  ? TextAlign.end
                                                  : TextAlign.start),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: customDescriptionText(
                                                context: context,
                                                textColor: mainColor,
                                                text:
                                                    "${widget.product.price} ${MyApp.country_currency}",
                                                textAlign: TextAlign.start,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          RatingBar.readOnly(
                                            initialRating: 5.0,
                                            maxRating: 5,
                                            isHalfAllowed: true,
                                            halfFilledIcon: Icons.star_half,
                                            filledIcon: Icons.star,
                                            emptyIcon: Icons.star_border,
                                            size:
                                                StaticData.get_width(context) *
                                                    0.03,
                                            filledColor: (widget
                                                        .product.visibility
                                                        .toDouble() >=
                                                    1)
                                                ? Colors.yellow.shade700
                                                : Colors.yellow.shade700,
                                          ),
                                        ],
                                      ),
                                      responsiveSizedBox(
                                          context: context,
                                          percentageOfHeight: .01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BlocBuilder<ShoppingCartBloc, AppState>(
                                            bloc: shoppingCartBloc,
                                            builder: (context, state) {
                                              if (state is ProductLoading &&
                                                  state.indicator ==
                                                      'category_add_to_cart') {
                                                if (widget.product.sku ==
                                                    state.sku) {
                                                  _isLoading = true;
                                                } else {
                                                  _isLoading = false;
                                                }
                                              } else if (state
                                                      is ErrorLoadingProduct &&
                                                  state.indicator ==
                                                      'category_add_to_cart' &&
                                                  widget.product.sku ==
                                                      state.sku) {
                                                _isLoading = false;
                                                var data =
                                                    state.model as AddCartModel;
                                                Fluttertoast.showToast(
                                                    msg: '${data.message}',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.redAccent,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                                state = null;
                                              } else if (state
                                                      is DoneProductAdded &&
                                                  state.indicator ==
                                                      'category_add_to_cart' &&
                                                  widget.product.sku ==
                                                      state.sku) {
                                                _isLoading = false;
                                                Fluttertoast.showToast(
                                                    msg:
                                                        'product added successfully to cart',
                                                    toastLength:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: ToastGravity.TOP,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor:
                                                        Colors.green,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              }
                                              return _isLoading
                                                  ? CircularProgressIndicator()
                                                  : InkWell(
                                                      onTap: widget
                                                                  .product
                                                                  .extensionAttributes
                                                                  .stockItem
                                                                  .isInStock ==
                                                              false
                                                          ? () {
                                                              Flushbar(
                                                                messageText:
                                                                    Container(
                                                                  width: StaticData
                                                                          .get_width(
                                                                              context) *
                                                                      0.7,
                                                                  child: Wrap(
                                                                    children: [
                                                                      Text(
                                                                        translator
                                                                            .translate("There is no quantity of this product in stock"),
                                                                        textDirection:
                                                                            TextDirection.rtl,
                                                                        style: TextStyle(
                                                                            color:
                                                                                whiteColor),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                flushbarPosition:
                                                                    FlushbarPosition
                                                                        .BOTTOM,
                                                                backgroundColor:
                                                                    redColor,
                                                                flushbarStyle:
                                                                    FlushbarStyle
                                                                        .FLOATING,
                                                                duration:
                                                                    Duration(
                                                                        seconds:
                                                                            3),
                                                              )..show(widget
                                                                  .scafffoldKey
                                                                  .currentState
                                                                  .context);
                                                            }
                                                          : () {
                                                              shoppingCartBloc.add(AddProductToCartEvent(
                                                                  context:
                                                                      context,
                                                                  product_quantity:
                                                                      1,
                                                                  product_sku:
                                                                      widget
                                                                          .product
                                                                          .sku,
                                                                  indictor:
                                                                      'category_add_to_cart'));
                                                            },
                                                      child: Container(
                                                        width:
                                                            width(context) * .4,
                                                        height: isLandscape(
                                                                context)
                                                            ? 2 *
                                                                height(
                                                                    context) *
                                                                .035
                                                            : height(context) *
                                                                .035,
                                                        decoration: BoxDecoration(
                                                            border: Border.all(
                                                                color:
                                                                    mainColor)),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(Icons
                                                                .shopping_cart_outlined),
                                                            SizedBox(
                                                                width: width(
                                                                        context) *
                                                                    .02),
                                                            customDescriptionText(
                                                                context:
                                                                    context,
                                                                textColor:
                                                                    mainColor,
                                                                text:
                                                                    "Add to cart",
                                                                textAlign:
                                                                    TextAlign
                                                                        .start),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                          ],
                        ),
                        decoration: BoxDecoration(color: backGroundColor))),
              ],
            ),
          ],
        ));
  }
}
