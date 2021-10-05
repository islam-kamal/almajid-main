import 'package:almajidoud/utils/file_export.dart';

phoneNumberWidgetInResetPassword({BuildContext context}){
  return   Neumorphic(
    child: Container(padding: EdgeInsets.only(right: width(context)*.02 , left: width(context)*.02),
      color: whiteColor,child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(width: width(context)*.2,
            height: isLandscape(context)
                ?2*height(context)*.06:height(context)*.06 ,
            child: TextFormField(
              style: TextStyle(color:  greyColor.withOpacity(.5),
                  fontSize:
                  isLandscape(context)   ? 2* height(context)*.02 :height(context)*.02),
              cursorColor:  greyColor.withOpacity(.5) ,
              decoration: InputDecoration(
                hintText: translator.translate("+966"),
                hintStyle: TextStyle(
                    color:  greyColor.withOpacity(.5) ,
                    fontWeight: FontWeight.bold,
                    fontSize:  isLandscape(context)   ? 2* height(context)*.018 :height(context)*.018),
                filled: true,fillColor: whiteColor,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: blackColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: blackColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: blackColor)),
              ),
            ),
          ),
          SizedBox(width: width(context)*.03,),
          Container(width: width(context)*.5,
            height: isLandscape(context)
                ?2*height(context)*.06:height(context)*.06 ,
            child: TextFormField(
              style: TextStyle(color:  greyColor.withOpacity(.5),
                  fontSize:
                  isLandscape(context)   ? 2* height(context)*.02 :height(context)*.02),
              cursorColor:  greyColor.withOpacity(.5) ,
              decoration: InputDecoration(
                hintText: translator.translate("Your Phone Number"),
                hintStyle: TextStyle(
                    color:  greyColor.withOpacity(.5) ,
                    fontWeight: FontWeight.bold,
                    fontSize:  isLandscape(context)   ? 2* height(context)*.018 :height(context)*.018),
                filled: true,fillColor: whiteColor,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: blackColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: blackColor)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: BorderSide(color: blackColor)),
              ),
            ),
          )

        ],),
      width: width(context)*.8,height:isLandscape(context)
          ? 2 * height(context) * .08
          : height(context) * .08,),
  ) ;
}