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

  AnimationController _loginButtonController;
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
    forgetPassword_bloc.mobile_controller.value = null;
    _loginButtonController.dispose();
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
                  print("Loading");
                  _playAnimation();
                } else if (state is ErrorLoading) {
                  var data = state.model as StcPayModel;
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
                  )..show(_drawerKey.currentState.context);

                } else if (state is Done) {
                  var data = state.model as StcPayModel;
                  print("done");
                  _stopAnimation();
                  //   go to otp verification
        customAnimatedPushNavigation(context, StcVerificationCodeScreen(
          user_phone: StaticData.user_mobile_number,
          OtpReference: data.result.otpReference,
          paymentReference: data.result.paymentReference,
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
                              text: translator.translate("Enter Your Phone Number ?"),
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

                          // resetPasswordTextFields(context: context, hint: "Type Your Email"),
                          Form(
                            key: _formKey,
                            child: phone_addressTextFields(),
                          )
                          ,
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


  phone_addressTextFields({BuildContext context, String hint,var initialValue}) {
    String _countryCode  ="+966";
    return StreamBuilder<String>(
      stream: shipmentAddressBloc.phone,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(right: width(context) * .025, left: width(context) * .025),
          child: translator.activeLanguageCode == 'en'?Row(
            children: [
              CountryCodePicker(
                onChanged: (Object object)=>_countryCode=object.toString(),
                initialSelection: 'SA',
                countryFilter: ['SA', 'KW', 'AE'],
                showFlagDialog: true,
              ),
              Flexible(
                child: TextFormField(
                  initialValue: initialValue??'',
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: mainColor,
                      fontSize: isLandscape(context)
                          ? 2 * height(context) * .02
                          : height(context) * .02),
                  cursorColor: greyColor.withOpacity(.5),
                  decoration: InputDecoration(
                    hintText: translator.translate(hint??"Ex: 5xxxxxxxx"),
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    hintStyle: TextStyle(
                        color: mainColor,
                        fontWeight: FontWeight.bold,
                        fontSize: isLandscape(context)
                            ? 2 * height(context) * .018
                            : height(context) * .018),
                    filled: true,
                    fillColor: whiteColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    errorText: snapshot.error,

                  ),
                  validator: (value) {
                    Pattern pattern = r'^(009665|009715|00965|9665|9715|\+9665||\+9715|\+965|05|5)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})?$';
                    RegExp regex = new RegExp(pattern);

                    if (value == null || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                    }else  if(!regex.hasMatch(value) || value.length < 8){
                      return '${translator.translate("Please enter a correct phone number")} ';
                    }
                    return null;
                  },
                  onChanged: (text) {
                    shipmentAddressBloc.phone_change(_countryCode+text);
                  },
                ),
              ),
            ],
          ):Row(
            children: [
              Flexible(
                child: TextFormField(
                  textAlign: TextAlign.left,
                  initialValue: initialValue??'',
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: mainColor,
                      fontSize: isLandscape(context)
                          ? 2 * height(context) * .02
                          : height(context) * .02),
                  cursorColor: greyColor.withOpacity(.5),
                  decoration: InputDecoration(
                    hintText: translator.translate(hint??"Ex: 5xxxxxxxx"),
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    hintStyle: TextStyle(
                        color: greyColor.withOpacity(.5),
                        fontWeight: FontWeight.bold,
                        fontSize: isLandscape(context)
                            ? 2 * height(context) * .018
                            : height(context) * .018),
                    filled: true,
                    fillColor: whiteColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3),
                        borderSide: BorderSide(color: greyColor)),
                    errorText: snapshot.error,

                  ),
                  validator:(value) {
                    Pattern pattern = r'^(009665|009715|00965|9665|9715|\+9665||\+9715|\+965|05|5)(5|0|3|6|4|9|1|8|7|2)([0-9]{7})?$';
                    RegExp regex = new RegExp(pattern);

                    if (value == null || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                    }else  if(!regex.hasMatch(value) || value.length < 8){
                      return '${translator.translate("Please enter a correct phone number")} ';

                    }
                    return null;
                  },
                  onChanged: (text) {
                    shipmentAddressBloc.phone_change(_countryCode+text);
                  },
                ),
              ),
              CountryCodePicker(
                onChanged: (Object object)=>_countryCode=object.toString(),
                initialSelection: 'SA',
                countryFilter: ['SA', 'KW', 'AE'],
                showFlagDialog: true,
              ),
            ],
          ),
        );
      },
    );
  }

  stc_generate_otpButton({BuildContext context,}) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(10),
      child: StaggerAnimation(
        titleButton: translator.translate("Send") ,
        buttonController: _loginButtonController.view,
        btn_width: width(context) * .3,
        btn_height:  width(context) * .1,
        isResetScreen:false,
        onTap: () {
          if (_formKey.currentState.validate() ) {
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

  stcpPayPhoneHeader({BuildContext context,}) {
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
              Navigator.of(context).pop();
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