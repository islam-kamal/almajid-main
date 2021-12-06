import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/screens/orders/order_details_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

singleOrderItem({BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      GestureDetector(
        onTap: () {
          customAnimatedPushNavigation(context, OrderDetailsScreen());
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
                              height: isLandscape(context)
                                  ? 2 * height(context) * .1
                                  : height(context) * .1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width(context) * .2,
                                    height: isLandscape(context)
                                        ? 2 * height(context) * .1
                                        : height(context) * .1,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0Og0-LY1uOs7Z3I_sBLafG8F2IbFwRVprrg&usqp=CAU"),
                                            fit: BoxFit.cover)),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  right: width(context) * .02,
                                  left: width(context) * .02),
                              width: width(context) * .7,
                              height: isLandscape(context)
                                  ? 2 * height(context) * .12
                                  : height(context) * .11,
                              child: Column(
                                children: [
                                  responsiveSizedBox(
                                      context: context,
                                      percentageOfHeight: .01),
                                  Row(
                                    children: [
                                      customDescriptionText(
                                          context: context,
                                          textColor: mainColor,
                                          maxLines: 1,
                                          fontWeight: FontWeight.bold,
                                          percentageOfHeight: .025,
                                          text: "Product Name",
                                          textAlign: TextAlign.start),
                                    ],
                                  ),
                                  responsiveSizedBox(
                                      context: context,
                                      percentageOfHeight: .01),
                                  customDescriptionText(
                                      context: context,
                                      textColor: mainColor,
                                      maxLines: 2,
                                      text: "Lorim",
                                      textAlign: TextAlign.start),
                                  responsiveSizedBox(
                                      context: context,
                                      percentageOfHeight: .01),
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
                                        text: "Payment",
                                        textColor: greyColor),
                                    customDescriptionText(
                                        context: context,
                                        text: "Qty",
                                        textColor: greyColor),
                                    customDescriptionText(
                                        context: context,
                                        text: "Order status",
                                        textColor: greyColor)
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
                                        text: "${translator.translate("SAR")} 600",
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    customDescriptionText(
                                        context: context,
                                        text: "3",
                                        textColor: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    customDescriptionText(
                                        context: context,
                                        text: "Pending",
                                        textColor: Colors.red,
                                        fontWeight: FontWeight.bold)
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
                    decoration: BoxDecoration(color: Colors.white))),
          ],
        ),
      ),
    ],
  );
}

