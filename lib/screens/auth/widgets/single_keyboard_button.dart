import 'package:almajidoud/utils/file_export.dart';

singleKeyBoardButton({BuildContext context, isActive: false , int number , Function onTap }) {
  return GestureDetector(onTap: onTap ,
    child: Container(
      child: Center(child: customDescriptionText(context: context , text: number.toString(),textColor: isActive == true ? mainColor : whiteColor , percentageOfHeight: .04 ,
      fontWeight: FontWeight.bold ), ),
      height: isLandscape(context)
          ? 2 * height(context) * .06
          : height(context) * .06,
      width: width(context) * .16,
      decoration: BoxDecoration(color: isActive == true ? whiteColor : mainColor , shape: BoxShape.circle),
    ),
  );
}
