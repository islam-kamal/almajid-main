import 'package:almajidoud/utils/file_export.dart';

ordersHeader({BuildContext? context}){
  return   Container(
    padding: EdgeInsets.only(top: height(context)*.05),
    child: Center(child: customDescriptionText(context: context , text: "My Orders" ,
        textColor: whiteColor , percentageOfHeight: .025),),
    color: mainColor,
    width: width(context),height:
  isLandscape(context) ?2*height(context)*.12: height(context)*.12 ,) ;


}



//replace custom description text with  :

//import 'dart:ui';
//import 'package:localize_and_translate/localize_and_translate.dart';
//import 'package:almajidoud/utils/file_export.dart';
//customDescriptionText({
//  BuildContext context, String text, double  percentageOfHeight : .019, Color textColor
//      : blackColor, FontWeight fontWeight : FontWeight.normal  , textAlign :
//  TextAlign.center, decoration : null ,fontStyle  : FontStyle.normal  , int  maxLines
//      : 1 , double textHeight : 1.0 , bool isTextFromBackend : false  }) {
//  return Text(
//    isTextFromBackend == true ? text :
//    translator.translate(text),
//    textAlign:textAlign ,
//    maxLines:maxLines,
//    overflow: TextOverflow.ellipsis,
//    style: TextStyle(
//        height: textHeight,
//        fontStyle: fontStyle ,
//        decoration:decoration  ,
//        fontWeight: fontWeight ,
//        color: textColor ,
//        fontSize: isLandscape(context)
//            ? 2 * height(context) *percentageOfHeight
//            : height(context) *percentageOfHeight ),
//  );
//}
