import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:almajidoud/Base/Localization/app_localization.dart';
import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/Repository/WishListRepo/wishlist_repository.dart';
import 'package:almajidoud/main.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Widgets/customWidgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'intro_screen.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticData.vistor_value = null; // clear vistor state
    StaticData.wishlist_items = [];
    _showVersionChecker(context);

  }
  void get_wishlist_ids()async {
    await sharedPreferenceManager.getListOfMaps('wishlist_data_ids').then((
        value) {
      StaticData.wishlist_items = value;
    });

  }

  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child:  Scaffold(
            backgroundColor: blackColor,
            body: Center(child: Stack(children: [
              Container(width: width(context), height: height(context),
                child: Image.asset(
                  "assets/images/back.png", fit: BoxFit.cover,),),
              Container(width: width(context), height: height(context),
                child: Center(
                  child: Container(
                      width: width(context) * .5, height: height(context) * .5,
                      child: Image.asset(
                        "assets/icons/logo.png", fit: BoxFit.contain,)),
                ),),
            ],))),

    );
  }

  void checkAuthentication(String token) async {
    if (token.isEmpty) {
      StaticData.vistor_value = 'visitor';
    }

    new CircularProgressIndicator();
  //  await categoryBloc.add(getAllCategories());

     categoryBloc.add(getAllCategories());
    await Future.delayed(Duration.zero);

    readJson(token);
    await Future.delayed(Duration(seconds: 3));
   get_wishlist_ids();

  }

  Future<void> readJson(String token) async {

    await http.get(
      Uri.parse("${Urls.BASE_URL}/media/mobile/config.json"
      ),
      headers: {"charset": "utf-8", "Accept-Charset": "utf-8"}
    ).then((value) async {
      StaticData.data = await json.decode(utf8.decode(value.bodyBytes));
      StaticData.gallery = StaticData.data["slider"];
      StaticData.apple_pay_activation = StaticData.data["apple-pay"];
      StaticData.excludedIds = StaticData.data["excluded_ids"];

    });



    StaticData.gallery.forEach((element) {
      StaticData.slider.add(SliderImage(
        id: element['id'],
        url: element['url'],
        english_name: element['english_name'],
        arabic_name: element['arabic_name'],
        type: element['type'],
      ));
    });


    if(token.isEmpty){
      CustomComponents.isFirstTime().then((isFirstTime) async {
        if(isFirstTime){
        //  await search_bloc.add(SearchProductsEvent(search_text: ''));
              search_bloc.add(SearchProductsEvent(search_text: ''));

          customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 2,));
        }else{
        //  sharedPreferenceManager.writeData(CachingKey.USER_COUNTRY_CODE, "sa");
         // await search_bloc.add(SearchProductsEvent(search_text: ''));

           search_bloc.add(SearchProductsEvent(search_text: ''));

          customAnimatedPushNavigation(context, IntroScreen());
        }


      });
    }else{
      wishListRepository.getWishListIDS(context);
     // await search_bloc.add(SearchProductsEvent(search_text: ''));
       search_bloc.add(SearchProductsEvent(search_text: ''));
      customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 2,));
    }
  }

  void authetication_fun(){
    Timer(Duration(seconds: 0), () async {
      try {
        checkAuthentication(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      } catch (e) {
        checkAuthentication(null!);
      }
    });
  }

  _showVersionChecker(BuildContext context) async {

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String? buildNumber = packageInfo.buildNumber;
    String urlAndroid = "https://play.google.com/store/apps/details?id=com.mobile.Almajed4Oud";
    String urlIos =     "https://apps.apple.com/us/app/almajed-4-oud/id1604357151";
    Dio dio = new Dio();
    await dio.get(Urls.BASE_URL+ '/index.php/rest/V1/mstore/app-version/${buildNumber}',
        options: Options(
            headers:  {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
            }
        )).then((value) async {
      if (value.data['status']) {
        authetication_fun();
      }
      else {

        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "update_app".tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            content: Text("update_avilable_content".tr()),
            actions: [
              TextButton(
                child: Text("cancel".tr()),
                onPressed: () {
                  SystemNavigator.pop();
                },
              ),
              TextButton(
                child:
                Text("update_now".tr()),
                onPressed: () {
                  Platform.isAndroid
                      ? _launchURL(urlAndroid)
                      : _launchURL(urlIos);
                },
              )
            ],
          ),
        );
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
