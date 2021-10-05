import 'package:almajidoud/utils/file_export.dart';

sizeAndQuantityText({BuildContext context , String text : ""}){
  return Row(
    children: [
      Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),child: customDescriptionText(context: context
       , textAlign: TextAlign.start , textColor: mainColor , text:text , percentageOfHeight: .025, fontWeight: FontWeight.bold),),
    ],
  );
}