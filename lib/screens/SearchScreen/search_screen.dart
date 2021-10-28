import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/screens/Favourites/custom_favourite.dart';
import 'package:almajidoud/screens/Products/product_slider.dart';
import 'package:almajidoud/screens/Reviews/product_reviews.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:share/share.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {


  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              backgroundColor: whiteColor,
              body: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenAppBar(
                        right_icon: 'cart',
                        category_name: translator.translate("Search Result"),
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
                                    ? 2 * height(context) * .2
                                    : height(context) * .2,
                                floating: false,
                                backgroundColor: mainColor,
                                elevation: 0,
                                pinned: false,
                                flexibleSpace: FlexibleSpaceBar(
                                  background: categoryDetailsTopSlider(context: context),
                                ),
                              )
                            ];
                          },
                          body: Container(
                            child: BlocBuilder(
                              bloc: search_bloc,
                              builder: (context, state) {
                                if (state is Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is Done) {
                                  var data = state.model as SearchModel;
                                  print("data : ${data}");

                                  if (data.items == null || data.items.isEmpty) {
                                    print("11111111111");
                                    return no_search_data_widget();
                                  } else {
                                    return StreamBuilder<SearchModel>(
                                      stream: search_bloc.search_products_subject,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data == null) {
                                            print("222222");
                                            return no_search_data_widget();
                                          } else {
                                            print("length : ${snapshot.data.items.length}");

                                            return ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: snapshot.data.items.length,
                                                itemBuilder: (context, index) {
                                                  List<String> gallery = new List<String>();
                                                  snapshot.data.items[index].mediaGalleryEntries.forEach((element) {
                                                    gallery
                                                        .add(ProductImages.getProductImageUrlByName(imageName: element.file));
                                                  });
                                                  return index >= snapshot.data.items.length
                                                      ? MyLoader(25, 25)
                                                      : snapshot.data.items[index] == null
                                                      ? Container()
                                                      :   Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          responsiveSizedBox(context: context, percentageOfHeight: .02),
                                                          Neumorphic(
                                                              child: Container(
                                                                  width: width(context) * .9,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        height: StaticData.get_height(context) * .23,
                                                                        width: StaticData.get_width(context) * .3,
                                                                        child: MyProductSlider(
                                                                          data: gallery,
                                                                          viewportFraction: 1.0,
                                                                          aspect_ratio: 3.0,
                                                                          border_radius: 5.0,
                                                                          indicator: false,
                                                                          motion: true,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        padding: EdgeInsets.only(
                                                                            right: width(context) * .02,
                                                                            left: width(context) * .02),
                                                                        width: width(context) * .6,
                                                                        height: isLandscape(context)
                                                                            ? 2 * height(context) * .23
                                                                            : height(context) * .23,
                                                                        child: Column(
                                                                          children: [
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .01),
                                                                            CustomFauvourite(
                                                                              color: redColor,
                                                                              favourite_status:
                                                                              snapshot.data.items[index].status == 0 ? false : true,
                                                                              product_id: snapshot.data.items[index].id,
                                                                            ),
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .01),
                                                                            customDescriptionText(
                                                                                context: context,
                                                                                textColor: mainColor,
                                                                                maxLines: 2,
                                                                                text: snapshot.data.items[index].name,
                                                                                textAlign: TextAlign.start),
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .012),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  child: customDescriptionText(
                                                                                      context: context,
                                                                                      textColor: mainColor,
                                                                                      text: "${snapshot.data.items[index].price} \$",
                                                                                      textAlign: TextAlign.start,
                                                                                      fontWeight: FontWeight.bold),
                                                                                ),


                                                                                Container(
                                                                                  width: width(context) * 0.3,
                                                                                  height: 30,
                                                                                  child:     ProductReviews(
                                                                                    product_sku: snapshot.data.items[index].sku,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            responsiveSizedBox(
                                                                                context: context, percentageOfHeight: .02),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Container(
                                                                                  width: width(context) * .4,
                                                                                  height: isLandscape(context)
                                                                                      ? 2 * height(context) * .05
                                                                                      : height(context) * .05,
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
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    final RenderBox box =
                                                                                    context.findRenderObject();
                                                                                    Share.share('${snapshot.data.items[index].name}',
                                                                                        subject: 'Welcome To Ezhyper',
                                                                                        sharePositionOrigin:
                                                                                        box.localToGlobal(Offset.zero) &
                                                                                        box.size);
                                                                                  },
                                                                                  child: Container(
                                                                                    width: width(context) * .15,
                                                                                    height: isLandscape(context)
                                                                                        ? 2 * height(context) * .05
                                                                                        : height(context) * .05,
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
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  decoration: BoxDecoration(color: backGroundColor))),
                                                        ],
                                                      ),
                                                    ],
                                                  );

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
                                    );
                                  }
                                } else if (state is ErrorLoading) {
                                  print("33333333333");
                                  return Container();
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  )),
            )));
  }

  Widget no_search_data_widget(){
    return Container(
      color: whiteColor,
      child: Column(
        children: [
          responsiveSizedBox(context: context , percentageOfHeight: .1),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width(context) * 0.1),
              color: backGroundColor
            ),
              child: Image.asset("assets/icons/perfume (1).png" , width: width(context)*.7,color: mainColor,),
          ),
          responsiveSizedBox(context: context , percentageOfHeight: .04),
          customDescriptionText(context: context , textColor: mainColor , text: "No Products Yet !" , percentageOfHeight: .03) ,
          responsiveSizedBox(context: context , percentageOfHeight: .02),






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