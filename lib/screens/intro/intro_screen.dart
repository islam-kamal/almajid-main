import 'dart:convert';

import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/auth/sign_up_screen.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/settings/language_country_screen.dart';
import 'package:almajidoud/utils/colors.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';
import 'package:localize_and_translate/localize_and_translate.dart';
class IntroScreen extends StatefulWidget {
  IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
  }

  void onDonePress() async{

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguageCountryScreen()),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: blackColor , size: .00001,
    );
  }

  Widget renderDoneBtn() {

    return Container();

  }

  Widget renderSkipBtn() {
    return Icon(
        Icons.navigate_before,
        color: blackColor , size: .00001,
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Color(0x33F3B4BA).withOpacity(.0001)),
      overlayColor: MaterialStateProperty.all<Color>(Color(0x33FFA8B0).withOpacity(.000001)),

    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: new IntroSlider(
        // List slides
   //     slides: this.slides,
        slides: [
          new Slide(
            styleDescription: TextStyle(  color: whiteColor),
            styleTitle:TextStyle(color: whiteColor) ,
            title: translator.translate(""),
            description: translator.translate(""),
            backgroundImage:"assets/images/onboard1.png",
            pathImage: "assets/icons/intro1.png",
            heightImage:.000100 ,
            widthImage: .000000000000500 ,
            backgroundColor: whiteColor,
          ),
          new Slide(
            styleDescription: TextStyle(  color: whiteColor),
            styleTitle:TextStyle(  color: whiteColor) ,
            title: translator.translate(""),
            description:  translator.translate(""),
            backgroundImage:"assets/images/onboard2.png",
            pathImage: "assets/icons/intro2.png",
            heightImage:.000100 ,
            widthImage: .000000000000500 ,
            backgroundColor: Color(0xff203152),
          ),
          new Slide(
            styleDescription: TextStyle(  color: whiteColor ),
            styleTitle:TextStyle(  color: whiteColor) ,
            title: translator.translate(""),
            description: translator.translate(""),
            marginDescription: EdgeInsets.symmetric(horizontal: 50),
            widgetDescription: InkWell(
              onTap: (){
                onDonePress();
              },
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.width ),
                child:  Container(
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.60),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Text("Shopping Now".tr(),style: TextStyle(color: blackColor,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
              ),
            ),

            backgroundImage:"assets/images/onboard3.png",
            pathImage: "assets/icons/intro3.png",
            heightImage:.000100 ,
            widthImage: .000000000000500 ,
            // backgroundColor: Color(0xff9932CC),
          ),
        ],

        // Skip button
        renderSkipBtn: this.renderSkipBtn(),
        skipButtonStyle: myButtonStyle(),

        // Next button
        renderNextBtn: this.renderNextBtn(),
        nextButtonStyle: myButtonStyle(),

       // Done button
        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        doneButtonStyle: myButtonStyle(),


        // Dot indicator
        colorDot: whiteColor.withOpacity(.5),
        colorActiveDot: whiteColor ,
        sizeDot: 13.0,

        // Show or hide status bar
        hideStatusBar: false ,
        backgroundColorAllSlides: Colors.grey,

        // Scrollbar
        verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
      ),
    );
  }
}

