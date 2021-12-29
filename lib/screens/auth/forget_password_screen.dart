import 'package:almajidoud/Bloc/Authentication_Bloc/SignupBloc/sign_up_bloc.dart';

import 'package:almajidoud/screens/auth/widgets/forget_password_button.dart';
import 'package:almajidoud/screens/auth/widgets/forget_password_top_header.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatefulWidget{

  @override
  ForgetPasswordScreenState createState() => ForgetPasswordScreenState();
}

class ForgetPasswordScreenState extends State<ForgetPasswordScreen> with TickerProviderStateMixin {
  String _countryCode = "+966";
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
    // TODO: implement dispose
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
          body:  BlocListener<ForgetPasswordBloc, AppState>(
          bloc: forgetPassword_bloc,
        listener: (context, state) {
      var data = state.model as AuthenticationModel;
      if (state is Loading) {
        print("Loading");
        _playAnimation();
      } else if (state is ErrorLoading) {
        var data = state.model as AuthenticationModel;
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
                      '${data.errormsg}',
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
        print("done");
        _stopAnimation();
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return VerificationCodeScreen(
                route: "ForgetPasswordScreen",
                user_phone:  StaticData.country_code + forgetPassword_bloc.mobile_controller.value,
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
    child:Container(
            height: height(context),
            width: width(context),
            child: Container(
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  passwordTopHeader(context: context,
                  isResetScreen: true),
                  responsiveSizedBox(context: context, percentageOfHeight: .1),
                  Image.asset(
                    "assets/icons/Group 22.png",
                    height: isLandscape(context) ? 2 * height(context) * .25
                        : height(context) * .25,
                  ),
                  responsiveSizedBox(
                      context: context, percentageOfHeight: .035),
                  customDescriptionText(
                      context: context,
                      percentageOfHeight: .03,
                      textColor: blackColor,
                      text: translator.translate("Forget Your Password ?"),
                      fontWeight: FontWeight.w300),
                  responsiveSizedBox(
                      context: context, percentageOfHeight: .035),
                  customDescriptionText(
                      context: context,
                      percentageOfHeight: .018,
                      textColor: blackColor,
                      text: "You will receive an email to reset your password",
                      fontWeight: FontWeight.w300),
                  responsiveSizedBox(
                      context: context, percentageOfHeight: .045),

                  // resetPasswordTextFields(context: context, hint: "Type Your Email"),
                  mobile_textfield(),
                  responsiveSizedBox(context: context, percentageOfHeight: .01),
                 // resendMessageButton(context: context),
                  responsiveSizedBox(context: context, percentageOfHeight: .15),
               //   sendAndDoneButton(context: context)
                  forgetPasswordButton(context: context)
                ],
              )),
            ),
    )),
        ),
      ),
    );
  }

  mobile_textfield() {
    return StreamBuilder<String>(
        stream: forgetPassword_bloc.mobile,
        builder: (context, snapshot) {
          return Container(
              width: width(context) * .9,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: CountryListPick(
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          title: Text(translator.translate('country_code')),
                        ),

                        // if you need custome picker use this
                        pickerBuilder: (context, CountryCode countryCode) {
                          return Container(
                            height: StaticData.get_width(context) * 0.13,
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: blackColor,
                                ),
                                left: BorderSide(color: blackColor),
                                top: BorderSide(color: blackColor),
                                bottom: BorderSide(color: blackColor),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 25,
                                  color: blackColor,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02,
                                ),
                                Image.asset(
                                  countryCode.flagUri,
                                  package: 'country_list_pick',
                                  width: StaticData.get_width(context) * 0.1,
                                  height: StaticData.get_width(context) * 0.1,

                          ),
                              ],
                            ),
                          );
                        },

                        // To disable option set to false
                        theme: CountryTheme(
                          isShowFlag: true,
                          isShowTitle: true,
                          isShowCode: true,
                          isDownIcon: true,
                          showEnglishName: true,
                        ),
                        // Set default value
                        initialSelection: '+966',
                        onChanged: (CountryCode code) {
                          print(code.name);
                          print(code.code);
                          print(code.dialCode);
                          print(code.flagUri);
                            _countryCode = code.dialCode;
                            StaticData.country_code = _countryCode;
                        },
                        // Whether to allow the widget to set a custom UI overlay
                        useUiOverlay: true,
                        // Whether the country list should be wrapped in a SafeArea
                        useSafeArea: false,
                      )),
                 Expanded(
                      child: Container(
                          height: StaticData.get_width(context) * 0.13,
                          decoration: BoxDecoration(
                              border: Border(
                            right: BorderSide(color: blackColor),
                            left: BorderSide(color: blackColor),
                            top: BorderSide(color: blackColor),
                            bottom: BorderSide(color: blackColor),
                          )),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child:  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          StaticData.country_code,
                                          style: TextStyle(
                                              color: blackColor,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 2,
                                          color: blackColor,
                                        )
                                      ],
                                    ),
                                  ),

                              ),
                              Expanded(
                                flex: 3,
                                child: TextField(
                                decoration: InputDecoration(
                                  hintText: translator.translate("Type Your Mobile Number" ),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(fontSize: 12)
                                ),
                                onChanged: forgetPassword_bloc.mobile_change,
                                keyboardType: TextInputType.number,
                              ),)
                            ],
                          ))),
                ],
              ));
        });
  }

  forgetPasswordButton({BuildContext context,}) {
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
          StaticData.user_mobile_number = StaticData.country_code + forgetPassword_bloc.mobile_controller.value;
          forgetPassword_bloc.add(sendOtpClick(
            phone: StaticData.user_mobile_number,
            route: 'ForgetPasswordScreen'
          ));
        },
      ),
    );
  }
}
