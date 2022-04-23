import 'package:almajidoud/Bloc/StoreLocator_Bloc/store_locator_bloc.dart';
import 'package:almajidoud/Model/StoreLocatorModel/store_locator_model.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/web_view/webview.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StoreLocatorScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StoreLocatorScreenState();
  }

}

class StoreLocatorScreenState extends State<StoreLocatorScreen>{
  TextEditingController? controller ;
  String search_text='';
  GlobalKey<ScaffoldState> scaffold_key = GlobalKey();
  @override
  void initState() {
    controller = TextEditingController();
    store_locator_bloc.add(GetAllStoreLocatoreEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: WillPopScope(
          onWillPop: ()async{
            customAnimatedPushNavigation(context, CustomCircleNavigationBar(
              page_index: MyApp.app_langauge =='ar' ? 4 : 0,
            ));
            return null!;
          },
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: whiteColor,
              title: Text( translator.translate("Our Locations"),style: TextStyle(fontWeight: FontWeight.normal,color: mainColor,),),
              leading: IconButton(
                onPressed: (){
                  customAnimatedPushNavigation(context, CustomCircleNavigationBar(
                    page_index: MyApp.app_langauge =='ar' ? 4 : 0,
                  ));
                },
                icon: Icon(Icons.arrow_back_ios,color: mainColor,),
              ),

            ),
            body: Container(
              height: height(context),
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      automaticallyImplyLeading: false,
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
                body: Container(
                    child: StreamBuilder<List<StoreLocatorModel>>(
                      stream: store_locator_bloc.store_locator_subject,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == null) {
                            return Center(
                              child: no_data_widget(
                                  context: context,
                                  message: translator.translate("There is no Stores Yet")
                              ),
                            );
                          } else {
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return snapshot.data![index] == null
                                      ? Container()
                                      :  snapshot.data![index].city.toString().toLowerCase().contains(search_text)
                                      ? Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8),

                                        child: Directionality(
                                            textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr ,
                                            child: Container(
                                              padding: EdgeInsets.all(width(context) * .05),
                                              decoration: BoxDecoration(color: backGroundColor,
                                                border: Border.all(color: greyColor),),

                                              child:Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: translator.activeLanguageCode == 'en' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                                                children: [
                                                 Align(
                                                   alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
                                                   child:  Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                        Expanded(
                                                          flex:2,
                                                          child:   customDescriptionText(
                                                          context: context,
                                                          textColor: mainColor,
                                                          maxLines: 2,
                                                          text: snapshot.data![index].city,
                                                        ),),
                                                      Expanded(
                                                        flex:1,
                                                        child:Text("    |    ",textAlign: TextAlign.end,)),
                                                      Expanded(
                                                        flex:7,
                                                        child:   Container(
                                                           // width: width(context) * 0.6,
                                                            alignment: translator.activeLanguageCode == 'en' ? Alignment.centerLeft :Alignment.centerRight,
                                                            child:  customDescriptionText(
                                                              context: context,
                                                              textColor: mainColor,
                                                              maxLines: 2,
                                                              text: snapshot.data![index].name,
                                                            )  ),
                                                          )
                                                        ],
                                                      ),
                                                    ),

                                                   Align(
                                                      child:   Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                        Expanded(
                                                        flex:2,
                                                        child:  customDescriptionText(
                                                            context: context,
                                                            textColor: mainColor,
                                                            maxLines: 2,
                                                            text: translator.translate("Address"),
                                                        ) ),
                                                      Expanded(
                                                        flex:1,
                                                        child:   Text(" : ",textAlign: TextAlign.end,)
                                                      ),
                                                      Expanded(
                                                        flex:7,
                                                        child:   Container(
                                                          padding: EdgeInsets.symmetric(horizontal: 5),
                                                            alignment: translator.activeLanguageCode == 'en' ? Alignment.centerLeft :Alignment.centerRight,
                                                            child:  customDescriptionText(
                                                              context: context,
                                                              textColor: mainColor,
                                                              maxLines: 2,
                                                              text: snapshot.data![index].address,
                                                            )   ),
                                                          )
                                                        ],
                                                      ),
                                                      alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
                                                    ),

                                                Align(
                                                      child:   Row(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        children: [
                                                        Expanded(
                                                        flex:3,
                                                        child: customDescriptionText(
                                                            context: context,
                                                            textColor: mainColor,
                                                            maxLines: 2,
                                                            text: translator.translate("Phone"),
                                                        )    ),
                                                  Expanded(
                                                    flex:1,
                                                    child:    Text(" : ")
                                                  ),
                                                  Expanded(
                                                    flex:7,
                                                    child:        Container(
                                                            alignment: translator.activeLanguageCode == 'en' ? Alignment.centerLeft :Alignment.centerRight,
                                                            child:  customDescriptionText(
                                                              context: context,
                                                              textColor: mainColor,
                                                              maxLines: 1,
                                                              text: snapshot.data![index].phone,
                                                            ),
                                                    ) )
                                                        ],
                                                      ),
                                                      alignment:translator.activeLanguageCode == 'en' ? Alignment.centerLeft :  Alignment.centerRight,
                                                    ),

                                                  InkWell(
                                                    onTap: (){
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (BuildContext context) => WebView(
                                                                title: "Our Locations",
                                                                url: snapshot.data![index].website,
                                                              ))
                                                      );

                                                    },
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5),
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons.pin_drop),
                                                          Text(translator.translate("Google Maps")),
                                                        ],
                                                      ),
                                                    )
                                                  )
                                                ],
                                              ),
                                            )
                                        ),

                                      ),
                                      // for last element can appear
                                      snapshot.data!.length == index ? Container(
                                        height: width(context) ,
                                      ) : Container()
                                    ],
                                  )
                                   : Container() ;
                                }

                            );

                          }
                        } else if (snapshot.hasError) {
                          return Container(
                            child: Text('${snapshot.error}'),
                          );
                        }
                        else {
                          return   Center(
                            child: SpinKitFadingCube(
                              color: Theme.of(context).primaryColor,
                              size: 30.0,
                            ),

                          );
                          ;
                        }
                      },
                    )

                ),
              ),
            ),
          ),
        ),
      ) ,
    );
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
                      search_text = controller!.value.text;

                    });
                  },
                  style: TextStyle(color: blackColor,
                    fontSize:AlmajedFont.primary_font_size,
                  ),
                  cursorColor: greyColor,
                  decoration: InputDecoration(
                    contentPadding: new EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),

                    suffixIcon:  IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 20,
                      ), onPressed: () {  },

                    ),
                    hintText: translator.translate("Search By City Name"),
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