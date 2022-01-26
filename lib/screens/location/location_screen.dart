import 'package:almajidoud/main.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/categories_tap.dart';
import 'package:almajidoud/screens/home/widgets/home_list_products.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/home/widgets/title_text.dart';
import 'package:almajidoud/screens/home/widgets/top_slider.dart';
import 'package:almajidoud/utils/file_export.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}
class _LocationScreenState extends State<LocationScreen> {
  FocusNode fieldNode = FocusNode();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var dropdownCountryValue = MyApp.app_location == 'sa' ?      'Saudi Arabia'
      : MyApp.app_location == 'uae' ? 'United Arab Emirates': 'kuwait';
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
                    responsiveSizedBox(context: context, percentageOfHeight: .11),
                    titleText(context: context, text: "Shop By Category"),
                    responsiveSizedBox(context: context, percentageOfHeight: .02),
                    CategoriesTap(),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .009),
                    HomeSlider(
                        gallery:StaticData.slider
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

                  Directionality(textDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                      child:   Container(
                        width: width(context)*.8,
                        height: isLandscape(context) ? 2*height(context)*.08: height(context)*.08,
                        decoration: BoxDecoration(border: Border.all(color: greyColor) ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width(context)*.1,
                              height: isLandscape(context) ? 2*height(context)*.03: height(context)*.03,
                              child: Image.asset(
                                  dropdownCountryValue == 'Saudi Arabia'?    "assets/flag/saudi.png"
                                      : dropdownCountryValue == "United Arab Emirates" ? "assets/flag/uae.png" : "assets/flag/kuwait.png"),
                            ) ,
                            SizedBox(width: width(context)*.02,),
                            DropdownButton<String>(
                                value: dropdownCountryValue,
                                dropdownColor: mainColor.withOpacity(.3),
                                icon: Icon(Icons.keyboard_arrow_down , color: whiteColor , size:
                                isLandscape(context) ? 2*height(context)*.06: height(context)*.06,),
                                iconSize: 42,

                                underline: SizedBox(),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownCountryValue = newValue;
                                    MyApp.app_location = newValue == 'Saudi Arabia' ? 'sa'
                                        :newValue =="United Arab Emirates" ? 'uae' :  'kw';
                                    MyApp.country_currency = MyApp.app_location == 'sa' ?translator.translate("SAR")
                                        : MyApp.app_location == 'uae'? translator.translate("AED") :   translator.translate("KWD");
                                    sharedPreferenceManager.writeData(CachingKey.USER_COUNTRY_CODE, MyApp.app_location );
                                    if(StaticData.vistor_value == 'visitor'){
                                      MyApp.restartApp(context);
                                    }else{
                                      sharedPreferenceManager.removeData(CachingKey.CART_QUOTE);
                                      sharedPreferenceManager.removeData(CachingKey.GUEST_CART_QUOTE);
                                      sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
                                      sharedPreferenceManager.removeData(CachingKey.CUSTOMER_ID);
                                      customAnimatedPushNavigation(context, SignInScreen());
                                    }

                                  });
                                },
                                items: <String>[
                                  'Saudi Arabia',
                                  'kuwait',
                                  "United Arab Emirates"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                      value:  value,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: Text(
                                          value,
                                          textDirection:MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                          style: TextStyle(color: whiteColor),),
                                      )    
                                  );
                                }).toList()),

                          ],),))
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
    )));
  }
}
