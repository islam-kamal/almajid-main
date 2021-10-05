import 'package:almajidoud/utils/file_export.dart';

addToCartButton({BuildContext context}){
  return Container(
      width: width(context) * .8,
      decoration: BoxDecoration(
          color: mainColor, borderRadius: BorderRadius.circular(8)),
      child:  Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart , color: whiteColor),
          SizedBox(width: 10 ) ,

          customDescriptionText(
            context: context,
            text: "Add To Cart",
            percentageOfHeight: .025,

            textColor: whiteColor) ,


      ],),
      height: isLandscape(context)
          ? 2 * height(context) * .065
          : height(context) * .065) ;
}