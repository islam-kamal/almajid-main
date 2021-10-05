import 'package:almajidoud/utils/file_export.dart';

favouriteAndNameRow({BuildContext context}){
  return Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
    Container(width: width(context)*.7,child: customDescriptionText(context: context , text: "Lorim ipsum is simply dummy text " , textColor: mainColor ,
    percentageOfHeight:  .025),) ,
    Icon(Icons.favorite_border)

  ],),);
}