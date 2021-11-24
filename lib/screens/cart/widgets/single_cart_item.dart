import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/CartModel/cart_details_model.dart' as cart_details_model;
singleCartItem({BuildContext context,cart_details_model.Items item}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          responsiveSizedBox(context: context, percentageOfHeight: .02),
          Neumorphic(
              child: Container(
                  width: width(context) * .95,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 3,left: 3),
                        width: width(context) * .3,
                        height: isLandscape(context)
                            ? 2 * height(context) * .13
                            : height(context) * .13,
                        decoration: BoxDecoration(
                          color: backGroundColor,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),
                                fit: BoxFit.fill)),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: width(context) * .02,
                            left: width(context) * .02),
                        width: width(context) * .6,
                        height: isLandscape(context)
                            ? 2 * height(context) * .15
                            : height(context) * .15,
                        child: Column(
                          children: [
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            customDescriptionText(
                                context: context,
                                textColor: mainColor,
                                maxLines: 2,
                                text: item.name??'',
                                textAlign: TextAlign.start),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            Row(
                              children: [
                                Container(
                                  child: customDescriptionText(
                                      context: context,
                                      textColor: mainColor,
                                      text: "\$ ${item.price} ",
                                      textAlign: TextAlign.start,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            Row(
                              children: [
                                customDescriptionText(
                                    context: context,
                                    textColor: mainColor,
                                    text: "${translator.translate("Qty")}:",
                                    textAlign: TextAlign.start,
                                    fontWeight: FontWeight.bold),
                                SizedBox(
                                  width: width(context) * .01,
                                ),
                                Container(
                                  width: width(context) * .15,
                                  height: isLandscape(context)
                                      ? 2 * height(context) * .035
                                      : height(context) * .035,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: mainColor)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          text: "${item.qty}",
                                          textAlign: TextAlign.start),
                                      Icon(Icons.keyboard_arrow_down)
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(color: backGroundColor))),
        ],
      ),
    ],
  );
}
