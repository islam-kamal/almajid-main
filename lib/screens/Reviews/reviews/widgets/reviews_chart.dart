

import 'package:almajidoud/utils/file_export.dart';

singleChartWidget({BuildContext context , Color color , double lineWidth  , String text }){
  return Container(height:
  isLandscape(context)
      ? 2 * height(context)*.025
      : height(context)*.025, width: width(context),child:
  Container(padding: EdgeInsets.only(right: width(context)*.05
      , left: width(context)*.05),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        customDescriptionText(context: context , percentageOfHeight: .02,
            text: text , textColor: greyColor) ,

        Stack(children: [
          Container(
              color: greyColor.withOpacity(.2),
              height:
              isLandscape(context)
                  ? 2 * height(context)*.02
                  : height(context)*.02, width: width(context)*.6) ,
          Container
            (color: color.withOpacity(.9),
              height:
              isLandscape(context)
                  ? 2 * height(context)*.02
                  : height(context)*.02 , width: width(context)*lineWidth) ,
        ],),
      ],
    ),
  ),);
}
