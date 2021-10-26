import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/orders/widgets/order_bottom_buttons_stack.dart';
import 'package:almajidoud/screens/orders/widgets/order_id_stack.dart';
import 'package:almajidoud/screens/orders/widgets/order_central_card_stack.dart';

class OrderDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      body: SingleChildScrollView(
        child: Container(
            height:
                isLandscape(context) ? 2 * height(context) : height(context),
            child: Stack(
              children: [
                orderBottomButtonsStack(context: context),
                orderIdStack(context: context),
                orderCentralCardStack(context: context)
              ],
            )),
      ),
    );
  }
}
