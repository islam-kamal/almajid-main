import 'package:almajidoud/utils/check_direction.dart';
import 'package:almajidoud/utils/colors.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
class NetworkIndicator extends StatefulWidget {
  final Widget child;
  const NetworkIndicator({this.child});
  @override
  _NetworkIndicatorState createState() => _NetworkIndicatorState();
}
class _NetworkIndicatorState extends State<NetworkIndicator> {
  Widget _buildBodyItem() {
    return ListView(
      children: <Widget>[
        Column(
          children: [
            responsiveSizedBox(context: context, percentageOfHeight:  isLandscape(context) ? .1:.3),
            Container(
              child:

                Icon(Icons.wifi_off_outlined , color: mainColor , size: 30)
//              Image.asset(AppImages.no_internet2),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            customDescriptionText(
                context: context,
                text: checkDirection(
                  dirArabic:
                    "لا يوجد اتصال بالإنترنت ",
                    dirEnglish:"you\'re Offline !"))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return Scaffold(
            backgroundColor: whiteColor,
            body: _buildBodyItem(),
          );
        } else {
          return child;
        }
      }, builder: (BuildContext context) {return widget.child;},);}}
