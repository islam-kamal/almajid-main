import 'package:almajidoud/utils/file_export.dart';

Widget no_data_widget({BuildContext context , var message = "No Products Yet !"}){
  return Container(
    color: whiteColor,
    child: Column(
      children: [
        responsiveSizedBox(context: context , percentageOfHeight: .1),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(width(context) * 0.1),
              color: backGroundColor
          ),
          child: Image.asset("assets/icons/perfume (1).png" , width: width(context)*.7,color: mainColor,),
        ),
        responsiveSizedBox(context: context , percentageOfHeight: .04),
        customDescriptionText(context: context , textColor: mainColor , text: message , percentageOfHeight: .03) ,
        responsiveSizedBox(context: context , percentageOfHeight: .02),






      ],
    ),
  );
}