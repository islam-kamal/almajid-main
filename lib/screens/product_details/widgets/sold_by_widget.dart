import 'package:almajidoud/utils/file_export.dart';

soldByWidget({BuildContext context}){
  return Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Container(child: customDescriptionText(context: context
          , text:  "sold by almajid4oud.com"   , textAlign: TextAlign.start ,
          maxLines: 2, textColor: greyColor ,
          percentageOfHeight:  .015, fontWeight: FontWeight.bold),) ,
    ],),);
}