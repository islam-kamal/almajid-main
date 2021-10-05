
import 'package:almajidoud/screens/bottob_Navigation_bar/widgets/bottom_navigation_bar_item.dart';
import 'package:almajidoud/utils/file_export.dart';
class BottomNavigationBarScreen extends StatefulWidget {
  @override
  _BottomNavigationBarScreenState createState() => _BottomNavigationBarScreenState();
}
class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: backGroundColor
      ,body:
    Container(
        height: height(context),width: width(context),child:

        Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .88),
        Container(alignment: Alignment.bottomCenter,width: width(context),
          child: Stack(children: [
            Container(
              child: Column(
                children: [
                  responsiveSizedBox(context: context , percentageOfHeight: .03),
                  Neumorphic(
                      style:  NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: whiteColor , depth:5,
                        shadowDarkColor: greyColor , lightSource: LightSource.bottom,

                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.only(topLeft:
                        Radius.circular(10) , topRight: Radius.circular(10))),

//                                            lightSource: LightSource.topLeft,
//
                      ),
                      child: Container(height: height(context)*.09, width: width(context),
                        decoration: BoxDecoration(color: whiteColor),)),
                ],
              ),
            ),
            Container(width: width(context),child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment:
            MainAxisAlignment.spaceAround,mainAxisSize: MainAxisSize.min,
              children: [
              customBottomBarButton(context: context , isActive: false , icon: "assets/icons/cart.png"),
                customBottomBarButton(context: context , isActive: false, icon: "assets/icons/location.png"),
                customBottomBarButton(context: context , isActive: true, icon: "assets/icons/home.png"),
                customBottomBarButton(context: context , isActive: false, icon: "assets/icons/settings.png"),
                customBottomBarButton(context: context , isActive: false, icon: "assets/icons/profile.png"),
            ],),
              decoration: BoxDecoration(color: whiteColor.withOpacity(.0005)),
            )
          ],)
        )
      ],
    )),);
  }
}
