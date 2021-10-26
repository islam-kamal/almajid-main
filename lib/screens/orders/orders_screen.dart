import 'package:almajidoud/screens/orders/widgets/orders_header.dart';
import 'package:almajidoud/screens/orders/widgets/single_order_item.dart';
import 'package:almajidoud/utils/file_export.dart';
class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}
class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: whiteColor,
          body: SingleChildScrollView(
              child: Column(
                children: [
                  ScreenAppBar(
                    right_icon: 'cart',
                    category_name: translator.translate("My Orders" ),
                   screen: OrdersScreen(),
                  ),
//              noOrdersWidget(context: context)
                  Container(
                    height: height(context)*.85,
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return singleOrderItem(context: context);
                      }, itemCount: 10 ,
                    ),
                  ),







                ],
              )


          ),
        ),
      ),
    );
  }
}
