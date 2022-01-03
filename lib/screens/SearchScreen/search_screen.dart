
import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';

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
                                    'Search for items'
                                  )
                                ],
                              ),
                          ) : Container(
                            child: StreamBuilder<SearchModel>(
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
                                            gallery
                                                .add(ProductImages.getProductImageUrlByName(imageName: element.file));
                                          });

                                          snapshot.data.items[index].customAttributes.forEach((element) {
                                            if(element.attributeCode == "thumbnail")
                                              product_image = element.value;
                                          });
                                          if (index >= snapshot.data.items.length) {
                                            return MyLoader(25, 25);
                                          } else {
                                            return snapshot.data.items[index] == null
                                                ? Container()
                                                :   Directionality(
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
                                                                                product_image??'',
                                                                              ),
                                                                              fit: BoxFit.fill)),
                                                                    ) ,

                                                                    Directionality(
                                                                        textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.ltr :TextDirection.rtl,
                                                                        child: Container(
                                                                            padding: EdgeInsets.only(
                                                                                right: width(context) * .02,
                                                                                left: width(context) * .02),
                                                                            width: width(context) * .6,
                                                                            height: isLandscape(context)
                                                                                ? 2 * height(context) * .17
                                                                                : height(context) * .17,
                                                                            child: SingleChildScrollView(
                                                                              child: Column(
                                                                                crossAxisAlignment: translator.activeLanguageCode == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                                                children: [
                                                                                  CustomWishList(
                                                                                    color: redColor,
                                                                                    product_id: snapshot.data.items[index].id,
                                                                                    qty: snapshot.data.items[index].extensionAttributes.stockItem.qty,
                                                                                    context: context,
                                                                                    screen: SearchScreen(),

                                                                                  ),
                                                                                  responsiveSizedBox(
                                                                                      context: context, percentageOfHeight: .01),
                                                                                  Padding(padding: EdgeInsets.only(right: 5,left: 5),
                                                                                    child:  customDescriptionText(
                                                                                        context: context,
                                                                                        textColor: mainColor,
                                                                                        maxLines: 2,
                                                                                        text: snapshot.data.items[index].name,
                                                                                        textAlign: translator.activeLanguageCode == 'ar' ? TextAlign.start :TextAlign.end),),
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
                                                                                            text: "${snapshot.data.items[index].price} ${MyApp.country_currency}",
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
                                                                                        (snapshot.data.items[index].visibility.toDouble() >= 1)
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
                                                                                      ),
                                                                                      InkWell(
                                                                                        onTap: () {
                                                                                          final RenderBox box =
                                                                                          context.findRenderObject();
                                                                                          Share.share('${snapshot.data.items[index].name}',
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
                                                                            )
                                                                        )),
                                                                  ],
                                                                ),
                                                                decoration: BoxDecoration(color: backGroundColor))),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                            );
                                          }

                                        });

                                  }
                                } else if (snapshot.hasError) {
                                  return Container(
                                    child: Text('${snapshot.error}'),
                                  );
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
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
            backgroundColor: mainColor,
          ),
        ),
      ),
    );
  }
}
