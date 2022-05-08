import 'dart:async';
import 'dart:convert';
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
import 'intro_screen.dart';
import 'package:http/http.dart' as http;

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
    Timer(Duration(seconds: 0), () async {
      try {
        checkAuthentication(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      } catch (e) {
        checkAuthentication(null!);
      }
    });
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
      child: PageContainer(
        child: Scaffold(
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
      ),
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

    final response = await http.get(
      Uri.parse("${Urls.BASE_URL}/media/mobile/config.json"
      ),
      headers: {"charset": "utf-8", "Accept-Charset": "utf-8"}
    );
    StaticData.data = await json.decode(utf8.decode(response.bodyBytes));
    StaticData.gallery = StaticData.data["slider"];

    StaticData.apple_pay_activation = StaticData.data["apple-pay"];

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

}
