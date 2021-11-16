import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/categories_buttons.dart';
import 'package:almajidoud/screens/home/widgets/home_list_products.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/home/widgets/title_text.dart';
import 'package:almajidoud/screens/home/widgets/top_slider.dart';
import 'package:almajidoud/screens/location/widgets/location_bottom_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}
class _LocationScreenState extends State<LocationScreen> {
  FocusNode fieldNode = FocusNode();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child:Scaffold(
      key: _drawerKey,
      backgroundColor: whiteColor,
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
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .13),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    titleText(context: context, text: "Shop By Category"),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    CategoriesButtons(),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .002),
                    HomeSlider(
                        gallery:StaticData.images
                    ),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    titleText(context: context, text: "New Arrivals"),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    HomeListProducts(
                      type: "New Arrivals",
                    ),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .01),
                    HomeSlider(
                        gallery:StaticData.images
                    ),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .11),
                  ],
                )),
              ),
              Container(
                color: mainColor.withOpacity(.7),
                height: height(context) * .95,
                width: width(context),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .35),
                    Image.asset("assets/icons/location2.png"),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .05),
                    customDescriptionText(
                        context: context,
                        textColor: whiteColor,
                        text: "Your location is :",
                        percentageOfHeight: .03),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .05),
                    Container(width: width(context)*.7,height: isLandscape(context) ? 2*height(context)*.08: height(context)*.08,
                    decoration: BoxDecoration(border: Border.all(color: whiteColor) ),child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Container(width: width(context)*.1,height: isLandscape(context) ? 2*height(context)*.03: height(context)*.03,
                        child: Image.network(
                            "https://www.almrsal.com/wp-content/uploads/2019/03/%D8%B9%D9%84%D9%85-%D8%A7%D9%84%D9%85%D9%85%D9%84%D9%83%D8%A9-%D8%A7%D9%84%D8%B9%D8%B1%D8%A8%D9%8A%D8%A9-%D8%A7%D9%84%D8%B3%D8%B9%D9%88%D8%AF%D9%8A%D8%A9-%D8%AD%D8%A7%D9%84%D9%8A%D8%A7.png"),
                      ) ,
                        SizedBox(width: width(context)*.02,),
                        customDescriptionText(context: context , text: "Saudi Arabia" , textColor: whiteColor
                            , percentageOfHeight: .025 , ) ,
                        SizedBox(width: width(context)*.02,),
                        Icon(Icons.keyboard_arrow_down , color: whiteColor , size:
                        isLandscape(context) ? 2*height(context)*.06: height(context)*.06,)
                      ],),)
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
                      }
                      ,
                    ),

                    locationBottomNavigationBar(context: context)
                  ],
                ),
              ),
            ],
          )),
      drawer: SettingsDrawer(
        node: fieldNode,
      ),
    )));
  }
}
