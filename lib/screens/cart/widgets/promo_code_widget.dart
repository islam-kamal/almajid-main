

import 'package:almajidoud/screens/cart/widgets/promo_code_alert_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';

class PromoCodeWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PromoCodeWidgetState();
  }
}

class PromoCodeWidgetState extends State<PromoCodeWidget> {
  bool radioValue = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex:3,
          child: Row(
            children: [
              Icon(Icons.map),
              SizedBox(width: 5,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(translator.translate("Promo Code"),style: TextStyle(color: mainColor,fontSize: 14),),
                  Text(translator.translate("Apply promo code to avail offers"),
                    style: TextStyle(color: white_gray_color,fontSize: 10),
                  ),

                ],
              )

            ],
          ),
        ),
        Expanded(
          flex:2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    promoCodeAlertDialog(base_context: context);
                  },
                  child: Container(
                    width:width(context) * 0.15,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        border: Border.all(color: mainColor)
                    ),
                    child:Text(translator.translate('Apply'),style: TextStyle(color: mainColor,fontSize: 12),),
                  ),
                ),
                InkWell(
                    onTap: (){
                      shoppingCartBloc.add(DeletePromoCodeEvent(
                          context: context
                      ));

                    },
                    child: Container(
                      width:width(context) * 0.15,
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          border: Border.all(color: mainColor)
                      ),
                      alignment: Alignment.center,
                      child:  Text(translator.translate('Cancel'),style: TextStyle(color: mainColor,fontSize: 12),),
                    ))
              ],
            ),
          )
        )


      ],
    );
  }
}
