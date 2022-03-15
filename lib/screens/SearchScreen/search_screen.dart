
import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/Widgets/customText.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController controller ;
  String search_text='';
  var product_image;
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey();
  final search_bloc = SearchBloc(null);
  var percentage;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    search_bloc.drainStream();
    search_text = '';
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              key: scaffold_key,
              backgroundColor: whiteColor,
              body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenAppBar(
                        right_icon: 'cart',
                        category_name: translator.translate("Search"),
                        screen: CustomCircleNavigationBar(),
                      ),
                      Container(
                        height: height(context),
                        child: NestedScrollView(
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverAppBar(
                                automaticallyImplyLeading: false,
                                leading: null,
                                expandedHeight: isLandscape(context)
                                    ? 2 * height(context) * .1
                                    : height(context) * .1,
                                floating: false,
                                backgroundColor: whiteColor,
                                elevation: 0,
                                pinned: false,
                                flexibleSpace: FlexibleSpaceBar(
                                    background:     searchTextFieldAndFilterPart()
                                ),
                              )
                            ];
                          },
                          body:search_text.isEmpty  ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/search.png',
                                  height: width(context) * 0.5,),
                                Text(
                                    translator.translate( "Search for items")
                                )
                              ],
                            ),
                          ) :
                          Container(
                              child: StreamBuilder<ProductModel>(
                                stream: search_bloc.search_products_subject,
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data == null) {
                                      return Center(
                                        child: no_data_widget(
                                            context: context
                                        ),
                                      );
                                    } else {
                                      return ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: snapshot.data.items.length,
                                            itemBuilder: (context, index) {
                                              List<String> gallery = new List<String>();
                                              snapshot.data.items[index].mediaGalleryEntries.forEach((element) {
                                                gallery.add(ProductImages.getProductImageUrlByName(imageName: element.file));
                                              });

                                              String special_price;
                                              var new_price , minimal_price;
                                              DateTime startDate , endDate ;
                                              snapshot.data.items[index].customAttributes.forEach((element) {
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
                                                new_price = minimal_price;
                                                if(double.parse(minimal_price) < double.parse(snapshot.data.items[index].price.toString()))
                                                  percentage = (1 - (double.parse(minimal_price)  / snapshot.data.items[index].price) )* 100;
                                              }
                                              else{
                                                if(StaticData.isCurrentDateInRange(startDate,endDate)
                                                    && double.parse(special_price) <= double.parse(minimal_price)
                                                    && double.parse(special_price).toStringAsFixed(2) !=  snapshot.data.items[index].price ) {
                                                  new_price = special_price;
                                                  percentage = (1 - (double.parse(new_price)  / snapshot.data.items[index].price) )* 100;
                                                }else if(double.parse(special_price) > double.parse(minimal_price)){
                                                  new_price = minimal_price;
                                                  percentage = (1 - (double.parse(new_price)  / snapshot.data.items[index].price) )* 100;

                                                }
                                                else{
                                                  new_price = null;
                                                }

                                              }
                                              if (index >= snapshot.data.items.length) {
                                                return MyLoader(25, 25);
                                              }
                                              else {
                                                return snapshot.data.items[index] == null
                                                    ? Container()
                                                    :  snapshot.data.items[index].status == 1 ?InkWell(
                                                  onTap: (){
                                                    customAnimatedPushNavigation(context,ProductDetailsScreen(
                                                      product_id: snapshot.data.items[index].id,
                                                    )
                                                    );
                                                  },


                                                  child: Column(
                                                    children: [
                                                      Directionality(
                                                          textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr ,
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
                                                                                    margin: EdgeInsets.only(right: 3,left: 3),
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
                                                                                  percentage== null ? Container():    Container(
                                                                                    width: width(context) * 0.15,
                                                                                    decoration: BoxDecoration(
                                                                                        color: greyColor,
                                                                                        borderRadius: BorderRadius.circular(5)
                                                                                    ),

                                                                                    child: Text("${percentage.round()} %",style: TextStyle(color: mainColor),textAlign: TextAlign.center,),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                        ,

                                                                              Directionality(
                                                                                  textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.ltr :TextDirection.rtl,
                                                                                  child: Container(
                                                                                    padding: EdgeInsets.only(right: width(context) * .02, left: width(context) * .02),
                                                                                    width: width(context) * .6,
                                                                                    height: isLandscape(context) ? 2 * height(context) * .18 : height(context) * .18,
                                                                                    child: Column(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      crossAxisAlignment: translator.activeLanguageCode == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        snapshot.data.items[index].extensionAttributes.stockItem.qty >= 0?     CustomWishList(
                                                                                          color: redColor,
                                                                                          product_id: snapshot.data.items[index].id,
                                                                                          qty: snapshot.data.items[index].extensionAttributes.stockItem.qty,
                                                                                          context: context,
                                                                                          screen: SearchScreen(),

                                                                                        ) : Container(),
                                                                                        Padding(
                                                                                          padding: EdgeInsets.only(right: 5,left: 5),
                                                                                          child:  Align(
                                                                                            child:    customDescriptionText(
                                                                                              context: context,
                                                                                              textColor: mainColor,
                                                                                              maxLines: 2,
                                                                                              text: snapshot.data.items[index].name,
                                                                                            ),
                                                                                            alignment:translator.activeLanguageCode ==
                                                                                                'en'
                                                                                                ? Alignment.centerLeft :  Alignment.centerRight,
                                                                                          ),
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment:
                                                                                          MainAxisAlignment.spaceBetween,
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
                                                                                                          text: "${
                                                                                                              new_price == null ?
                                                                                                              double.parse(snapshot.data.items[index].price.toString()) <  double.parse(minimal_price) ?
                                                                                                              snapshot.data.items[index].price.toStringAsFixed(2)  :
                                                                                                              double.parse(minimal_price).toStringAsFixed(2)
                                                                                                                  : double.parse(new_price)} ",
                                                                                                          size: StaticData.get_height(context) * .017,
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
                                                                                                SizedBox(width: width(context) * 0.03,),
                                                                                                new_price == null ?  Container()   : Text(
                                                                                                  "${snapshot.data.items[index].price} ${MyApp.country_currency}",
                                                                                                  style: TextStyle(
                                                                                                      decoration: TextDecoration.lineThrough,
                                                                                                      fontSize: StaticData.get_height(context)  * .011,
                                                                                                      color: old_price_color),
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
                                                                                              size: StaticData.get_width(context) * 0.03,
                                                                                              filledColor:
                                                                                              snapshot.data.items[index].extensionAttributes.reviews.isEmpty
                                                                                                  ? greyColor
                                                                                                  : Colors.yellow.shade700,
                                                                                            ),


                                                                                          ],
                                                                                        ),
                                                                                        //  responsiveSizedBox(context: context, percentageOfHeight: .01),
                                                                                        Padding(padding: EdgeInsets.only(bottom: 10),
                                                                                          child:      Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              snapshot.data.items[index].extensionAttributes.stockItem.qty >=0?
                                                                                              AddProductToCartWidget(
                                                                                                product_sku: snapshot.data.items[index].sku,
                                                                                                product_quantity:   1,
                                                                                                instock_status: snapshot.data.items[index].extensionAttributes.stockItem.isInStock,
                                                                                                scaffoldKey: scaffold_key,
                                                                                                btn_height: width(context) * .08,
                                                                                                btn_width: width(context) * .35,
                                                                                                text_size: 0.017,
                                                                                                home_shape: false,
                                                                                                product_image: product_image,
                                                                                                product_id:  snapshot.data.items[index].id,
                                                                                              )
                                                                                                  :   Container(
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
                                                                                                          text: translator.translate("Out Of Stock"),                                                                                                      percentageOfHeight:  0.017,
                                                                                                          textColor: mainColor) ,
                                                                                                    ],),
                                                                                                ) ,
                                                                                              ),
                                                                                            ],
                                                                                          ),)
                                                                                      ],
                                                                                    ),

                                                                                  )),
                                                                            ],
                                                                          ),
                                                                          decoration: BoxDecoration(color: backGroundColor))),
                                                                ],
                                                              ),
                                                            ],
                                                          )
                                                      ),
                                                      snapshot.data.items.length ==index ?    Container(
                                                        height: width(context) ,
                                                      ) : Container()
                                                    ],
                                                  ),
                                                ) : null ;
                                              }

                                            });

                                    }
                                  } else if (snapshot.hasError) {
                                    return Container(
                                      child: Text('${snapshot.error}'),
                                    );
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(
                                      ),
                                    );
                                    ;
                                  }
                                },
                              )

                          ),
                        ),
                      )
                    ],
                  )),
            )));
  }


  Widget searchTextFieldAndFilterPart() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.only(top:  width * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: width * .85,
              height: height * .07,

              child: Container(
                child: TextFormField(
                  controller: controller,
                  onChanged: (value){
                    setState(() {
                      search_text = controller.value.text;
                      search_bloc
                          .add(SearchProductsEvent(search_text: controller.value.text));
                    });
                  },
                  style: TextStyle(color: greyColor,
                    fontSize:AlmajedFont.primary_font_size,
                  ),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),

                    suffixIcon:  IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 20,
                      ),

                    ),
                    hintText: translator.translate("What Are You Loking For ? "),
                    hintStyle:
                    TextStyle(color: Colors.grey, fontSize:AlmajedFont.secondary_font_size),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: mainColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: mainColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: greenColor)),
                  ),
                ),
              )),

        ],
      ),
    );
  }


}

class MyLoader extends StatelessWidget {
  final double width;
  final double height;

  MyLoader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
