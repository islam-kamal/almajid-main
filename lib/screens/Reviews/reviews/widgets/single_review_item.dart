

import 'package:almajidoud/utils/file_export.dart';

singleRatingWidget({BuildContext context}){
  return  Container(padding: EdgeInsets.only(right: width(context)*.0, left: width(context)*.0),margin:EdgeInsets.only(bottom: 10)
    ,child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:
          NetworkImage(
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWo-eLdiDxfz7kkYOtnP76O_qBbuzHDQa_ygame4yxhKuYWIsiFFV9s_RonZrVip7Hag0&usqp=CAU"),) ,
        SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: width(context)*.65,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customDescriptionText(context: context , percentageOfHeight: .025,
                      text: "Ahmed Omar" ,fontWeight: FontWeight.bold , textAlign: TextAlign.start) ,
                  customDescriptionText(context: context , percentageOfHeight: .015,
                      text: "10:05 am" , textColor: greyColor , textAlign: TextAlign.start) ,
                ],),
            ) ,
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star , color: mainColor ,size: 15) , SizedBox(width: width(context)*.005,) ,
                Icon(Icons.star , color: mainColor ,size: 15) , SizedBox(width: width(context)*.005,) ,
                Icon(Icons.star , color: mainColor ,size: 15) , SizedBox(width: width(context)*.005,) ,
                Icon(Icons.star , color: mainColor ,size: 15) , SizedBox(width: width(context)*.005,) ,
                Icon(Icons.star , color: mainColor ,size: 15) , SizedBox(width: width(context)*.005,) ,




              ],) ,
            Container(width: width(context)*.65,
                child:      customDescriptionText(context: context , percentageOfHeight: .022,textColor: greyColor,maxLines: 20,textHeight:1.1,
                    text: "Lorem Ipscrambled itived notwas popularis more ", textAlign: TextAlign.start)
            )


          ],)
      ],
    ),);
}