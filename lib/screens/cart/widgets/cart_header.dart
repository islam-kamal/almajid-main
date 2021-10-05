import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/cart/edit_cart_screen.dart';
import 'package:almajidoud/screens/cart/widgets/promo_code_alert_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
cartHeader({BuildContext context}){
  return   Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05 ,
      bottom: isLandscape(context)
          ?2*height(context)*.01
          :height(context)*.01),
    width: width(context),color: mainColor,height: isLandscape(context)
        ?2*height(context)*.1:height(context)*.1,child:
    Column(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: (){
              promoCodeAlertDialog(context: context);
            },
              child: Icon(Icons.navigate_before , color: whiteColor , size: 30
                ,),
            ),
            customDescriptionText(context: context , text: "Cart" , textColor: whiteColor ,
                fontWeight: FontWeight.bold , percentageOfHeight: .025),
//
            Row(
              children: [

                GestureDetector(onTap: (){customAnimatedPushNavigation(context, EditCartScreen());},
                  child: Image.asset("assets/icons/edit.png" , height:
                  isLandscape(context) ?2*height(context)*.04: height(context)*.04,),
                ),


              ],
            )
          ],
        ),
      ],
    ),)  ;
}