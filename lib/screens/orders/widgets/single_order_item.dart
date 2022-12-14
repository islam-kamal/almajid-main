import 'package:almajidoud/Model/OrderModel/order_model.dart';
import 'package:almajidoud/Widgets/customWidgets.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/orders/order_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

singleOrderItem({BuildContext? context , OrderItems? order ,var order_increment_id}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          customAnimatedPushNavigation(context!, OrderDetailsScreen(
            order_details: order,
          ));
        },
        child: Column(
          children: [
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Neumorphic(

                child: Container(
                    width: width(context) * .9,

                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  right: width(context) * .02,
                                  left: width(context) * .02),
                              width: width(context) * .7,
                              height: isLandscape(context)
                                  ? 2 * height(context) * .12
                                  : height(context) * .11,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  responsiveSizedBox(
                                      context: context,
                                      percentageOfHeight: .01),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          maxLines: 1,
                                          fontWeight: FontWeight.bold,
                                          percentageOfHeight: .025,
                                          text: "${translator.translate("order")}",
                                          textAlign: TextAlign.start),

                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          maxLines: 1,
                                          fontWeight: FontWeight.normal,
                                          percentageOfHeight: .025,
                                          text: " # ${order!.incrementId}",
                                          textAlign: TextAlign.start),
                                    ],
                                  ),
                                  responsiveSizedBox(context: context, percentageOfHeight: .01),


                             customDescriptionText(
                                    context: context,
                                    textColor: mainColor,
                                    maxLines: 1,
                                    text: "${order.createdAt}",
                                    textAlign: TextAlign.start),

                                  responsiveSizedBox(context: context, percentageOfHeight: .01),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          color: backGroundColor,
                          child: Column(
                            children: [
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              Container(
                                padding: EdgeInsets.only(
                                    right: width(context) * .05,
                                    left: width(context) * .05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customDescriptionText(
                                        context: context,
                                        text: translator.translate("payment"),
                                        textColor: old_price_color),

                                    customDescriptionText(
                                        context: context,
                                        text: translator.translate( "order status"),
                                        textColor: old_price_color)
                                  ],
                                ),
                              ),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              Container(
                                padding: EdgeInsets.only(
                                    right: width(context) * .05,
                                    left: width(context) * .05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    customDescriptionText(
                                        context: context,
                                        text: "${order.orderCurrencyCode} ${order.baseGrandTotal}",
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    customDescriptionText(
                                        context: context,
                                        text: "${CustomComponents.order_status(order.status)}",
                                        textColor:CustomComponents.order_status_color(order.status)!,
                                        percentageOfHeight: .017,
                                        fontWeight: FontWeight.normal)
                                  ],
                                ),
                              ),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                            ],
                          ),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: order_increment_id == order.incrementId  ? Colors.grey : Colors.white))),
          ],
        ),
      ),
    ],
  );
}



