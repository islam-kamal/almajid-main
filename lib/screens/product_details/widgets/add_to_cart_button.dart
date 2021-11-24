import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Bloc/Shopping_Cart_Bloc/shopping_cart_bloc.dart';
addToCartButton({BuildContext context ,var product_quantity ,var product_sku }){

  return InkWell(
    onTap: (){
      shoppingCartBloc.add(AddProductToCartEvent(
          context: context,
      product_quantity: product_quantity,
      product_sku: product_sku));
    },
    child: Container(
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
            : height(context) * .065),
  ) ;
}