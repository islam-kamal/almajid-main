import 'dart:async';
import 'package:almajidoud/screens/intro/intro1_screen.dart';
import 'package:almajidoud/screens/intro/intro2_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => IntroScreen())));
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
}
