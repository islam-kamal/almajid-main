import 'package:almajidoud/main.dart';
import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/categories_tap.dart';
import 'package:almajidoud/screens/home/widgets/home_list_products.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';
import 'package:almajidoud/screens/home/widgets/title_text.dart';
import 'package:almajidoud/utils/file_export.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}
class _LocationScreenState extends State<LocationScreen> {
  FocusNode fieldNode = FocusNode();
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var dropdownCountryValue;
  String? flag_image;

  @override
  void initState() {
    switch(MyApp.app_location){
      case 'sa':
        dropdownCountryValue = 'Saudi Arabia';
        flag_image = "assets/flag/saudi.png";
        break;
      case 'kw':
        dropdownCountryValue ='kuwait';
        flag_image = "assets/flag/kuwait.png";
        break;
      case 'uae':
        dropdownCountryValue = 'United Arab Emirates';
        flag_image = "assets/flag/uae.png";
        break;
      case 'bh':
        dropdownCountryValue = 'Bahrain';
        flag_image = "assets/flag/bahrain.png";
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: ()async=>false,
        child: NetworkIndicator(
        child: PageContainer(
            child:Directionality(
                textDirection: MyApp.app_langauge  == 'ar'
                    ?TextDirection.rtl
                    : TextDirection.ltr,
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
                                  flag_image!
             ),
                            ) ,
                            SizedBox(width: width(context)*.02,),
                            DropdownButton<String>(
                                value: dropdownCountryValue,
                                dropdownColor: mainColor.withOpacity(.3),
                                icon: Icon(Icons.keyboard_arrow_down , color: whiteColor , size:
                                isLandscape(context) ? 2*height(context)*.06: height(context)*.06,),
                                iconSize: 42,

                                underline: SizedBox(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    dropdownCountryValue = newValue!;
                                    switch(dropdownCountryValue){
                                      case  'Saudi Arabia':
                                        MyApp.app_location ='sa';
                                        MyApp.country_currency = translator.translate("SAR");
                                        break;
                                      case 'kuwait':
                                        MyApp.app_location = 'kw';
                                        MyApp.country_currency = translator.translate("KWD");
                                        break;
                                      case 'United Arab Emirates':
                                        MyApp.app_location = 'uae';
                                        MyApp.country_currency = translator.translate("AED");
                                        break;
                                      case 'Bahrain':
                                        MyApp.app_location = 'bh';
                                        MyApp.country_currency = translator.translate("BHD");
                                        break;
                                    }

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
                                  "United Arab Emirates",
                                  "Bahrain"
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
                        _drawerKey.currentState!.openDrawer();
                      },
                      home_logo: true,
                    ),

                  ],
                ),
              ),
            ],
          )),
      drawer: SettingsDrawer(
        node: fieldNode,
      ),
    )))));
  }
}
