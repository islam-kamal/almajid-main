import 'package:almajidoud/utils/file_export.dart';

orderIdStack({BuildContext context}){
  return  Container(padding: EdgeInsets.only(top:  isLandscape(context) ? 2*height(context)*.15 :height(context)*.15),
      height:  isLandscape(context) ? 2*height(context) :height(context),


      child:
      Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
            Container(width: width(context)*.45,child:  customDescriptionText(context: context
                ,text: "Order ID : 23456"  ,maxLines: 2, percentageOfHeight: .027, textColor: whiteColor) ,) ,
            Container(
              height: isLandscape(context) ? 2*height(context)*.06 :height(context)*.06,decoration:
            BoxDecoration(color:whiteColor ,
                borderRadius: BorderRadius.circular(20)),

              width: width(context)*.35,child: Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time_outlined , color: redColor,),
                SizedBox(width: 5,) ,
                customDescriptionText(context: context , textColor: redColor , text: "Pending") ,



              ],),) ,

          ],) ,
          Container(width: width(context)*.9,child:  customDescriptionText(context: context
              ,text: "Ordered on 25 Jan - 10:05 pm"  ,textAlign: TextAlign.start ,maxLines: 2, percentageOfHeight: .015, textColor: whiteColor) ,) ,
        ],),)
  )  ;
}