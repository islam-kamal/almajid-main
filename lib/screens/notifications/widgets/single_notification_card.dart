import 'package:almajidoud/utils/file_export.dart';

singleNotificationCard({BuildContext? context , int? index }){
  return  Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .02),
        Container(width: width(context)*.95,child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Container(height: isLandscape(context)
                ? 2* height(context)*.15: height(context)*.15,
                child:Center(child:   Column(
                  mainAxisAlignment:MainAxisAlignment.start,
                  children: [
                    Container(decoration: BoxDecoration(color:index!.isEven ?  Colors.purpleAccent  :
                    index == 2 ? Colors.blue :Colors.green , shape: BoxShape.circle),
                      height: isLandscape(context) ? 2* height(context)*.07 : height(context)*.07,width: width(context)*.2,
                      child: Center(child:Image.asset("assets/icons/notifi.png" , height:
                      isLandscape(context) ?2*height(context)*.04: height(context)*.04,),),),
                  ],
                ),)
            ),
            Container(width: width(context)*.75,height: isLandscape(context)
                ? 2* height(context)*.15: height(context)*.15,
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
                    customDescriptionText(context: context , textAlign: TextAlign.start ,
                        textColor: whiteColor , text: "1 week left of 25 % saving " , fontWeight: FontWeight.bold),
                    customDescriptionText(context: context , textAlign: TextAlign.start ,
                        textColor: whiteColor , text: "9:00 pm" ),
                  ],),
                  responsiveSizedBox(context: context , percentageOfHeight: .02),
                  Row(
                    children: [
                      Container(width: width(context)*.6,
                          child:   customDescriptionText(context: context , textAlign: TextAlign.start ,
                            textColor: whiteColor , text: "1 week left of 25 % saving 1 week left of 25 % saving 1 week left of 25 % saving ",maxLines: 2,)),
                    ],
                  ) ,
                  responsiveSizedBox(context: context , percentageOfHeight: .02),
                  Container(width: width(context)*.7,
                    child: Center(child: Divider(color: whiteColor),),)

                ],),
            ),
          ],
        ),),
      ],
    )],
  ) ;
}