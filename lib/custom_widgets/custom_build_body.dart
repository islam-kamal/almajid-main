//import 'package:almajidoud/custom_widgets/custom_network_indicator.dart';
//import 'package:almajidoud/utils/file_export.dart';
//class CustomBuildBody extends StatelessWidget {
//  final String headerTitle ;
//  final Widget buildBodyWidget ;
//  bool withPadding ;
//  bool isSalespointsScreen ;
//  Color backgroundColor  ;
//  CustomBuildBody({
//    this.backgroundColor : whiteColor,
//    this.isSalespointsScreen : false  ,
//    this.withPadding : true  ,
//    this.headerTitle ,
//    this.buildBodyWidget
//
//  });
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      backgroundColor: backgroundColor,
//      body: SingleChildScrollView(
//        child: Column(
//          children: [
//            Neumorphic(
//              child: Container(
//                padding: EdgeInsets.only(top:  isLandscape(context)
//                    ? 2 * height(context) * .03
//                    : height(context) * .03, right: width(context)*.05 , left: width(context)*.05)  ,
//                  color: whiteColor,
//                  height:  isLandscape(context)
//                      ? 2 * height(context) * .18
//                      : height(context) * .18,
//                  width: width(context),
//                  child: Center(
//                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: [
//                        GestureDetector(
//                            onTap: () {
//                              Navigator.of(context).pop();
//                            },
//                            child: Icon(
//                              Icons.arrow_back,
//                              color: greenColor, size: isLandscape(context)
//                                ? 2 * height(context) * .04
//                                : height(context) * .04,
//                            )),
//                        customDescriptionText(
//                            context: context,
//                            text: headerTitle,
//                            textColor: greenColor,
//                            percentageOfHeight: .028),
//                        isSalespointsScreen == true ?
//                        GestureDetector(
//                            onTap: () {
//
//                            },
//                            child: Icon(
//                              MdiIcons.sortAscending,
//                              color: greenColor,
//                              size: isLandscape(context)
//                                  ? 2 * height(context) * .04
//                                  : height(context) * .04,
//                            )):
//                        SizedBox(width: .001,)
//                      ],
//                    ),
//                  )),
//            ),
//            Container(
//              height: height(context) * .82,
//              child: NetworkIndicator(
//                child: Container(
//                  child:Container(
//                    padding: EdgeInsets.only(right:
//                        withPadding == true ?
//                    width(context)*.05 : 0 , left:  withPadding == true ? width(context)*.05 : 0 ),
//                    child: buildBodyWidget,)
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//
//}
