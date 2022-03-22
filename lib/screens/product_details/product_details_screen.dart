import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/home/widgets/home_list_products.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/widgets/descriptionAndShareRow.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';
import 'package:almajidoud/screens/product_details/widgets/favourite_and_name_row.dart';
import 'package:almajidoud/screens/product_details/widgets/prica_and_rating_row.dart';
import 'package:almajidoud/screens/product_details/widgets/product_details_name_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/size_and_quantity_text.dart';
import 'package:almajidoud/screens/product_details/widgets/vat_and_reviews_row.dart';
import 'package:almajidoud/screens/product_details/widgets/write_review_button.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
as product_model;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:almajidoud/screens/product_details/widgets/product_use_tabBar.dart';


class ProductDetailsScreen extends StatefulWidget {
  var product_id;
  Widget category_screen;
  ProductDetailsScreen({this.product_id,this.category_screen});
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  List<SliderImage> product_images ;
  var selected_size = 0;
  var qty=1;
  var description;
  var product_image;
  var positioned_status = false;
  final home_bloc = HomeBloc(null);
  bool releated_products = false;
  var percentage;
  @override
  void initState() {
    home_bloc.add(ProductDetailsEvent(
      product_id: widget.product_id
    ));

    super.initState();
  }

  GlobalKey<ScaffoldState> _product_details_scaffoldKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
          child: Scaffold(
            key: _product_details_scaffoldKey,
        backgroundColor: whiteColor,
        body: StreamBuilder<List<product_model.Items>>(
          stream: home_bloc.products_details_subject,
          builder: (context , snapshot){
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return no_data_widget(context: context);
              }
              else {
                if(snapshot.data.isEmpty){
                  return  no_data_widget(context: context);
                }
                else{
                  product_images = [];
                  snapshot.data[0].mediaGalleryEntries.forEach((element) {
                    product_images.add(
                        SliderImage(
                            url: "${Urls.BASE_URL}/media/catalog/product" + element.file
                        )
                    );
                  });
                  String special_price;
                  var new_price , minimal_price , description_use , title , how_to_use;
                  DateTime startDate , endDate ;
                  snapshot.data[0].customAttributes.forEach((element) {
                    if(element.attributeCode ==  "description"){
                      description = element.value;
                    }
                    else if(element.attributeCode == "thumbnail")
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
                    else if(element.attributeCode == 'how_to_use'){
                      how_to_use = element.value;
                    }
                    else if(element.attributeCode == 'meta_description'){
                      description_use = element.value;
                    }

                  });
                  if(startDate ==null || endDate ==null ) {
                    new_price = minimal_price;
                    if(double.parse(minimal_price) < double.parse(snapshot.data[0].price.toString()))
                      percentage = (1 - (double.parse(minimal_price)  / snapshot.data[0].price) )* 100;

                  }
                  else{
                    if(StaticData.isCurrentDateInRange(startDate,endDate)
                        && double.parse(special_price) <= double.parse(minimal_price)
                        && double.parse(special_price).toStringAsFixed(2) != snapshot.data[0].price ) {
                      new_price = special_price;
                      percentage = (1 - (double.parse(new_price)  / snapshot.data[0].price) )* 100;

                    }else if(double.parse(special_price) > double.parse(minimal_price)){
                      new_price = minimal_price;
                      percentage = (1 - (double.parse(new_price)  / snapshot.data[0].price) )* 100;

                    }
                    else {
                      if(!StaticData.isCurrentDateInRange(startDate,endDate) ){
                        new_price = minimal_price;
                        percentage = (1 - (double.parse(new_price)  / snapshot.data[0].price) )* 100;

                      }

                    }

                  }

                  snapshot.data[0].productLinks.forEach((element) {
                    if(element.linkType == "related"){
                      releated_products = true;
                    }
                  });
                  return  Stack(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            productDetailsNameWidget(
                                context: context,
                                product_name: snapshot.data[0].name,
                                category_screen: widget.category_screen
                            ),
                            Stack(
                              children: [
                                HomeSlider(
                                  gallery: product_images,
                                  height: width(context) *0.90,
                                ),
                                percentage== null ? Container():   Container(
                                  width: width(context) * 0.2,
                                  decoration: BoxDecoration(
                                      color: greyColor,
                                      borderRadius: BorderRadius.circular(5)
                                  ),

                                  child: Text("${percentage.round()} %",style: TextStyle(color: mainColor),textAlign: TextAlign.center,),
                                ),
                              ],
                            ),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .05),
                            favouriteAndNameRow(
                                context: context,
                                product_name: snapshot.data[0].name,
                                prod_id:  snapshot.data[0].id,
                                prod_qty:  snapshot.data[0].extensionAttributes.stockQty),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            descriptionAndShareRow(
                              context: context,
                              description:description??'',
                            ),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),
                            priceAndRatingRow(
                              context: context,
                              new_price: new_price ,
                              minimal_price: minimal_price,
                              old_price: snapshot.data[0].price.toStringAsFixed(2),
                              review_status:  snapshot.data[0].extensionAttributes.reviews.isEmpty ? false : true,

                            ),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),
                            vatAndReviewsRow(
                              context: context,
                              product_sku: snapshot.data[0].sku,
                              product_id: snapshot.data[0].id,
                              review_status:  snapshot.data[0].extensionAttributes.reviews.isEmpty? false : true,
                            ),
                            divider(context: context),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),
                            titleText(context: context, text: "Quantity"),
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
                                              minWidth: StaticData.get_width(context) * 0.10,
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
                                                  0.10,
                                              onPressed: () {
                                                setState(() {
                                                  if (qty == snapshot.data[0].extensionAttributes.stockQty) {
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
                            responsiveSizedBox(context: context, percentageOfHeight: .03),

                            snapshot.data[0].price >=99 ? Container(
                              padding: EdgeInsets.symmetric(vertical: 10,horizontal:10),
                              child:Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Expanded(
                                  flex:3,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(translator.translate("Divide your bill into 3 installments of")

                                    ),
                                    SizedBox(width: 5,),
                                    Text(" ${(double.parse(new_price) /3).toStringAsFixed(2)} ${MyApp.country_currency}   " + translator.translate("without interest with") ),


                                  ],
                                ),),
                              Expanded(
                              flex:1,
                              child:    Image.asset("assets/icons/tamara_details.png")

                              )
                                ],
                              )
                            ) : Container(),
                            //how to use
                            ProductUseTabBar(
                              description: description_use,
                              how_to_use: how_to_use,
                            ),

                            responsiveSizedBox(context: context, percentageOfHeight: .03),
                            responsiveSizedBox(context: context, percentageOfHeight: .03),
                            Container(
                              height: height(context) * .1,
                              color: mainColor,
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .015),
                                  writeReviewButton(
                                    context: context,
                                    product_suk: snapshot.data[0].sku,
                                    product_id: snapshot.data[0].id,
                                  ),
                                  responsiveSizedBox(
                                      context: context, percentageOfHeight: .005),
                                ],
                              ),
                            ),
                            responsiveSizedBox(context: context, percentageOfHeight: .03),
                            releated_products? titleText(context: context, text: "Related Products") : Container(),
                            responsiveSizedBox(context: context, percentageOfHeight: .02),

                            HomeListProducts(
                              type: 'related products',
                              homeScaffoldKey: _product_details_scaffoldKey,
                              items: snapshot.data[0],
                            ),
                            responsiveSizedBox(context: context, percentageOfHeight: .2),
                          ],
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child:    snapshot.data[0].extensionAttributes.stockQty >=0 ?
                          AddProductToCartWidget(
                            product_sku: snapshot.data[0].sku,
                            product_quantity:  StaticData.product_qty ,
                            instock_status: snapshot.data[0].extensionAttributes.stockItem.isInStock,
                            scaffoldKey: _product_details_scaffoldKey,
                            btn_height: width(context) * .16,
                           btn_width: width(context) ,
                            text_size: .025,
                            product_image: product_image,
                            product_id: snapshot.data[0].id,
                            product_details_page: true,
                          )  :
                          Container(
                            height: width(context) * .16,
                           width: width(context) ,
                            decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(0.0))
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color:greyColor ,
                                  borderRadius: BorderRadius.circular(0)),
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  customDescriptionText(
                                      context: context,
                                      text: translator.translate("Out Of Stock"),
                                      percentageOfHeight:  0.017,
                                      textColor: mainColor) ,
                                ],),
                            ) ,
                          ),
                      )
                    ],
                  )

                  ;


                }

              }
            }
            else if (snapshot.hasError) {
              return Container(
                child: Text('${snapshot.error}'),
              );
            }
            else {
              return Padding(
                padding: EdgeInsets.only(top:  width(context ) * 0.3),
                child: SpinKitFadingCube(
                  color: Theme.of(context).primaryColor,
                  size: width(context) * 0.10,
                ),

              );


            }

          },
        ),
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

}
