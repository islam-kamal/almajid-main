import 'package:almajidoud/Bloc/ShippmentAddress_Bloc/shippment_address_bloc.dart';
import 'package:almajidoud/Model/PaymentModel/stc_pay_model.dart';
import 'package:almajidoud/Repository/PaymentRepo/payment_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/screens/Payment/stc_pay/stc_pay_verify_phone_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:almajidoud/Bloc/Payment_bloc/payment_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
class StcPayPhoneScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StcPayPhoneScreenState();
  }

}
class StcPayPhoneScreenState extends State<StcPayPhoneScreen>with TickerProviderStateMixin {
  String _countryCode = "+966";
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  AnimationController? _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticData.country_code = _countryCode;
    _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
  }

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _loginButtonController!.forward();
    } on TickerCanceled {
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _loginButtonController!.reverse();
      setState(() {
        isLoading = false;
      });
    } on TickerCanceled {
    }
  }

  @override
  void dispose() {
    forgetPassword_bloc.mobile_controller.close();
    _loginButtonController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          key: _drawerKey,
          backgroundColor: backGroundColor,
          body:  BlocListener<PaymentBloc, AppState>(
              bloc: paymentBloc,
              listener: (context, state) {
                if (state is Loading) {
                  _playAnimation();
                } else if (state is ErrorLoading) {
                  var data = state.model as StcPayModel;
                  _stopAnimation();
                  Flushbar(
                    messageText: Row(
                      children: [
                        Container(
                          width: StaticData.get_width(context) * 0.7,
                          child: Wrap(
                            children: [
                              Text(
                                '${data.message}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Text(
                          translator.translate("Try Again" ),
                          textDirection: TextDirection.rtl,
                          style: TextStyle(color: whiteColor),
                        ),
                      ],
                    ),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    backgroundColor: redColor,
                    flushbarStyle: FlushbarStyle.FLOATING,
                    duration: Duration(seconds: 3),
                  )..show(_drawerKey.currentState!.context);

                }
                else if (state is Done) {
                  var data = state.model as StcPayModel;
                  _stopAnimation();
                  //   go to otp verification
        customAnimatedPushNavigation(context, StcVerificationCodeScreen(
          user_phone: StaticData.user_mobile_number,
          OtpReference: data.result!.otpReference,
          paymentReference: data.result!.paymentReference,
        ));
                }
              },
              child:Container(
                height: height(context),
                width: width(context),
                child: Container(
                  child: SingleChildScrollView(
                      child: Column(
                        children: [
                          stcpPayPhoneHeader(context: context ),
                          responsiveSizedBox(context: context, percentageOfHeight: .1),
                          Image.asset(
                            "assets/images/stc-pay.png",
                            height: isLandscape(context) ? 2 * height(context) * .25
                                : height(context) * .25,
                          ),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .035),
                          customDescriptionText(
                              context: context,
                              percentageOfHeight: .03,
                              textColor: blackColor,
                              text: translator.translate("Enter Your Phone Number"),
                              fontWeight: FontWeight.w300),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .035),
                          customDescriptionText(
                              context: context,
                              percentageOfHeight: .018,
                              textColor: blackColor,
                              text: "You will receive an verification code through your phone",
                              fontWeight: FontWeight.w300),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .045),

                          phoneTextFields(),


                          responsiveSizedBox(context: context, percentageOfHeight: .01),
                          // resendMessageButton(context: context),
                          responsiveSizedBox(context: context, percentageOfHeight: .15),
                          //   sendAndDoneButton(context: context)
                          stc_generate_otpButton(context: context)
                        ],
                      )),
                ),
              )),
        ),
      ),
    );
  }



  phoneTextFields({BuildContext? context, String? hint,var initialValue}) {
    String _countryCode  = MyApp.app_location == 'sa' ?"+966" : MyApp.app_location == 'kw' ? "+965" : "+971";
    return Form(
      key: _formKey,
      child: StreamBuilder<String>(
        stream: shipmentAddressBloc.phone,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),
            child: Directionality(
              textDirection:  TextDirection.ltr ,
              child: IntlPhoneField(
                decoration: InputDecoration(
                  hintText:hint ,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(color: greyColor)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(color: greyColor)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(3),
                      borderSide: BorderSide(color: greyColor)),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),

                initialCountryCode: MyApp.app_location == 'sa' ?'SA' : MyApp.app_location == 'kw' ? 'KW' : 'AE',
                onChanged: (phone) {
                  shipmentAddressBloc.phone_change(phone.completeNumber);
                },
                initialValue: initialValue,
                countries:  ['SA', 'KW', 'AE'],
                onCountryChanged: (country) {
                },
              ) ,
            ),

          );
        },
      ),
    );
  }


  stc_generate_otpButton({BuildContext? context,}) {
      return Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(10),
        child: StaggerAnimation(
          titleButton: translator.translate("Send") ,
          buttonController: _loginButtonController,
          btn_width: width(context) * .3,
          btn_height:  width(context) * .1,
          isResetScreen:false,
          onTap: () {
            if (_formKey.currentState!.validate() ) {
              StaticData.user_mobile_number = shipmentAddressBloc.phone_controller.value;
              paymentBloc.add(StcSendVerificationCodeEvent(
                  context :context,
                  phone: shipmentAddressBloc.phone_controller.value

              ));
            }

          },
        ),
      );
    }



  stcpPayPhoneHeader({BuildContext? context,}) {
    return Container(
      padding: EdgeInsets.only(
        right: width(context) * .05,
        left: width(context) * .05,
        top: width(context) * .05,
      ),
      width: width(context),
      color: mainColor,
      height: isLandscape(context)
          ? 2 * height(context) * .09
          : height(context) * .09,
      child: Row(
       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context!).pop();
            },
            child: Icon(
              Icons.navigate_before,
              color: whiteColor,
              size: 30,
            ),
          ),
        SizedBox(width: width(context) * .28),
        customDescriptionText(
              context: context,
              textColor: whiteColor,
              fontWeight: FontWeight.bold,
              text: "")


        ],
      ),
    );
  }

}