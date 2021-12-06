import 'package:almajidoud/Bloc/Order_Bloc/order_bloc.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/guest/guest_shipment_address_model.dart';
import 'package:almajidoud/screens/checkout/widgets/checkout_header.dart';
import 'package:almajidoud/screens/checkout/widgets/done_button.dart';
import 'package:almajidoud/screens/checkout/widgets/order_summary_widget.dart';
import 'package:almajidoud/screens/checkout/widgets/single_order_summary_item.dart';
import 'package:almajidoud/screens/checkout/widgets/single_product_summary_card.dart';
import 'package:almajidoud/screens/checkout/widgets/top_page_indicator.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class CheckoutSummaryScreen extends StatefulWidget{
  GuestShipmentAddressModel guestShipmentAddressModel;
  CheckoutSummaryScreen({this.guestShipmentAddressModel});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CheckoutSummaryScreenState();
  }

}
class CheckoutSummaryScreenState extends State<CheckoutSummaryScreen> with TickerProviderStateMixin{
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  FocusNode fieldNode = FocusNode();

  AnimationController _loginButtonController;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
      print('[_stopAnimation] error');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  NetworkIndicator(
      child: PageContainer(
      child: Scaffold(
      key:_drawerKey,
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: BlocListener<OrderBloc,AppState>(
        bloc: orderBloc,
        listener: (context,state){
      if (state is Loading) {
        print("Loading");
        _playAnimation();
      } else if (state is ErrorLoading) {
        print("ErrorLoading");
        _stopAnimation();

        Flushbar(
          messageText: Row(
            children: [
              Container(
                width: StaticData.get_width(context) * 0.7,
                child: Wrap(
                  children: [
                    Text(
                      'There is Error',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: whiteColor),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Text(
                translator.translate("Try Again"),
                textDirection: TextDirection.rtl,
                style: TextStyle(color: whiteColor),
              ),
            ],
          ),
          flushbarPosition: FlushbarPosition.BOTTOM,
          backgroundColor: redColor,
          flushbarStyle: FlushbarStyle.FLOATING,
          duration: Duration(seconds: 6),
        )..show(_drawerKey.currentState.context);
      } else if (state is Done) {
        print("done");
        _stopAnimation();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return OrdersScreen(
              );
            },
            transitionsBuilder:
                (context, animation8, animation15, child) {
              return FadeTransition(
                opacity: animation8,
                child: child,
              );
            },
            transitionDuration: Duration(milliseconds: 10),
          ),
        );
      }
    },
    child: Column(
          children: [
            checkoutHeader(context: context),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            topPageIndicator(
                context: context,
                isPayment: true,
                isAddress: true,
                indicatorWidth: 1,
                isSummary: true),
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Container(
              width: width(context),
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: isLandscape(context)
                  ? 2 * height(context) * .23
                  : height(context) * .23,
              child: ListView.builder(
                itemCount: widget.guestShipmentAddressModel.totals.items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      singleProductSummaryCard(
                          context: context,
                      prod_name: widget.guestShipmentAddressModel.totals.items[index].name,
                        prod_price: widget.guestShipmentAddressModel.totals.items[index].price,
                        prod_qty: widget.guestShipmentAddressModel.totals.items[index].qty
                      ),
                      SizedBox(width: width(context) * .05)
                    ],
                  );
                },

              ),
            ),
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            singleOrderSummaryItem(
                context: context,
                isAddress: true,
                title: "Address",
                details: "Lorim"),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            singleOrderSummaryItem(
                context: context,
                title: "Payment",
                details: "Credit Card \n *******"),
            Container(
                width: width(context) * .9,
                child: Divider(
                  color: greyColor,
                )),
            orderSummaryWidget(
                context: context,
            subtotal: widget.guestShipmentAddressModel.totals.subtotal,
            vat: widget.guestShipmentAddressModel.totals.baseTaxAmount,
            total: widget.guestShipmentAddressModel.totals.baseGrandTotal) ,
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            doneButton(context: context)

          ],
        ),
        )
      ),
    ))   );
  }

  doneButton({BuildContext context,}) {
    return StaggerAnimation(
      titleButton: translator.translate("Next"),
      buttonController: _loginButtonController.view,
      btn_width: width(context) * .7,
      onTap: () {
        orderBloc.add(CreateOrderEvent(
            context: context
        ));
      },
    );
  }

}
