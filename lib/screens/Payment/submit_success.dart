import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class PaymentSuccessfulScreen extends StatefulWidget{
  var order_id;
  PaymentSuccessfulScreen({this.order_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentSuccessfulScreenState();
  }

}
class PaymentSuccessfulScreenState extends State<PaymentSuccessfulScreen> with TickerProviderStateMixin{
  AnimationController _loginButtonController ;
  bool isLoading = false;

  @override
  void initState() {
    _loginButtonController =AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
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
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
               translator.translate( "Confirmation Screen"),
              ),
              automaticallyImplyLeading: false,
            ),
            body:Center(
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: width(context) * 0.05,vertical: width(context) * 0.15),
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const SizedBox(height: 8),
                        Text(translator.translate("Success"),
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          translator.translate("Your order created successfully"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${translator.translate("Your order Number")} #${widget.order_id}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        SizedBox(height: width(context) * 0.15),
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: Colors.green)
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 32,
                          ),
                        ),
                        SizedBox(height: width(context) * 0.2),

                      ],
                    ),

                    StaggerAnimation(
                      titleButton: translator.translate("Continue").toUpperCase(),
                      buttonController: _loginButtonController.view,

                      onTap: () {
                        if( StaticData.vistor_value == 'visitor') {

                          customPushNamedNavigation(context, CustomCircleNavigationBar());
                        }
                        else{
                          customPushNamedNavigation(context, OrdersScreen(
                            increment_id: widget.order_id,
                          ));
                        }

                      },
                    )
                  ],
                ),
              ),
            )),
      ),
    );
/*    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Great!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Thank you making the payment!",
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                  color: Colors.black,
                  child: Text(
                    "Close",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if( StaticData.vistor_value == 'visitor') {

                      customPushNamedNavigation(context, CustomCircleNavigationBar());
                    }
                    else{
                      customPushNamedNavigation(context, OrdersScreen(
                        increment_id: order_id,
                      ));
                    }


                  })
            ],
          ),
        ),
      ),
    );*/
  }
}