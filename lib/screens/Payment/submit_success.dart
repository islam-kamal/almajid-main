import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class SubmitSuccessfulScreen extends StatefulWidget{
  var order_id;
  SubmitSuccessfulScreen({this.order_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubmitSuccessfulScreenState();
  }

}
class SubmitSuccessfulScreenState extends State<SubmitSuccessfulScreen> with TickerProviderStateMixin{
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
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
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
               translator.translate( "Receipt of the request"),
              ),
              automaticallyImplyLeading: false,
            ),
            body:Center(
              child: Container(
                padding:  EdgeInsets.symmetric(horizontal: width(context) * 0.05,vertical: width(context) * 0.15),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          const SizedBox(height: 8),
                          Text(translator.translate("Congratulations!"),
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
                            shoppingCartBloc.add(GetCartDetailsEvent());
                            customPushNamedNavigation(context, CustomCircleNavigationBar());
                          }
                          else{
                            shoppingCartBloc.add(GetCartDetailsEvent());
                            customPushNamedNavigation(context, OrdersScreen(
                              increment_id: widget.order_id,
                            ));
                          }

                        },
                      )
                    ],
                  ),
                )
              ),
            )),
      ),
    );
  }
}