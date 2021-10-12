import 'dart:async';
import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/screens/intro/intro1_screen.dart';
import 'package:almajidoud/screens/intro/intro2_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
/*  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IntroScreen())));
  }*/
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticData.vistor_value = null; // clear vistor state

    Timer(Duration(seconds: 0), () async {
      try {
        print('--- token -- : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}');
        //checkAuthentication(await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN));
        checkAuthentication('tda5h42j6mke2q43da55wckmoeynz1n1');
      } catch (e) {
        checkAuthentication(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
        body: Center(child: Stack(children: [
          Container(width: width(context),height: height(context),
            child: Image.asset("assets/images/back.png" , fit: BoxFit.cover,),),
          Container(width: width(context),height: height(context),
            child: Center(
              child: Container(
                  width: width(context)*.5,height: height(context)*.5,
                  child: Image.asset("assets/icons/logo.png" , fit: BoxFit.contain,)),
            ),),
        ],)));
  }

  void checkAuthentication(String token) async {
    if (token.isEmpty) {
      await Future.delayed(Duration(seconds: 4));
      StaticData.vistor_value = 'visitor';
      isFirstTime().then((isFirstTime) {
        print("isFirstTime : ${isFirstTime}" );
/*
        Navigator.push(
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
        );
*/

        isFirstTime ? Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return  HomeScreen();
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
        );
      });

    } else {
      new CircularProgressIndicator();
      print("1111111111");
      await categoryBloc.add(getAllCategories()); // refresh token

      // await offersBloc.add(getAllOffers());
      //  await recommended_product_bloc.add(getRecommendedProduct_click());
      await Future.delayed(Duration(seconds: 3));
      Navigator.pushReplacement(
          context, MaterialPageRoute(
          builder: (context) => HomeScreen()
      ));
    }

  }
  static Future<bool> isFirstTime() async {
    bool isFirstTime = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_TIME);
    if (isFirstTime != null && !isFirstTime) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, true);
      return false;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, false);
      return true;
    }
  }
}
