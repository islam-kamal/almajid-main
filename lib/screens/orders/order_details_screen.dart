import 'package:almajidoud/Model/OrderModel/order_model.dart';
import 'package:almajidoud/Repository/OrderRepo/order_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/widgets/orders_details_header.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/orders/widgets/order_id_stack.dart';
import 'package:almajidoud/screens/orders/widgets/order_central_card_stack.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class OrderDetailsScreen extends StatefulWidget{
  OrderItems? order_details;
  OrderDetailsScreen({this.order_details});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderDetailsScreenState();
  }

}
class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  bool reoder_loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Directionality(
        textDirection: translator.activeLanguageCode =='ar'? TextDirection.rtl : TextDirection.ltr,
        child:SingleChildScrollView(
        child: Container(
            height: isLandscape(context) ? 2 * height(context) : height(context),
            child: Stack(
              children: [
                orderBottomButtonsStack(
                    context: context,
                currency: widget.order_details!.orderCurrencyCode,
                total_payment: widget.order_details!.baseGrandTotal,
                  order_id: widget.order_details!.entityId,
                ),

                orderIdStack(
                    context: context,
                    status: widget.order_details!.status,
                order_id: widget.order_details!.incrementId,
                createAt: widget.order_details!.createdAt
                ),

                orderCentralCardStack(
                    context: context,
                order_details: widget.order_details)
              ],
            )),
      ),
      ));
  }


  orderBottomButtonsStack({BuildContext? context ,var total_payment, var currency, var order_id}) {

    return Container(
      height: isLandscape(context) ? 2 * height(context) : height(context),
      child: Column(
        children: [
          orderDetailsHeader(context: context),
          responsiveSizedBox(context: context, percentageOfHeight: .003),
          Container(
            height: isLandscape(context)
                ? 2 * height(context) * .32
                : height(context) * .32,
            color: whiteColor,
          ),
          responsiveSizedBox(context: context, percentageOfHeight: .447),
          Row(
            children: [
              Container(
                height: isLandscape(context) ? 2 * height(context) * .08 : height(context) * .08,
                width: width(context) * .5,
                decoration: BoxDecoration(color: whiteColor,
                    border: Border.all(color: mainColor)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customDescriptionText(
                          context: context,
                          percentageOfHeight: .02,
                          textColor: mainColor,
                          text: "${"Total to pay".tr()} "),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customDescriptionText(
                              context: context,
                              percentageOfHeight: .025,
                              textColor: mainColor,
                              text: " ${total_payment??''} ",
                              fontWeight: FontWeight.bold),
                          customDescriptionText(
                              context: context,
                              percentageOfHeight: .02,
                              textColor: mainColor,
                              text: " ${MyApp.country_currency??''}",
                              fontWeight: FontWeight.bold)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                 setState(() {
                   reoder_loading = true;
                 });
                  orderRepository.re_order(
                      context: context,
                      order_id:order_id
                  ).whenComplete(() {
                    customAnimatedPushNavigation(
                        context!,
                        CustomCircleNavigationBar(
                          page_index:translator.activeLanguageCode == 'ar'
                              ? 0 : 4,
                        ));
                    setState(() {
                      reoder_loading = false;
                    });
                  });
                },
                child: Container(
                  height: isLandscape(context) ? 2 * height(context) * .08 : height(context) * .08,
                  width: width(context) * .5,
                  decoration: BoxDecoration(color:reoder_loading ? whiteColor : greenColor),
                  child: reoder_loading ? Center(
                    child: SpinKitFadingCube(
                      color: Theme.of(context!).primaryColor,
                      size: width(context) * 0.08,
                    ),
                  ) : Center(
                    child: customDescriptionText(
                        context: context,
                        percentageOfHeight: .02,
                        textColor: whiteColor,
                        text: translator.translate("Re-Order")),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}
