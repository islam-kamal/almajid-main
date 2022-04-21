import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';
import 'dart:ui' as ui;
import 'dart:io' show Platform;

class CustomCircleNavigationBar extends StatefulWidget {
  final int page_index;

  CustomCircleNavigationBar({this.page_index = 2});


  @override
  _CustomCircleNavigationBarState createState() =>
      _CustomCircleNavigationBarState();
}

class _CustomCircleNavigationBarState extends State<CustomCircleNavigationBar> {
  int currentPage = 0;
  final List<Widget> _pages = [
    MyApp.app_langauge == 'en' ? MyAccountScreen() : CartScreen(),

    MyApp.app_langauge  == 'en'
        ? LocationScreen()
        : SearchScreen(),
    HomeScreen(),
    MyApp.app_langauge  == 'en'
        ? SearchScreen()
        : LocationScreen(),
    MyApp.app_langauge  == 'en' ? CartScreen() : MyAccountScreen(),

  ];

  @override
  void initState() {
    currentPage = widget.page_index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = size.height * 0.07;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      body: Directionality(
        textDirection: MyApp.app_langauge  == 'ar'
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
        child: _pages[currentPage],
      ),
      bottomNavigationBar: BottomNavyBar(
        selectedIndex: currentPage,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) => setState(() => currentPage = index),
        items: <BottomNavyBarItem>[
          MyApp.app_langauge  == 'en'
              ?   BottomNavyBarItem(
            icon: Icon(Icons.menu,color: currentPage==0? whiteColor :  blackColor ,),
            title: Text("My Account".tr(),style: TextStyle(color: currentPage==0?  whiteColor :blackColor ),),
            activeColor: Colors.black,
            textAlign: TextAlign.center,
          ) :
                  BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart,color: currentPage==0? whiteColor :  blackColor ,),
            title: Text('Cart'.tr(),style: TextStyle(color: currentPage==0?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ),

          MyApp.app_langauge  == 'en'
              ? BottomNavyBarItem(
            icon: Icon(Icons.location_on,color: currentPage==1? whiteColor :  blackColor ,),
            title: Text('Country'.tr(),style: TextStyle(color: currentPage==1?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ) :
          BottomNavyBarItem(
            icon: Icon(Icons.search,color: currentPage==1? whiteColor :  blackColor ,),
            title: Text('Search'.tr(),style: TextStyle(color: currentPage==1?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ),

          BottomNavyBarItem(
            icon: Icon(Icons.home,color: currentPage==2? whiteColor :  blackColor ,),
            title: Text(
              'Home'.tr(),style: TextStyle(color: currentPage==2?  whiteColor :blackColor ),
            ),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ),

          MyApp.app_langauge  == 'en'
              ?   BottomNavyBarItem(
            icon: Icon(Icons.search,color: currentPage==3? whiteColor :  blackColor ,),
            title: Text('Search'.tr(),style: TextStyle(color: currentPage==3?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ) :
          BottomNavyBarItem(
            icon: Icon(Icons.location_on,color: currentPage==3? whiteColor :  blackColor ,),
            title: Text('Country'.tr(),style: TextStyle(color: currentPage==3?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ),

          MyApp.app_langauge  == 'en'
              ?   BottomNavyBarItem(
            icon: Icon(Icons.shopping_cart,color: currentPage==4? whiteColor :  blackColor ,),
            title: Text('Cart'.tr(),style: TextStyle(color: currentPage==4?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ) :
          BottomNavyBarItem(
            icon: Icon(Icons.menu,color: currentPage==4? whiteColor :  blackColor ,),
            title: Text("My Account".tr(),style: TextStyle(color: currentPage==4?  whiteColor :blackColor ),),
            activeColor:Colors.black,
            textAlign: TextAlign.center,
          ),
        ],
      ),

      /*CircleBottomNavigationBar(
        initialSelection: currentPage,

        // barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        // arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        // arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        barHeight: Platform.isAndroid?width(context) * 0.15:width(context) * 0.2,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 0.0,
        shadowAllowance: 0.0,
        barBackgroundColor: whiteColor,
        arcWidth: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: white_gray_color,
        activeIconColor: mainColor,
        inactiveIconColor: mainColor,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),*/
    );
  }
}

List<TabData> getTabsData() {
  return [
    MyApp.app_langauge  == 'en'
        ? TabData(
      icon: Icons.menu,
      iconSize: 25,
    )
        : TabData(
      icon: Icons.shopping_cart,
      iconSize: 25.0,
    ),
    MyApp.app_langauge  == 'en'
        ? TabData(
      icon: Icons.location_on,
      iconSize: 25,
    )
        : TabData(
      icon: Icons.search,
      iconSize: 25,
    ),

    TabData(
      icon: Icons.home,
      iconSize: 25,
    ),

    MyApp.app_langauge  == 'en'
        ? TabData(
      icon: Icons.search,
      iconSize: 25,
    )
        : TabData(
      icon: Icons.location_on,
      iconSize: 25,
    ),

    MyApp.app_langauge  == 'en'
        ? TabData(
      icon: Icons.shopping_cart,
      iconSize: 25.0,
    )
        : TabData(
      icon: Icons.menu,
      iconSize: 25,
    ),

  ];
}
