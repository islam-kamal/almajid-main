import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
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
    translator.activeLanguageCode == 'en' ? MyAccountScreen() : CartScreen(),

    translator.activeLanguageCode == 'en'
        ? LocationScreen()
        : SearchScreen(),
    HomeScreen(),
    translator.activeLanguageCode == 'en'
        ? SearchScreen()
        : LocationScreen(),
    translator.activeLanguageCode == 'en' ? CartScreen() : MyAccountScreen(),

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
        textDirection: translator.activeLanguageCode == 'ar'
            ? ui.TextDirection.rtl
            : ui.TextDirection.ltr,
        child: _pages[currentPage],
      ),
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        // barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        // arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        // arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        barHeight: Platform.isAndroid?width(context) * 0.15:width(context) * 0.2,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 0.0,
        shadowAllowance: 0.0,
        barBackgroundColor: mainColor,
        arcWidth: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: white_gray_color,
        activeIconColor: mainColor,
        inactiveIconColor: whiteColor,
        tabs: getTabsData(),
        onTabChangedListener: (index) => setState(() => currentPage = index),
      ),
    );
  }
}

List<TabData> getTabsData() {
  return [
    translator.activeLanguageCode == 'en'
        ? TabData(
      icon: Icons.menu,
      iconSize: 25,
    )
        : TabData(
      icon: Icons.shopping_cart,
      iconSize: 25.0,
    ),
    translator.activeLanguageCode == 'en'
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
    translator.activeLanguageCode == 'en'
        ? TabData(
      icon: Icons.search,
      iconSize: 25,
    )
        : TabData(
      icon: Icons.location_on,
      iconSize: 25,
    ),
    translator.activeLanguageCode == 'en'
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
