import 'package:almajidoud/utils/file_export.dart';

saveCardDetails({BuildContext context , bool rValue }){
  return Container(width: width(context)*.9,
    child: Row(children: [
      Radio(value:rValue  , onChanged: (v){} , activeColor: Colors.blue) ,
      customDescriptionText(context: context , text: "Save Card Details" , percentageOfHeight: .022 , fontWeight: FontWeight.bold)
    ],),
  ) ;
}