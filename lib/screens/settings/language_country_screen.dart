import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'dart:ui' as ui;

import 'package:flutter_spinkit/flutter_spinkit.dart';

class LanguageCountryScreen extends StatefulWidget {
  String? type;
  LanguageCountryScreen({this.type});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LanguageCountryScreenState();
  }
}

class LanguageCountryScreenState extends State<LanguageCountryScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List<Country> countries = [];
  var language_list = [];
  var country_name;

  var saved_country_name;
  bool loading = false;
  @override
  void initState() {
    switch(MyApp.app_location){
      case 'sa':
        country_name = 'Saudi Arabia';
        break;
      case 'kw':
        country_name ='kuwait';
        break;
      case 'uae':
        country_name = 'United Arab Emirates';
        break;
      case 'bh':
        country_name = 'Bahrain';
        break;
    }
    saved_country_name = country_name;
    countries
        .add(Country(name: 'Saudi Arabia', photo: "assets/flag/saudi.png"));
    countries.add(Country(name: 'kuwait', photo: "assets/flag/kuwait.png"));
    countries.add(
        Country(name: "United Arab Emirates", photo: "assets/flag/uae.png"));

    countries.add(
        Country(name: "Bahrain", photo: "assets/flag/bahrain.png"));

    if ((widget.type == 'settings' ? MyApp.app_langauge : ui.window.locale.languageCode) == 'ar') {
      MyApp.app_langauge = 'ar';
    } else {
      MyApp.app_langauge = 'en';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.type == 'settings') {
          customAnimatedPushNavigation(context, MyAccountScreen());
          return true;
        } else {
          return false;
        }
      },
      child: NetworkIndicator(
          child: PageContainer(
        child: Scaffold(
          key: _scaffoldKey,
          appBar: widget.type == 'settings'
              ? AppBar(
                  title: Text(
                    translator.translate("Settings"),
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.normal),
                  ),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: mainColor,
                    onPressed: () {
                      customAnimatedPushNavigation(
                          context,
                          CustomCircleNavigationBar(
                            page_index:
                                translator.activeLanguageCode == 'ar' ? 4 : 0,
                          ));
                    },
                  ),
                )
              : null,
          body: Container(
              width: width(context),
              height: height(context),
              decoration: BoxDecoration(color: small_grey),
              child: Padding(
    padding: EdgeInsets.symmetric(
    vertical: width(context) * 0.2,
      horizontal: width(context) * 0.25,
    ),
    child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/icons/logo.png",color: mainColor,)

                ],
              )
              )
          ),
          bottomSheet: BottomSheet(
            onClosing: () {},
            backgroundColor: small_grey,
            builder: (context) {
              return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                      height: height(context) * 0.55,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(height(context) * .05),
                              topLeft: Radius.circular(height(context) * .05))),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  translator.translate("Select Language"),
                                  style:
                                      TextStyle(color: mainColor, fontSize: 14),
                                ),
                              )),
                          Expanded(
                            flex: 2,
                            child: Center(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (MyApp.app_langauge == 'en') {
                                      final newLang = 'ar';
                                      _changeLang(lang: newLang);
                                    } else {}
                                  },
                                  child: new Container(
                                    width: width(context) * 0.2,
                                    height: width(context) * 0.2,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: MyApp.app_langauge == 'ar'
                                            ? Border.all(
                                                color: mainColor, width: 3)
                                            : Border.all(
                                                color: greyColor, width: 3)),
                                    child: new Text(
                                      "????????",
                                      style: new TextStyle(
                                        color: mainColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: width(context) * 0.1,
                                ),
                                InkWell(
                                  onTap: () {
                                    if (MyApp.app_langauge == 'ar') {
                                      final newLang = 'en';
                                      _changeLang(lang: newLang);
                                    } else {}
                                  },
                                  child: new Container(
                                    width: width(context) * 0.2,
                                    height: width(context) * 0.2,
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: MyApp.app_langauge == 'ar'
                                            ? Border.all(
                                                color: greyColor, width: 3)
                                            : Border.all(
                                                color: mainColor, width: 3)),
                                    child: new Text(
                                      "English",
                                      style: new TextStyle(
                                        color: mainColor,
                                      ),
                                      textAlign: TextAlign.center,
                                    ), // You can add a Icon instead of text also, like below.
                                  ),
                                ),
                              ],
                            )),
                          ),
                          Divider(
                            color: mainColor,
                          ),
                          Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  translator.translate("Select Country"),
                                  style:
                                      TextStyle(color: mainColor, fontSize: 14),
                                ),
                              )),
                          Expanded(
                              flex: 3,
                              child: Center(
                                  child:Directionality(
                                      textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                                      child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: countries.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    country_name = countries[index].name!;

                                                    switch(country_name){
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

                                                    shoppingCartBloc.add(GetCartDetailsEvent());
                                                  });
                                                },
                                                child: new Container(
                                                    width: width(context) * 0.2,
                                                    height:
                                                        width(context) * 0.2,
                                                    alignment: Alignment.center,
                                                    decoration: new BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: country_name ==
                                                                countries[index]
                                                                    .name
                                                            ? Border.all(
                                                                color:
                                                                    mainColor,
                                                                width: 3)
                                                            : Border.all(
                                                                color:
                                                                    greyColor,
                                                                width: 3)),
                                                    child: Image.asset(
                                                        countries[index].photo!)),
                                              ),
                                              Text(countries[index].name == "United Arab Emirates"
                                                  ? "United Arab Emirates".tr() : countries[index].name!.tr())
                                            ],
                                          ),
                                        );
                                      })
                                  )
                              )),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () async {
                                  setState(() {
                                    loading = true;
                                  });
                                  if (widget.type == 'settings') {
                                    if(StaticData.vistor_value == 'visitor'){
                                      if (saved_country_name == country_name) {
                                      } else {
                                        sharedPreferenceManager.removeData(CachingKey.GUEST_CART_QUOTE);
                                        cartRepository.create_quote(context: context);
                                      }
                                      await categoryRepository.getCategoriesList().then((value) {
                                        categoryBloc.set_category_subject(value);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CustomCircleNavigationBar(
                                                      page_index: MyApp.app_langauge == 'ar' ? 4 : 0,
                                                    ))
                                        );
                                      });

                                    }
                                    else{
                                      if (saved_country_name == country_name) {
                                        cartRepository.create_quote(context: context);
                                        await categoryRepository.getCategoriesList().then((value) {
                                          categoryBloc.set_category_subject(value);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CustomCircleNavigationBar(
                                                        page_index: MyApp.app_langauge == 'ar' ? 4 : 0,
                                                      )));
                                        });

                                      } else {
                                        sharedPreferenceManager.writeData(CachingKey.USER_COUNTRY_CODE, MyApp.app_location);
                                        sharedPreferenceManager.removeData(CachingKey.CART_QUOTE);
                                        sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
                                        sharedPreferenceManager.removeData(CachingKey.CUSTOMER_ID);
                                        customAnimatedPushNavigation(context, SignInScreen());
                                      }
                                    }


                                  }

                                  else {
                                    cartRepository.create_quote(context: context);

                                    await categoryRepository.getCategoriesList().then((value) {
                                      categoryBloc.set_category_subject(value);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CustomCircleNavigationBar(
                                                )),
                                      );
                                    });
                                  }

                            /*      MyApp.country_currency = MyApp.app_location == 'sa' ?translator.translate("SAR")
                                      : MyApp.app_location == 'uae'? translator.translate("AED") : translator.translate("KWD");
*/
                                  switch(MyApp.app_location){
                                    case 'sa':
                                      MyApp.country_currency = translator.translate("SAR");
                                      break;
                                    case 'kw':
                                      MyApp.country_currency = translator.translate("KWD");
                                      break;
                                    case 'uae':
                                      MyApp.country_currency = translator.translate("AED");
                                      break;
                                    case 'bh':
                                      MyApp.country_currency = translator.translate("BHD");
                                      break;
                                  }
                                  setState(() {
                                    loading = false;
                                  });
                                },
                                child:loading ?   Container(
                                  height: 100,
                                  child: Center(
                                    child: SpinKitFadingCube(
                                      color: Theme.of(context).primaryColor,
                                      size: 30.0,
                                    ),
                                  ),
                                )
                                    :  Container(
                                    width: width(context) * .9,
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Center(
                                        child: customDescriptionText(
                                            context: context,
                                            text: "Continue",
                                            percentageOfHeight: .025,
                                            textColor: whiteColor)),
                                    height: isLandscape(context)
                                        ? 2 * height(context) * .065
                                        : height(context) * .065),
                              ),
                            ),
                          )
                        ],
                      )));
            },
          ),
        ),
      )),
    );
  }

  void _changeLang({String? lang}) async {
    setState(() {
      translator.setNewLanguage(
        context,
        newLanguage: '${lang}',
        remember: true,
        restart: false,
      );
    });
    MyApp.setLocale(context, Locale('${lang}'));
    sharedPreferenceManager.writeData(CachingKey.APP_LANGUAGE, lang);

    cartRepository.updateCartLanguage(context: context);
  }
}

class Country {
  String? name;
  String? photo;
  Country({this.name, this.photo});
}
