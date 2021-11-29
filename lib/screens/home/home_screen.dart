import 'dart:async';
import 'dart:convert';

import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
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
/*  List<dynamic> gallery = [];
  List images = [];
  var data;
  Future<void> readJson() async {
    print("1");
    final  response = await http.get(Uri.parse("${Urls.BASE_URL}/media/mobile/config.json"),
     );
     data = await json.decode(response.body);
  //  gallery =data['slider'];

    if(data != null){
      home_bloc.add(GetHomeNewArrivals(
        category_id: data['new-arrival']['id'],
        offset: 1
      ));
      home_bloc.add(GetHomeBestSeller(
         category_id: data['best-seller']['id'],
        offset: 1
      ));
    }
    setState(() {
      gallery = data["slider"];

      print("gallery : ${gallery}");
      print(gallery[0]['url']);
      gallery.forEach((element) {
        images.add(element['url']);
      });
    });
    print("3");

  }*/

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
          body: Container(
              height: height(context),
              width: width(context),
              child: Stack(
                children: [
                  Container(
                    height: height(context),
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            responsiveSizedBox(context: context, percentageOfHeight: .1),
                            titleText(context: context, text: "Shop By Category"),
                            responsiveSizedBox(context: context, percentageOfHeight: .02),
                            CategoriesButtons(),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .009),
                            HomeSlider(
                              gallery:StaticData.images
                            ),


                            responsiveSizedBox(context: context, percentageOfHeight: .02),
                            titleText(context: context,
                                text: translator.currentLanguage == 'ar' ?  StaticData.data['new-arrival']['arabic-title']
                                                                                : StaticData.data['new-arrival']['english-title']),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),

                            HomeListProducts(
                              type: "New Arrivals",
                            ),



                            responsiveSizedBox(
                                context: context, percentageOfHeight: .02),
                            HomeSlider(
                                gallery:StaticData.images
                            ),
                            responsiveSizedBox(context: context, percentageOfHeight: .02),
                            titleText(context: context,
                                text: translator.currentLanguage == 'ar' ? StaticData.data['best-seller']['arabic-title'] :
                                          StaticData.data['best-seller']['english-title']),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),

                            HomeListProducts(
                              type: "best-seller",
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
                        ),
                      ],
                    ),
                  ),
                ],
              )),

          drawer: SettingsDrawer(
            node: fieldNode,
          ),

        ),
      ),
    );
  }

}
