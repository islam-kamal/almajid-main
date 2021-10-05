import 'package:almajidoud/utils/file_export.dart';

paymentTextFields({BuildContext context , String hint }){
  return   Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
    height: isLandscape(context)
        ?2*height(context)*.065:height(context)*.065,
    child: TextFormField(
      style: TextStyle(color:  greyColor.withOpacity(.5),
          fontSize:
          isLandscape(context)   ? 2* height(context)*.02 :height(context)*.02),
      cursorColor:  greyColor.withOpacity(.5) ,
      decoration: InputDecoration(
        hintText: translator.translate(hint),
        hintStyle: TextStyle(
            color:  greyColor.withOpacity(.5) ,
            fontWeight: FontWeight.bold,
            fontSize:  isLandscape(context)   ? 2* height(context)*.018 :height(context)*.018),
        filled: true,fillColor: whiteColor,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: greyColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: greyColor)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(color: greyColor)),
      ),
    ),
  );
}