import 'dart:async';
import 'dart:convert';

import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/categories_buttons.dart';
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
                            titleText(context: context, text: "Shop By Category"),
                            responsiveSizedBox(context: context, percentageOfHeight: .02),
                            CategoriesButtons(),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .009),
                            HomeSlider(
                              gallery:StaticData.images
                            ),


                            responsiveSizedBox(context: context, percentageOfHeight: .03),
                            titleText(context: context,
                                text: translator.activeLanguageCode == 'ar' ?  StaticData.data['new-arrival']['arabic-title']
                                                                                : StaticData.data['new-arrival']['english-title']),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),

                            HomeListProducts(
                              type: "New Arrivals",
                              homeScaffoldKey: _drawerKey,
                            ),

                            responsiveSizedBox(context: context, percentageOfHeight: .03),
                            titleText(context: context,
                                text: translator.activeLanguageCode == 'ar' ? StaticData.data['best-seller']['arabic-title'] :
                                          StaticData.data['best-seller']['english-title']),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),

                            HomeListProducts(
                              type: "best-seller",
                              homeScaffoldKey: _drawerKey,

                            ),

                          ],
                        )),
                  ),
                  Container(
                    height: height(context),
                    width: width(context),
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
              ) )),

          drawer: SettingsDrawer(
            node: fieldNode,
          ),

        ),
      ),
    );
  }

}
