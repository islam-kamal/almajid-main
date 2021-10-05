import 'package:almajidoud/utils/file_export.dart';

appVersion({BuildContext context}){
  return Row(
    children: [
      Padding(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
        child: customDescriptionText(context: context  , text:
        "${translator.translate("App Version")} 1.0" , textAlign: TextAlign.start,textColor: mainColor, percentageOfHeight: .025),),
    ],
  );
}