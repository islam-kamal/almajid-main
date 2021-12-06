import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';
class singleCategoryProductItem extends StatelessWidget {
  TextEditingController qty_controller = new TextEditingController();
  String cvv;
  Items product;
  singleCategoryProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    List<String> gallery = new List<String>();
    product.mediaGalleryEntries.forEach((element) {
      gallery
          .add(ProductImages.getProductImageUrlByName(imageName: element.file));
    });
   /* //will you use to get product reviews
    List<int> reviews_values=[];
    product.extensionAttributes.reviews.forEach((element) {
      reviews_values.add(element.statusId);
    });

    */
    return  Directionality(
        textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr ,
        child:Row(
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
                                    product.customAttributes[0].value,
                                  ),
                                  fit: BoxFit.fill)),
                        ) ,
                        Directionality(
                            textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr,
                            child:  Container(
                          padding: EdgeInsets.only(
                              right: width(context) * .02,
                              left: width(context) * .02),
                          width: width(context) * .6,
                          height: isLandscape(context)
                              ? 2 * height(context) * .17
                              : height(context) * .17,
                          child: Column(
                            crossAxisAlignment: translator.activeLanguageCode == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,

                            children: [

                              CustomWishList(
                                color: redColor,
                                favourite_status:
                                    product.status == 0 ? false : true,
                                product_id: product.id,
                                qty: product.extensionAttributes.stockItem.qty,
                                context: context,

                              ),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              customDescriptionText(
                                  context: context,
                                  textColor: mainColor,
                                  maxLines: 2,
                                  text: product.name,
                                  textAlign: translator.activeLanguageCode == 'en' ? TextAlign.end :TextAlign.start),
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
                                        text: "${product.price} \$",
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
                                        (product.visibility.toDouble() >= 1)
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
                              /*    BlocListener(
                                      bloc: shoppingCartBloc,
                                      listener: (context,state){
                                        if(state is Done){
                                          customAnimatedPushNavigation(
                                            context,
                                            CustomCircleNavigationBar(page_index: 0,)
                                          );
                                        }else if( state is ErrorLoading ){
                                          errorDialog(
                                            context: context,
                                            text: state.message
                                          );
                                        }
                                      },
                                  child: InkWell(
                                    onTap: product.extensionAttributes.stockItem.isInStock == false ? (){} : () {
                                      shoppingCartBloc.add(AddProductToCartEvent(
                                          context: context,
                                          product_quantity: product.extensionAttributes.stockItem.qty,
                                          product_sku: product.sku));
                                    },
                                    child: Container(
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
                                  ),),*/
                                  BlocListener<ShoppingCartBloc, AppState>(
                                    bloc: shoppingCartBloc,
                                    listener: (context, state) {
                                      if (state is Loading) {
                                        if(state.indicator == 'category_add_to_cart')
                                        print("Loading");
                                      } else if (state is ErrorLoading) {
                                        if(state.indicator == 'category_add_to_cart') {
                                          print("ErrorLoading");
                                          errorDialog(
                                              context: context,
                                              text: state.message
                                          );
                                          }

                                      } else if (state is Done)
                                        if(state.indicator == 'category_add_to_cart') {
                                        print("------------- done-------------------");
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
                                    child:InkWell(
                                      onTap: product.extensionAttributes.stockItem.isInStock == false ? (){} : () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                        return chosse_product_quantity();

                                          },
                                        );

                                      },
                                      child: Container(
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
                                    )
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final RenderBox box =
                                          context.findRenderObject();
                                      Share.share('${product.name}',
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
                        )),
                      ],
                    ),
                    decoration: BoxDecoration(color: backGroundColor))),
          ],
        ),
      ],
    ));
  }

  Widget chosse_product_quantity(){
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
                                            product_quantity: qty_controller.text,
                                            product_sku: product.sku,
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
