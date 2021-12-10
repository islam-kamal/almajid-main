import 'dart:async';
import 'dart:convert';
import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/Repository/WishListRepo/wishlist_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/intro/intro1_screen.dart';
import 'package:almajidoud/screens/intro/intro2_screen.dart';
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

    Timer(Duration(seconds: 0), () async {
      try {
        print('--- token -- : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
        checkAuthentication(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
      } catch (e) {
        checkAuthentication(null);
      }
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
    await search_bloc.add(SearchProductsEvent(search_text: ''));
    await categoryBloc.add(getAllCategories());
    readJson(token);
    await Future.delayed(Duration(seconds: 3));
  }

  Future<void> readJson(String token) async {
    final response = await http.get(
      Uri.parse("${Urls.BASE_URL}/media/mobile/config.json"
      ),
      headers: {"charset": "utf-8", "Accept-Charset": "utf-8"}
    );
    StaticData.data = await json.decode(utf8.decode(response.bodyBytes));
    if (StaticData.data != null) {
      home_bloc.add(GetHomeNewArrivals(
          category_id: StaticData.data['new-arrival']['id'],
          offset: 1
      ));
      home_bloc.add(GetHomeBestSeller(
          category_id: StaticData.data['best-seller']['id'],
          offset: 1
      ));
    }
    StaticData.gallery = StaticData.data["slider"];
    print(StaticData.gallery[0]['url']);
    StaticData.gallery.forEach((element) {
      StaticData.images.add(element['url']);
    });

    if(token.isEmpty){
      CustomComponents.isFirstTime().then((isFirstTime) {
        isFirstTime ?  customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 2,))
          : customAnimatedPushNavigation(context, IntroScreen());

      });
    }else{
      wishListRepository.getWishListIDS(context);
      print("*******######*****8888");
      customAnimatedPushNavigation(context, CustomCircleNavigationBar(page_index: 2,));
    }
    print("3");
  }

}
