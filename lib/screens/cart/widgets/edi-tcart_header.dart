import 'package:almajidoud/utils/file_export.dart';

editCartHeader({BuildContext context, var item_id}) {

  return Container(
    padding: EdgeInsets.only(
        right: width(context) * .02,
        left: width(context) * .02,
        bottom: isLandscape(context)
            ? 2 * height(context) * .01
            : height(context) * .01),
    width: width(context),
    color: mainColor,
    height: isLandscape(context)
        ? 2 * height(context) * .08
        : height(context) * .08,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.navigate_before,
                color: whiteColor,
                size: 30,
              ),
            ),
            customDescriptionText(
                context: context,
                text: "Edit Cart",
                textColor: whiteColor,
                fontWeight: FontWeight.normal,
                percentageOfHeight: .025
            ),
            item_id==null? Container() :   Row(
              children: [
                Image.asset(
                  "assets/icons/heart.png",
                  height: isLandscape(context)
                      ? 2 * height(context) * .035
                      : height(context) * .035,
                ),
                SizedBox(
                  width: width(context) * .02,
                ),
                InkWell(
                  onTap: (){
                    shoppingCartBloc.add(DeleteProductFromCartEvent(
                      context: context,
                      item_id: item_id
                    ));
                  },
                  child:  Image.asset(
                    "assets/icons/delete.png",
                    height: isLandscape(context)
                        ? 2 * height(context) * .03
                        : height(context) * .03,
                  ),
                )
               ,
              ],
            )
          ],
        ),
      ],
    ),
  );
}
