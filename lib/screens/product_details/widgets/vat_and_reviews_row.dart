import 'package:almajidoud/utils/file_export.dart';

vatAndReviewsRow({BuildContext context}){
  return Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Container(child: customDescriptionText(context: context
          , text:  "this price includes VAT"   , textAlign: TextAlign.start ,
          maxLines: 2, textColor: greyColor ,
          percentageOfHeight:  .015, fontWeight: FontWeight.bold),) ,
      Container(child: customDescriptionText(context: context
          , text:"Reviews"   , textAlign: TextAlign.start ,decoration: TextDecoration.underline,
          maxLines: 2, textColor: greyColor ,
          percentageOfHeight:  .015 , fontWeight: FontWeight.bold),) ,

    ],),);
}