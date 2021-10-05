import 'package:almajidoud/utils/file_export.dart';

connectedAccounts({BuildContext context}){
  return Row(
    children: [
      Padding(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
        child: customDescriptionText(context: context  , text:
      "Connected accounts" , textAlign: TextAlign.start,textColor: greyColor , percentageOfHeight: .019),),
    ],
  );
}