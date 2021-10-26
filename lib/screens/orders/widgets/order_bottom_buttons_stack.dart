import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/orders/widgets/orders_details_header.dart';

orderBottomButtonsStack({BuildContext context}){
  return   Container(height:  isLandscape(context) ? 2*height(context) :height(context),
    child: Column(
      children: [
        orderDetailsHeader(context: context)   ,
        responsiveSizedBox(context: context , percentageOfHeight: .003),
        Container(height: isLandscape(context) ? 2*height(context)*.35 :height(context)*.35,color: mainColor,) ,
        responsiveSizedBox(context: context , percentageOfHeight:  .447),
        Row(children: [
          Container(
            height: isLandscape(context) ? 2*height(context)*.08 :height(context)*.08,
            width: width(context)*.5,decoration: BoxDecoration(color: whiteColor),child: Center(child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customDescriptionText(context: context , percentageOfHeight: .02 , textColor: mainColor , text: "Total to pay :") ,
              SizedBox(width: 5,) ,
              customDescriptionText(context: context , percentageOfHeight: .02 , textColor: mainColor , text: "\$ 600" , fontWeight: FontWeight.bold)
            ],),),) ,
          Container(
            height: isLandscape(context) ? 2*height(context)*.08 :height(context)*.08 ,
            width: width(context)*.5,decoration: BoxDecoration(color: mainColor),child: Center(child:
          customDescriptionText(context: context , percentageOfHeight: .02 , textColor: whiteColor , text: "Re-Order") ,),)
        ],)




      ],
    ),
  ) ;
}