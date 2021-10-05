import 'package:almajidoud/utils/file_export.dart';

priceAndRatingRow({BuildContext context}){
  return Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
      Container(child: customDescriptionText(context: context
          , text: "2000 \$"   , textAlign: TextAlign.start ,
           maxLines: 2, textColor: mainColor ,
          percentageOfHeight:  .03 , fontWeight: FontWeight.bold),) ,
      Row(
        children: [
          Icon(Icons.star , size: 15,),
          Icon(Icons.star , size: 15,),
          Icon(Icons.star , size: 15,),
          Icon(Icons.star , size: 15,),
          Icon(Icons.star , size: 15,),


        ],
      )

    ],),);
}