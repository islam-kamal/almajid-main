import 'dart:async';
import 'dart:convert';
import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Bloc/Home_Bloc/home_bloc.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
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
        print('--- token -- : ${await sharedPreferenceManager.readString(
            CachingKey.AUTH_TOKEN)}');
        checkAuthentication(
            await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
        //  checkAuthentication('tda5h42j6mke2q43da55wckmoeynz1n1');
      } catch (e) {
        checkAuthentication(null);
      }
    });
  }
  @override
  void didChangeDependencies() async{
    print("quote : ${    await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}");
    await sharedPreferenceManager.readString(CachingKey.CART_QUOTE).then((value) => (){
      print("!!!!!!!!!! : ${value}");

/*      if(value ==null){
            print("!!!!!!!!!! : ${value}");
        cartRepository.create_quote(context: context);
      }*/
    });
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

      new CircularProgressIndicator();
      print("1111111111");
      await categoryBloc.add(getAllCategories());
      readJson(token);
     await Future.delayed(Duration(seconds: 3));


    } else {
      new CircularProgressIndicator();
      print("1111111111");
      await categoryBloc.add(getAllCategories());


      readJson(token);
      await Future.delayed(Duration(seconds: 3));


    }
  }

  Future<void> readJson(String token) async {
    print("readJson 1");
    final response = await http.get(
      Uri.parse("${Urls.BASE_URL}/media/mobile/config.json"
      ),
      headers: {"charset": "utf-8", "Accept-Charset": "utf-8"}
    );
    print("readJson 2");
    // json.decode(utf8.decode(response?.bodyBytes));
    StaticData.data = await json.decode(utf8.decode(response.bodyBytes));
    print("readJson 3");
    print(" json file data  : ${ StaticData.data }");
    if (StaticData.data != null) {
      print("readJson 4");
      home_bloc.add(GetHomeNewArrivals(
          category_id: StaticData.data['new-arrival']['id'],
          offset: 1
      ));
      print("readJson 5");
      home_bloc.add(GetHomeBestSeller(
          category_id: StaticData.data['best-seller']['id'],
          offset: 1
      ));
    }
    print("readJson 6");
    StaticData.gallery = StaticData.data["slider"];
    print("readJson 7");
    print("gallery : ${StaticData.gallery}");
    print(StaticData.gallery[0]['url']);
    StaticData.gallery.forEach((element) {
      StaticData.images.add(element['url']);
    });
    print("readJson 8");
    if(token.isEmpty){
      print("------------------------ bbbbbbbbbbbbbbbbbbbbb   --------------");
 /*     isFirstTime().then((isFirstTime) {
        print("isFirstTime : ${isFirstTime}");
        cartRepository.create_quote(context: context);

        isFirstTime ?   Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
                      return CustomCircleNavigationBar(page_index: 2,);
            },
            transitionsBuilder:
                (context, animation8, animation15, child) {
              return FadeTransition(
                opacity: animation8,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 10),
          ),
        ) : Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return IntroScreen();
            },
            transitionsBuilder:
                (context, animation8, animation15, child) {
              return FadeTransition(
                opacity: animation8,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 10),
          ),
        )  ;

      });*/
      CustomComponents.isFirstTime().then((isFirstTime) {
        print("isFirstTime : ${isFirstTime}" );
        isFirstTime ?Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return  CustomCircleNavigationBar(page_index: 2,);
            },
            transitionsBuilder:
                (context, animation8, animation15, child) {
              return FadeTransition(
                opacity: animation8,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 10),
          ),
        ) :
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return IntroScreen(
              );
            },
            transitionsBuilder:
                (context, animation8, animation15, child) {
              return FadeTransition(
                opacity: animation8,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 10),
          ),
        );
      });
    }else{


      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => CustomCircleNavigationBar(page_index: 2,)
      ));
    }
    print("3");
  }

  static Future<bool> isFirstTime() async {
    bool isFirstTime = await sharedPreferenceManager.readBoolean(
        CachingKey.FRIST_TIME);
    if (isFirstTime != null && !isFirstTime) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, true);
      return false;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, false);
      return true;
    }
  }
}
