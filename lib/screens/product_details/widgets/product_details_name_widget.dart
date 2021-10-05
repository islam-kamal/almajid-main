import 'package:almajidoud/utils/file_export.dart';

productDetailsNameWidget({BuildContext context}){
  return Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(mainAxisAlignment: MainAxisAlignment.start,children: [
        Icon(Icons.arrow_back_ios) ,
        Container(width: width(context)*.5,child:customDescriptionText(context: context , text: "lorim ipsum is simply dummy text " , percentageOfHeight: .025)
          ,)
      ],) ,
      Icon(Icons.shopping_cart)

  ],),);
}