import 'dart:async';
import 'dart:convert';

import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/categories_tap.dart';
import 'package:almajidoud/screens/home/widgets/home_list_products.dart';
import 'package:almajidoud/screens/home/widgets/title_text.dart';
import 'package:almajidoud/screens/home/widgets/top_slider.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:http/http.dart' as http;
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    FocusNode fieldNode = FocusNode();
    return NetworkIndicator(
      child: PageContainer(
        child: Directionality(
          textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,

          child: Scaffold(
            backgroundColor: whiteColor,
            key: _drawerKey,
            body: GestureDetector(
                onTap: (){
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                },
                child: Container(
                    height: height(context),
                    width: width(context),
                    child: Stack(
                      children: [
                        Container(
                          height: height(context),
                          child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  responsiveSizedBox(context: context, percentageOfHeight: .11),
                                  HomeSlider(
                                      gallery:StaticData.slider),

                                  responsiveSizedBox(context: context, percentageOfHeight: .03),
                                  titleText(context: context, text: translator.activeLanguageCode == 'ar' ?  StaticData.data['new-arrival']['arabic-title'] : StaticData.data['new-arrival']['english-title']),
                                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                                  HomeListProducts(
                                    type: "New Arrivals",
                                    homeScaffoldKey: _drawerKey,
                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                                  banner(
                                      id: StaticData.data["static-banner"]['id'].toString(),
                                      name_ar: StaticData.data["static-banner"]['arabic_name'],
                                      name_en: StaticData.data["static-banner"]['english_name'],
                                      url: StaticData.data["static-banner"]['url']
                                  ),
//-----------------------------------------------------------------------------------------------------------------------
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                                  titleText(context: context,
                                      text: translator.activeLanguageCode == 'ar' ? StaticData.data['best-seller']['arabic-title'] :
                                      StaticData.data['best-seller']['english-title']),
                                  responsiveSizedBox(context: context, percentageOfHeight: .02),


                                  HomeListProducts(
                                    type: "best-seller",
                                    homeScaffoldKey: _drawerKey,

                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),

//-----------------------------------------------------------------------------------------------------------------------
                                  banner(
                                      id: StaticData.data["static-banner-2"]['id'].toString(),
                                      name_ar: StaticData.data["static-banner-2"]['arabic_name'],
                                      name_en: StaticData.data["static-banner-2"]['english_name'],
                                      url: StaticData.data["static-banner-2"]['url']
                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                                  titleText(context: context,
                                      text: translator.activeLanguageCode == 'ar' ? StaticData.data['weekly-deal']['arabic-title'] :
                                      StaticData.data['weekly-deal']['english-title']),
                                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                                  HomeListProducts(
                                    type: "weekly-deal",
                                    homeScaffoldKey: _drawerKey,

                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),

                                  //-----------------------------------------------------------------------------------------------------------------------
                                  banner(
                                      id: StaticData.data["static-banner-3"]['id'].toString(),
                                      name_ar: StaticData.data["static-banner-3"]['arabic_name'],
                                      name_en: StaticData.data["static-banner-3"]['english_name'],
                                      url: StaticData.data["static-banner-3"]['url']
                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),
                                  titleText(context: context,
                                      text: translator.activeLanguageCode == 'ar' ? StaticData.data['testahel-collection']['arabic-title'] :
                                      StaticData.data['testahel-collection']['english-title']),
                                  responsiveSizedBox(context: context, percentageOfHeight: .02),
                                  HomeListProducts(
                                    type: "testahel-collection",
                                    homeScaffoldKey: _drawerKey,

                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .015),

                                  //-----------------------------------------------------------------------------------------------------------------------

                                ],
                              )),
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ScreenAppBar(
                                onTapCategoryDrawer: () {
                                  _drawerKey.currentState.openDrawer();
                                },
                                home_logo: true,

                              ),

                            ],
                          ),
                        ),
                      ],
                    ) )
            ),

            drawer: SettingsDrawer(
              node: fieldNode,
            ),

          ),
        )
      ),
    );
  }

  Widget banner({var name_ar , var name_en , var id , var url} ){
    return    InkWell(
      onTap: (){
        final _catName = translator.activeLanguageCode == 'en'?name_en:name_ar;
        customAnimatedPushNavigation(
            context, CategoryProductsScreen(
          category_id: id,
          category_name: _catName,
        ));
      },
      child: Container(
        width: width(context) ,
        height: isLandscape(context)
            ? 2 * height(context) * .13
            : height(context) * .13,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(url),
                fit: BoxFit.cover)),
      ),
    );
  }
}
