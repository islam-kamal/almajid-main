import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/home/widgets/home_list_products.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/widgets/descriptionAndShareRow.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';
import 'package:almajidoud/screens/product_details/widgets/favourite_and_name_row.dart';
import 'package:almajidoud/screens/product_details/widgets/prica_and_rating_row.dart';
import 'package:almajidoud/screens/product_details/widgets/product_details_name_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/size_and_quantity_text.dart';
import 'package:almajidoud/screens/product_details/widgets/sold_by_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/vat_and_reviews_row.dart';
import 'package:almajidoud/screens/product_details/widgets/write_review_button.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
as product_model;
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
  @override
  void initState() {
    home_bloc.add(ProductDetailsEvent(
      product_id: widget.product_id
    ));

    super.initState();
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
          child: Scaffold(
            key: _scaffoldKey,
        backgroundColor: whiteColor,
        body: SafeArea(
            child: SingleChildScrollView(
                child: StreamBuilder<List<product_model.Items>>(
                  stream: home_bloc.products_details_subject,
                  builder: (context , snapshot){
                    if (snapshot.hasData) {
                      if (snapshot.data == null) {
                        return no_data_widget(context: context);
                      } else {
                        product_images = [];
                        snapshot.data[0].mediaGalleryEntries.forEach((element) {
                          product_images.add(
                            SliderImage(
                              url: "${Urls.BASE_URL}/media/catalog/product" + element.file
                            )
                          );
                        });

                        snapshot.data[0]..customAttributes.forEach((element) {
                          if(element.attributeCode ==  "description"){
                            description = element.value;
                          }
                        });

                        snapshot.data[0].customAttributes.forEach((element) {
                          if(element.attributeCode == "thumbnail")
                            product_image = element.value;
                        });

                        String special_price;
                        var percentage;

                        snapshot.data[0].customAttributes.forEach((element) {
                          if(element.attributeCode == 'special_price' || element.attributeCode == 'minimal_price'){
                           special_price = element.value;
                            if(double.parse(element.value).toStringAsFixed(2) != snapshot.data[0].price.toStringAsFixed(2) ){
                              special_price = element.value == snapshot.data[0].price ? null : element.value;
                            }

                          }
                        });
                   /*     if(special_price != null){
                          percentage = (1 - (double.parse(special_price)  / snapshot.data[0].price) )* 100;
                        }*/
                        return Column(
                          children: [
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),
                            productDetailsNameWidget(
                                context: context,
                                product_name: snapshot.data[0].name,
                              category_screen: widget.category_screen
                            ),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .03),
                            HomeSlider(
                              gallery: product_images,
                              height: width(context) *0.90,
                            ),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .05),
                            favouriteAndNameRow(
                                context: context,
                                product_name: snapshot.data[0].name,
                            prod_id:  snapshot.data[0].id,
                            prod_qty:  snapshot.data[0].extensionAttributes.stockItem.qty),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            descriptionAndShareRow(
                                context: context,
                                description:description??'',
                                product_name: snapshot.data[0].name),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),
                            priceAndRatingRow(
                                context: context,
                                price: special_price ,
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
                                                  print("prod_main_quantity : ${snapshot.data[0].extensionAttributes.stockItem.qty}");
                                                  if (qty == snapshot.data[0].extensionAttributes.stockItem.qty) {
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

                            snapshot.data[0].extensionAttributes.stockItem.isInStock ?    AddProductToCartWidget(
                              product_sku: snapshot.data[0].sku,
                              product_quantity:  StaticData.product_qty ,
                              instock_status: snapshot.data[0].extensionAttributes.stockItem.isInStock,
                              scaffoldKey: _scaffoldKey,
                              btn_height: width(context) * .13,
                              btn_width: width(context) * .7,
                              text_size: .025,
                              product_image: product_image,
                              product_id: snapshot.data[0].id,
                            )  :
                            Container(
                              height: width(context) * .13,
                              width: width(context) * .7,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(15.0))
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    color:greyColor ,
                                    borderRadius: BorderRadius.circular(8)),
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
                            )
                            ,

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
                            titleText(context: context, text: "Related Products"),
                            responsiveSizedBox(context: context, percentageOfHeight: .02),

                            HomeListProducts(
                              type: 'related products',
                              homeScaffoldKey: _scaffoldKey,
                              items: snapshot.data[0],
                            ),
                            responsiveSizedBox(context: context, percentageOfHeight: .02),
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Container(
                        child: Text('${snapshot.error}'),
                      );
                    } else {
                      return  Center(
                          child: CircularProgressIndicator(),
                      );

                    }

                  },
                )

            )),
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
