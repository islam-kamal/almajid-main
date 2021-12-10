import 'package:almajidoud/Model/OrderMode/order_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/orders/widgets/order_bottom_buttons_stack.dart';
import 'package:almajidoud/screens/orders/widgets/order_id_stack.dart';
import 'package:almajidoud/screens/orders/widgets/order_central_card_stack.dart';

class OrderDetailsScreen extends StatefulWidget{
  OrderItems order_details;
  OrderDetailsScreen({this.order_details});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return OrderDetailsScreenState();
  }

}
class OrderDetailsScreenState extends State<OrderDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: Directionality(
        textDirection: translator.activeLanguageCode =='ar'? TextDirection.rtl : TextDirection.ltr,
        child:SingleChildScrollView(
        child: Container(
            height:
                isLandscape(context) ? 2 * height(context) : height(context),
            child: Stack(
              children: [
                orderBottomButtonsStack(
                    context: context,
                currency: widget.order_details.orderCurrencyCode,
                total_payment: widget.order_details.baseGrandTotal
                ),

                orderIdStack(
                    context: context,
                    status: widget.order_details.status,
                order_id: widget.order_details.incrementId,
                createAt: widget.order_details.createdAt
                ),

                orderCentralCardStack(
                    context: context,
                order_details: widget.order_details)
              ],
            )),
      ),
      ));
  }
}
