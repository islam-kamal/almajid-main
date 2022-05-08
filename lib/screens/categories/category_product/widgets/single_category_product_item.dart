import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class singleCategoryProductItem extends StatelessWidget {
  TextEditingController? qty_controller = new TextEditingController();
  Items? product;
  Widget? category_screen;
  var percentage;

  GlobalKey<ScaffoldState>? scafffoldKey;
  singleCategoryProductItem({this.product, this.scafffoldKey,this.category_screen});
  @override
  Widget build(BuildContext context) {
    List<String> gallery = [];
    product!.mediaGalleryEntries!.forEach((element) {
      gallery
          .add(ProductImages.getProductImageUrlByName(imageName: element.file));
    });
    var product_image;
    product!.customAttributes!.forEach((element) {
      if(element.attributeCode == "thumbnail")
        product_image = element.value;
    });


    String? special_price;
    var new_price , minimal_price;
    DateTime? startDate , endDate ;
    product!.customAttributes!.forEach((element) {
      if(element.attributeCode == "thumbnail")
        product_image = element.value;
      else if(element.attributeCode == "special_from_date"){
        startDate = DateTime.parse(element.value.toString().substring(0,10));
      }
      else  if(element.attributeCode == "special_to_date"){
        endDate = DateTime.parse(element.value.toString().substring(0,10));
      }
      else    if(element.attributeCode == 'special_price'){
        special_price = element.value;
      }
      else if( element.attributeCode == 'minimal_price'){
        minimal_price = element.value;
      }
    });

    if(startDate ==null || endDate ==null ){
      if(double.parse(minimal_price) == double.parse(product!.price.toString())){
        new_price = null;
      }else{
        new_price = minimal_price;

      }

      if(double.parse(minimal_price) < double.parse(product!.price.toString()))
        percentage = (1 - (double.parse(minimal_price)  / product!.price) )* 100;

    }
    else{
      if(StaticData.isCurrentDateInRange(startDate!,endDate!)
          && double.parse(special_price!) <= double.parse(minimal_price)
          && double.parse(special_price!).toStringAsFixed(2) !=  product!.price ) {
        new_price = special_price;
        percentage = (1 - (double.parse(new_price)  / product!.price) )* 100;

      }else if(double.parse(special_price!) > double.parse(minimal_price)){
        new_price = minimal_price;
        percentage = (1 - (double.parse(new_price)  / product!.price) )* 100;

      }
      else {
        if(!StaticData.isCurrentDateInRange(startDate!,endDate!) ){
          new_price = minimal_price;
          percentage = (1 - (double.parse(new_price)  / product!.price) )* 100;

        }
      }

    }
    return InkWell(
      onTap: (){
        customAnimatedPushNavigation(context, ProductDetailsScreen(
            product_id:product!.id,
          category_screen: category_screen!,
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
                              Stack(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 3, left: 3),
                                    width: width(context) * .3,
                                    height: isLandscape(context)
                                        ? 2 * height(context) * .16
                                        : height(context) * .16,
                                    decoration: BoxDecoration(
                                        color: backGroundColor,
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              product_image??'',
                                            ),
                                            fit: BoxFit.fill)),
                                  ),
                                  percentage== null ||  percentage.isNaN || percentage.isInfinite ? Container():       Container(
                                    width: width(context) * 0.15,
                                    decoration: BoxDecoration(
                                        color: greyColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),

                                    child: Text("${percentage.round()} %",style: TextStyle(color: mainColor),textAlign: TextAlign.center,),
                                  ),
                                ],
                              ),

                              Directionality(
                                  textDirection:
                                  translator.activeLanguageCode == 'ar'
                                      ? TextDirection.ltr
                                      : TextDirection.rtl,
                                  child: Container(
                                    padding: EdgeInsets.only(right: width(context) * .02, left: width(context) * .02),
                                    width: width(context) * .6,
                                    height: isLandscape(context)
                                        ? 2 * height(context) * .18
                                        : height(context) * .18,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                      translator.activeLanguageCode == 'en'
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        product!.extensionAttributes!.stockQty >=1 ?     CustomWishList(
                                          color: redColor,
                                          product_id: product!.id,
                                          qty: product!.extensionAttributes!.stockQty,
                                          context: context,
                                          screen: CategoryProductsScreen(),
                                          scafffoldKey: scafffoldKey!,
                                        ) : Container(),
                                        Padding(
                                     padding: EdgeInsets.only(right: 5,left: 5),
                                     child:    Align(
                                       child:   customDescriptionText(
                                           context: context,
                                           textColor: mainColor,
                                           maxLines: 2,
                                           text: product!.name,
                                       ),
                                       alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
                                     ),
                                   ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                        Directionality(textDirection: MyApp.app_langauge == 'ar' ?
                                          TextDirection.rtl : TextDirection.ltr,
                                            child:    Row(
                                              children: [
                                                Wrap(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        MyText(
                                                          text: "${new_price == null ?
                                                          double.parse(product!.price.toString()) <  double.parse(minimal_price) ?
                                                          product!.price.toStringAsFixed(2)  :
                                                          double.parse(minimal_price).toStringAsFixed(2)
                                                              : double.parse(new_price)} ",                                                          size: StaticData.get_height(context) * .017,
                                                          color: blackColor,
                                                          maxLines: 2,
                                                          weight: FontWeight.bold,
                                                        ),
                                                        MyText(
                                                          text: " ${MyApp.country_currency}",
                                                          size: StaticData.get_height(context) * .011,
                                                          color: blackColor,
                                                          maxLines: 2,
                                                          weight: FontWeight.normal,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(width: width(context) * 0.02,),
                                                new_price == null ?  Container()   :       Text(
                                                  "${product!.price.toStringAsFixed(2)} ${MyApp.country_currency}",
                                                  style: TextStyle(
                                                      decoration: TextDecoration.lineThrough,
                                                      fontSize: StaticData.get_height(context)  * .014,
                                                      color: old_price_color),
                                                ),
                                              ],
                                            ),),
/*
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
                                              filledColor:
                                              product!.extensionAttributes!.reviews!.isEmpty    ? greyColor
                                                  : Colors.yellow.shade700,
                                            ),*/

                                            RatingBar.builder(
                                              initialRating:  5.0,
                                              minRating: 5,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemSize: 10.0,
                                              itemBuilder: (context, _) => Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (rating){

                                              },
                                            ),
                                          ],
                                        ),
                                     Padding(padding: EdgeInsets.only(bottom: 10),
                                     child:    Row(
                                       mainAxisAlignment: MainAxisAlignment.center,
                                       children: [
                                         product!.extensionAttributes!.stockQty >=1 ?     AddProductToCartWidget(
                                           product_sku: product!.sku,
                                           product_quantity:   1,
                                           instock_status: product!.extensionAttributes!.stockItem!.isInStock,
                                           scaffoldKey: scafffoldKey,
                                           btn_height: width(context) * .08,
                                           btn_width: width(context) * .45,
                                           text_size: 0.017,
                                           home_shape: false,
                                           product_image: product_image,
                                           product_id: product!.id,
                                         )
                                             : Container(
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
                                                     text: translator.translate("Out Of Stock"),                                                        percentageOfHeight:  0.017,
                                                     textColor: mainColor) ,
                                               ],),
                                           ) ,
                                         ),
                                       ],
                                     ),)
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
