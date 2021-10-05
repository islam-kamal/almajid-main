import 'package:almajidoud/utils/file_export.dart';

homeHeader({BuildContext context , Function onTapCategoryDrawer }){
  return   Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05 ,
      bottom: isLandscape(context)
      ?2*height(context)*.01
      :height(context)*.01),
    width: width(context),color: mainColor,height: isLandscape(context)
        ?2*height(context)*.15:height(context)*.13,child:
    Column(mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          GestureDetector(onTap: onTapCategoryDrawer,
            child: Image.asset("assets/icons/category.png" , height:
            isLandscape(context) ?2*height(context)*.04 : height(context)*.04,),
          ) ,
                 Container(width: width(context)*.5,height:
                 isLandscape(context) ?2*height(context)*.04 : height(context)*.04,
                   child: TextFormField(

        cursorColor:  greyColor.withOpacity(.5) ,
        decoration: InputDecoration(


          hintStyle: TextStyle(color: whiteColor , fontSize: 8),
          hintText: translator.translate("Type here to search"),
          prefixIcon: Icon(Icons.search , size: 20, color: whiteColor),

          filled: false,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: whiteColor , width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color:  whiteColor ,width: 2)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: whiteColor , width: 2)),
        ),
      ),
                 ),
            Image.asset("assets/icons/logo.png" , height:
            isLandscape(context) ?2*height(context)*.05 : height(context)*.05,)
          ],
        ),
      ],
    ),)  ;
}