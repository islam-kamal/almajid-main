import 'package:almajidoud/custom_widgets/custom_push_named_navigation.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/widgets/bottom_navigation_bar_item.dart';
import 'package:almajidoud/screens/cart/cart_screen.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:almajidoud/screens/location/location_screen.dart';
import 'package:almajidoud/screens/my_account/my_account_screen.dart';
import 'package:almajidoud/screens/settings/settings_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
settingsBottomNavigationBar({BuildContext context}){
  return   Container(alignment: Alignment.bottomCenter,width: width(context),
      child: Stack(children: [
        Container(
          child: Column(
            children: [
              responsiveSizedBox(context: context , percentageOfHeight: .02),
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
                  child: Container(height: height(context)*.08, width: width(context),
                    decoration: BoxDecoration(color: whiteColor),)),
            ],
          ),
        ),
        Container(width: width(context),child: Row(crossAxisAlignment: CrossAxisAlignment.end,mainAxisAlignment:
        MainAxisAlignment.spaceAround,mainAxisSize: MainAxisSize.min,
          children: [
            customBottomBarButton(context: context , isActive: false , icon: "assets/icons/cart.png" , onTap: (){
              customPushNamedNavigation(context, CartScreen());

            } ),
            customBottomBarButton(context: context , isActive: false, icon: "assets/icons/location.png" , onTap: (){
              customPushNamedNavigation(context, LocationScreen());
            } ),
            customBottomBarButton(context: context , isActive: false, icon: "assets/icons/home.png" , onTap: (){
              customPushNamedNavigation(context, HomeScreen());
            } ),
            customBottomBarButton(context: context , isActive: true,
                icon: "assets/icons/settings.png" , onTap: (){
                  customPushNamedNavigation(context, SettingsScreen());

                }, title: "Settings"
            ),
            customBottomBarButton(context: context , isActive: false,
                icon: "assets/icons/profile.png" , onTap: (){
                  customPushNamedNavigation(context, MyAccountScreen());

                }),
          ],),
          decoration: BoxDecoration(color: whiteColor.withOpacity(.0005)),
        )
      ],)
  );
}