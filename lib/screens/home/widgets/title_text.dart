import 'package:almajidoud/utils/file_export.dart';

titleText({BuildContext? context , String? text }){
  return Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
    child: Row(children: [
      customDescriptionText(context: context , textAlign: TextAlign.start , textColor: mainColor ,
           percentageOfHeight: .02
          ,text: text )
    ],),
  );
}