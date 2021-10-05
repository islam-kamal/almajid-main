import 'package:almajidoud/utils/file_export.dart';

notificationsHeader({BuildContext context
}){
  return   Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05 ,top: isLandscape(context)
      ?2*height(context)*.062:height(context)*.062 ),
    width: width(context),color: mainColor,height: isLandscape(context)
        ?2*height(context)*.12:height(context)*.12,child:
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(onTap: (){Navigator.of(context).pop();},
          child: Icon(Icons.navigate_before , color: whiteColor , size: 30
            ,),
        ),
        customDescriptionText(context: context ,
            textColor: whiteColor , text: "Notifications" , percentageOfHeight: .025) ,
        SizedBox()
      ],
    ),)  ;
}