import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart'
    as product_model;
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

/*newArrivalsListView({BuildContext context}){
  return
  Container(width: width(context),height: isLandscape(context) ?2*height(context)*.25:height(context)*.25,
    child: ListView.builder(itemBuilder: (context , index  ){
      return Row(
        children: [
          SizedBox(width: width(context)*.01) ,
          GestureDetector(onTap:
              (){customAnimatedPushNavigation(context, ProductDetailsScreen());},
            child: Neumorphic(
              style:
              NeumorphicStyle(
                border: NeumorphicBorder(color: mainColor ),
                  shape: NeumorphicShape.flat,
                  color: whiteColor , depth: 5 ,
                  shadowDarkColor: greyColor , lightSource: LightSource.left,),
              child: Container(decoration: BoxDecoration(border: Border.all(color: mainColor.withOpacity(.2)) ,
                  borderRadius: BorderRadius.circular(0)),
                  child: Stack(children: [
              Column(
                children: [
                  Container(
                    width: width(context)*.32,height:  isLandscape(context) ?2*height(context)*.12:height(context)*.12, decoration:
                  BoxDecoration(image: DecorationImage
                    (image:NetworkImage
                    ("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),fit: BoxFit.cover)),
                  ) ,  Container(color: whiteColor,
                      child: Column(children: [
                        responsiveSizedBox(context: context , percentageOfHeight: .005),
                        customDescriptionText(context: context , textColor: mainColor
                            , text: "Lorim" ,
                            maxLines: 2 , percentageOfHeight: .017),
                        responsiveSizedBox(context: context , percentageOfHeight: .005),
                        customDescriptionText(context: context , textColor: mainColor
                            , text: " \$ 2000" ,
                            maxLines:1, percentageOfHeight: .017 , fontWeight: FontWeight.bold) ,
                        responsiveSizedBox(context: context , percentageOfHeight: .0105),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                         Icon(Icons.shopping_cart_outlined , color: mainColor ,),
                          SizedBox(
                            width: width(context)*.02,
                          ),
                          Icon(Icons.share_outlined , color: mainColor ,)


                        ],)
                      ],),
                    width: width(context)*.32,height:  isLandscape(context) ?2*height(context)*.12 :height(context)*.12 )
                ],
              ),
                Container(padding: EdgeInsets.only(top:  isLandscape(context) ?2*height(context)*.005 :height(context)*.005
                    , right: width(context)*.02),
                  alignment: Alignment.topRight,
                    child: Icon(Icons.favorite_border , color: mainColor,),

                    width: width(context)*.32,height:  isLandscape(context) ?2*height(context)*.25:height(context)*.25
                )
              ],),
      width: width(context)*.32,height:  isLandscape(context) ?2*height(context)*.3:height(context)*.3),
            ),
          )

        ],
      );

    } , itemCount: 10 , scrollDirection: Axis.horizontal),
  );
}*/

class HomeListProducts extends StatefulWidget {
  final String type;
  HomeListProducts({this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeListProductsState();
  }
}

class HomeListProductsState extends State<HomeListProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: home_bloc,
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Done) {
            var data = state.model as ProductModel;
            if (data.items == null || data.items.isEmpty) {
              return Container();
            } else {
              print("111111111111111");

              return StreamBuilder<List<product_model.Items>>(
                stream: widget.type == 'best-seller'
                    ? home_bloc.best_seller_products_subject
                    : home_bloc.new_arrivals_products_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      print("length : ${snapshot.data.length}");

                      return Container(
                          width: width(context),
                          height: isLandscape(context)
                              ? 2 * height(context) * .25
                              : height(context) * .25,
                          child: ListView.builder(
                              itemCount: snapshot.data.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.only(
                                    left: 5,
                                    right: 5,
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      customAnimatedPushNavigation(
                                          context, ProductDetailsScreen(
                                         product: snapshot.data[index],
                                      ));
                                    },
                                    child: Neumorphic(
                                      style: NeumorphicStyle(
                                        border:
                                            NeumorphicBorder(color: mainColor),
                                        shape: NeumorphicShape.flat,
                                        color: whiteColor,
                                        depth: 5,
                                        shadowDarkColor: greyColor,
                                        lightSource: LightSource.left,
                                      ),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: mainColor
                                                      .withOpacity(.2)),
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          child: Stack(
                                            children: [
                                              Column(
                                                children: [
                                                  Container(
                                                    width: width(context) * .32,
                                                    height: isLandscape(context)
                                                        ? 2 *
                                                            height(context) *
                                                            .12
                                                        : height(context) * .12,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                snapshot
                                                                    .data[index]
                                                                    .customAttributes[0].value),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Container(
                                                      color: whiteColor,
                                                      child: Column(
                                                        children: [
                                                          responsiveSizedBox(
                                                              context: context,
                                                              percentageOfHeight:
                                                                  .005),
                                                          customDescriptionText(
                                                              context: context,
                                                              textColor:
                                                                  mainColor,
                                                              text: snapshot.data[index].name,
                                                              maxLines: 2,
                                                              percentageOfHeight:
                                                                  .017),
                                                          responsiveSizedBox(
                                                              context: context,
                                                              percentageOfHeight:
                                                                  .005),
                                                          customDescriptionText(
                                                              context: context,
                                                              textColor:
                                                                  mainColor,
                                                              text:
                                                                  " \$ ${snapshot.data[index].price}",
                                                              maxLines: 1,
                                                              percentageOfHeight:
                                                                  .017,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          responsiveSizedBox(
                                                              context: context,
                                                              percentageOfHeight:
                                                                  .0105),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .share_outlined,
                                                                color:
                                                                    mainColor,
                                                              ),
                                                              SizedBox(
                                                                width: width(
                                                                        context) *
                                                                    .02,
                                                              ),
                                                              Icon(
                                                                Icons
                                                                    .shopping_cart_outlined,
                                                                color:
                                                                    mainColor,
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      width:
                                                          width(context) * .32,
                                                      height: isLandscape(
                                                              context)
                                                          ? 2 *
                                                              height(context) *
                                                              .12
                                                          : height(context) *
                                                              .12)
                                                ],
                                              ),
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      top: isLandscape(context)
                                                          ? 2 *
                                                              height(context) *
                                                              .005
                                                          : height(context) *
                                                              .005,
                                                      right:
                                                          width(context) * .02),
                                                  alignment: Alignment.topRight,
                                                  child: Icon(
                                                    Icons.favorite_border,
                                                    color: mainColor,
                                                  ),
                                                  width: width(context) * .32,
                                                  height: isLandscape(context)
                                                      ? 2 *
                                                          height(context) *
                                                          .25
                                                      : height(context) * .25)
                                            ],
                                          ),
                                          width: width(context) * .32,
                                          height: isLandscape(context)
                                              ? 2 * height(context) * .3
                                              : height(context) * .3),
                                    ),
                                  ),
                                );
                              }));
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
            return Container();
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}