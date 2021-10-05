import 'package:almajidoud/utils/file_export.dart';

languageButton(
    {BuildContext context,
      bool switchValue,
      Function onChangeSwitch,

      bool isSwitch: true,
      Function onTapArrow}) {
  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        customDescriptionText(
            context: context, text: "Languages", percentageOfHeight: .025),
        SizedBox(width: width(context)*.05,),
        Container(height: isLandscape(context) ? 2*height(context)*.045 : height(context)*.045,width: width(context)*.22,
          decoration: BoxDecoration(border: Border.all(color: mainColor) , ),child:
          Center(child:Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
            customDescriptionText(context: context , textAlign: TextAlign.center , text: "ENG" , percentageOfHeight: .012) ,
            Icon(Icons.keyboard_arrow_down)
          ],),),)

      ],
    ),
  );
}
