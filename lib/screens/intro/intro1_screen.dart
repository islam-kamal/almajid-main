import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'intro2_screen.dart';
class Intro1Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        body: Center(child: Stack(children: [
          Container(width: width(context),height: height(context),
            child: Image.asset("assets/images/intro1.png" , fit: BoxFit.cover,),),
          Container(width: width(context),height: height(context),
              child: Column(
//              test
                children: [
                  responsiveSizedBox(context: context , percentageOfHeight: .08),
                  Container(
                      width: width(context)*.7,
                      child: Image.asset("assets/icons/intro1.png" , fit: BoxFit.contain,)),
                ],
              ),
            ),
          Container(
              width: width(context),height: height(context),
            child:Container(
              alignment: Alignment.bottomCenter,
              child:  Container(height: isLandscape(context) ?2*height(context)*.2:height(context)*.2,
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Row(children: [
                          GestureDetector(onTap: (){customAnimatedPushNavigation(context, Intro2Screen());},
                            child: Container(height: isLandscape(context) ?2*height(context)*.05:height(context)*.05, width:
                            width(context)*.3,decoration: BoxDecoration(
                                border: Border.all(color: whiteColor) , borderRadius: BorderRadius.circular(30)

                            ), child:Center(child:
                            customDescriptionText(context: context , text: "Next",fontWeight: FontWeight.bold , textColor: whiteColor),)),
                          )
                        ],),
                        responsiveSizedBox(context: context , percentageOfHeight: .02),
                        Container(width: width(context)*.4,
                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                            Container(height: isLandscape(context) ?2*height(context)*.04:height(context)*.04, width:
                            width(context)*.04,decoration: BoxDecoration(color: whiteColor,
                                border: Border.all(color: whiteColor) ,shape: BoxShape.circle

                            ),) ,
                            Container(height: isLandscape(context) ?2*height(context)*.03:height(context)*.03, width:
                            width(context)*.03,decoration: BoxDecoration(
                                border: Border.all(color: whiteColor) ,shape: BoxShape.circle

                            ),) ,
                            Container(height: isLandscape(context) ?2*height(context)*.03:height(context)*.03, width:
                            width(context)*.03,decoration: BoxDecoration(
                                border: Border.all(color: whiteColor) ,shape: BoxShape.circle

                            ),) ,
                          ],),
                        ),
                      ],
                    ),
                  ],
                ),
              ))),
        ],)));
  }
}
