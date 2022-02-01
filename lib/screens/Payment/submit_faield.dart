import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/screens/orders/orders_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class SubmitFaieldScreen extends StatefulWidget{
  var faield_type;
  var reason;
  SubmitFaieldScreen({this.faield_type,this.reason});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SubmitFaieldScreenState();
  }

}
class SubmitFaieldScreenState extends State<SubmitFaieldScreen> with TickerProviderStateMixin{
  AnimationController _loginButtonController ;
  bool isLoading = false;

  @override
  void initState() {
    widget.faield_type == 'PaymentFailed' ? null :  customAnimatedPushNavigation(context, CustomCircleNavigationBar());
    _loginButtonController =AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
    super.initState();
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
                          Text(translator.translate("Faield!"),
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.faield_type == 'PaymentFailed' ? translator.translate( "Payment was not successful, because ${widget.reason == null ? '' : widget.reason} Please try again Later!" ) :
                            translator.translate( "Problem Verifying Payment, If you balance is deducted please contact our customer support and get your payment verified!"
                            ),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyText2,
                          ),

                          SizedBox(height: width(context) * 0.15),
                          Container(
                              width: width(context) * 0.3,
                              height: width(context) * 0.4,

                              child: Image.asset( "assets/images/error.png",)
                          ),
                          SizedBox(height: width(context) * 0.2),

                        ],
                      ),
                      InkWell(
                        onTap: () {
                          customPushNamedNavigation(context, CustomCircleNavigationBar());

                        },
                        child: Container(
                            width: width(context) * .8,
                            decoration: BoxDecoration(
                                color: mainColor, borderRadius: BorderRadius.circular(8)),
                            child: Center(
                                child: customDescriptionText(
                                    context: context,
                                    text: translator.translate("Back To Checkout Screen"),
                                    percentageOfHeight: .022,
                                    textColor: whiteColor)),
                            height: isLandscape(context)
                                ? 2 * height(context) * .065
                                : height(context) * .065),
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