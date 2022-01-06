import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class singleCategoryProductItem extends StatelessWidget {
  TextEditingController qty_controller = new TextEditingController();
  Items product;

  GlobalKey<ScaffoldState> scafffoldKey;
  singleCategoryProductItem({this.product, this.scafffoldKey});
  @override
  Widget build(BuildContext context) {
    List<String> gallery = new List<String>();
    product.mediaGalleryEntries.forEach((element) {
      gallery
          .add(ProductImages.getProductImageUrlByName(imageName: element.file));
    });
    var product_image;
    product.customAttributes.forEach((element) {
      if(element.attributeCode == "thumbnail")
        product_image = element.value;
    });
    return InkWell(
      onTap: (){
        customAnimatedPushNavigation(context, ProductDetailsScreen(
            product_id:product.id
        ));
      },
      child: Directionality(
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
                                          product_image??'',
                                        ),
                                        fit: BoxFit.fill)),
                              ),
                              Directionality(
                                  textDirection:
                                  translator.activeLanguageCode == 'ar'
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        right: width(context) * .02,
                                        left: width(context) * .02),
                                    width: width(context) * .6,
                                    height: isLandscape(context)
                                        ? 2 * height(context) * .17
                                        : height(context) * .19,
                                    child: Column(
                                      crossAxisAlignment:
                                      translator.activeLanguageCode == 'en'
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        CustomWishList(
                                          color: redColor,
                                          product_id: product.id,
                                          qty: product
                                              .extensionAttributes.stockItem.qty,
                                          context: context,
                                          screen: CategoryProductsScreen(),
                                          scafffoldKey: scafffoldKey,
                                        ),
                                        responsiveSizedBox(
                                            context: context,
                                            percentageOfHeight: .01),
                                        customDescriptionText(
                                            context: context,
                                            textColor: mainColor,
                                            maxLines: 2,
                                            text: product.name,
                                            textAlign:
                                            translator.activeLanguageCode ==
                                                'en'
                                                ? TextAlign.end
                                                : TextAlign.start),
                                        responsiveSizedBox(
                                            context: context,
                                            percentageOfHeight: .01),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: customDescriptionText(
                                                  context: context,
                                                  textColor: mainColor,
                                                  text:
                                                  "${MyApp.country_currency} ${product.price}",
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
                                              filledColor: (product.visibility
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
                                            AddProductToCartWidget(
                                              product_sku: product.sku,
                                              product_quantity:   1,
                                              instock_status: product.extensionAttributes.stockItem.isInStock,
                                              scaffoldKey: scafffoldKey,
                                              btn_height: width(context) * .08,
                                              btn_width: width(context) * .35,
                                              text_size: 0.017,
                                              home_shape: false,
                                              product_image: product_image,
                                              product_id: product.id,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                final RenderBox box =
                                                context.findRenderObject();
                                                Share.share('${product.name}',
                                                    subject:
                                                    'Welcome To Amajed Oud',
                                                    sharePositionOrigin:
                                                    box.localToGlobal(
                                                        Offset.zero) &
                                                    box.size);
                                              },
                                              child: Container(
                                                width: width(context) * .15,
                                                height: isLandscape(context)
                                                    ? 2 * height(context) * .035
                                                    : height(context) * .035,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: mainColor)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
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
                                  )
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(color: backGroundColor))),
                ],
              ),
            ],
          )),
    );
  }
}
