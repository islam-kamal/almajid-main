import 'package:almajidoud/screens/WishList/custom_wishlist.dart';
import 'package:almajidoud/screens/product_details/product_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

favouriteAndNameRow({BuildContext context, String product_name , var prod_id, var prod_qty}) {
  return   Directionality(
      textDirection:
      translator.activeLanguageCode == 'en'
      ? TextDirection.ltr
          : TextDirection.rtl,
      child:Container(
    padding: EdgeInsets.only(
        right: width(context) * .05, left: width(context) * .05),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: customDescriptionText(
              context: context,
              text: product_name??"",
              textColor: mainColor,
              percentageOfHeight: .020),
        ),
        CustomWishList(
          color: redColor,
          product_id:
          prod_id,
          qty:prod_qty,
          context: context,
          screen:
          ProductDetailsScreen(),
        ),
      ],
    ),
      ));
}
