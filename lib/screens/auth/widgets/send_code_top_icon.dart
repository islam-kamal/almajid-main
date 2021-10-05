import 'package:almajidoud/utils/file_export.dart';

sendCodeTopIcon({BuildContext context}){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
     Image.asset("assets/icons/smartphone.png" , height: isLandscape(context) ? 2*height(context)*.15 : height(context)*.15)
    ],
  ) ;
}