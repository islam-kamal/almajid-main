import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:rating_bar/rating_bar.dart';

class singleCategoryProductItem extends StatelessWidget {
  TextEditingController qty_controller = new TextEditingController();
  Items product;
  String special_price;
  var percentage;
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
    product.customAttributes.forEach((element) {
      if(element.attributeCode == 'special_price' || element.attributeCode == 'minimal_price'){
        special_price = element.value;
      }
    });
    if(special_price != null){
      percentage = (1 - (double.parse(special_price)  / product.price) )* 100;
    }
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
                                    ? 2 * height(context) * .14
                                    : height(context) * .14,
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
                                        ? 2 * height(context) * .15
                                        : height(context) * .15,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                   Padding(
                                     padding: EdgeInsets.only(right: 5,left: 5),
                                     child:    Align(
                                       child:   customDescriptionText(
                                           context: context,
                                           textColor: mainColor,
                                           maxLines: 2,
                                           text: product.name,
                                       ),
                                       alignment:translator.activeLanguageCode ==
                                           'en'
                                           ? Alignment.centerLeft :  Alignment.centerRight,
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
                                                         text: "${special_price == null ?product.price : double.parse(special_price)} ",
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
                                               SizedBox(width: width(context) * 0.05,),
                                               special_price == null ?  Container()   :       Text(
                                                 "${product.price} ${translator.translate("SAR")}",
                                                 style: TextStyle(
                                                     decoration: TextDecoration.lineThrough,
                                                     fontSize: StaticData.get_height(context)  * .011,
                                                     color: greyColor),
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            AddProductToCartWidget(
                                              product_sku: product.sku,
                                              product_quantity:   1,
                                              instock_status: product.extensionAttributes.stockItem.isInStock,
                                              scaffoldKey: scafffoldKey,
                                              btn_height: width(context) * .08,
                                              btn_width: width(context) * .45,
                                              text_size: 0.017,
                                              home_shape: false,
                                              product_image: product_image,
                                              product_id: product.id,
                                            ),
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
