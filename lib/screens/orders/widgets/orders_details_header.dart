import 'package:almajidoud/utils/file_export.dart';

orderDetailsHeader({BuildContext context}){
  return   Container(
    padding: EdgeInsets.only(top: height(context)*.05 , right: width(context)*.05 , left: width(context)*.05),
    child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      GestureDetector(onTap: (){Navigator.of(context).pop();},
          child: Icon(Icons.arrow_back_ios , color: whiteColor,)) ,
      customDescriptionText(context: context , text: "Orders Details" ,
          textColor: whiteColor , percentageOfHeight: .025) ,
      SizedBox()

    ],) ,
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
