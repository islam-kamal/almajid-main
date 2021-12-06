
import 'dart:async';

import 'package:almajidoud/custom_widgets/custom_push_named_navigation.dart';
import 'package:almajidoud/screens/auth/get_started_screen.dart';
import 'package:almajidoud/screens/auth/reset_password_screen.dart';
import 'package:almajidoud/screens/auth/widgets/confirm_button_in_verificationCode.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String email;
  final String newEmail;
  final bool isGuestCheckOut;
  final String user_phone;
  final String route;
  const VerificationCodeScreen({
    Key key,
    @required this.email,
    this.newEmail = "",
    this.isGuestCheckOut,
    this.user_phone,
    this.route
  }) : super(key: key);

  @override
  _OtpState createState() => new _OtpState();
}

class _OtpState extends State<VerificationCodeScreen>
    with SingleTickerProviderStateMixin {
  // Constants
  var otp_code;
  final int time = 30;
  AnimationController _controller;

  // Variables
  Size _screenSize;
  int _currentDigit;
  int _firstDigit;
  int _secondDigit;
  int _thirdDigit;
  int _fourthDigit;

  Timer timer;
  int totalTimeInSeconds;
  bool _hideResendButton;

  String userName = "";
  bool didReadNotifications = false;
  int unReadNotificationsCount = 0;

  String number;



  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;

  Future<Null> _playAnimation() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _controller.forward();
    } on TickerCanceled {
      print('[_playAnimation] error');
    }
  }

  Future<Null> _stopAnimation() async {
    try {
      await _controller.reverse();
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
  //  _loginButtonController.dispose();
    _controller.dispose();
    super.dispose();
  }

  // Overridden methods
  @override
  void initState() {
    totalTimeInSeconds = time;
    super.initState();
    user_phone_number();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: time))
          ..addStatusListener((status) {
            if (status == AnimationStatus.dismissed) {
              setState(() {
                _hideResendButton = !_hideResendButton;
              });
            }
          });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
    _startCountdown();
   /* _loginButtonController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);*/
  }

  @override
  Widget build(BuildContext context) {
    _screenSize = MediaQuery.of(context).size;
    number = StaticData.user_mobile_number ;
    return new Scaffold(
      appBar: _getAppbar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: new Container(
          width: _screenSize.width,
//        padding: new EdgeInsets.only(bottom: 16.0),
          child: _getInputPart,
        ),
      )
    );
  }

  // Returns "Otp custom text field"
  Widget _otpTextField(int digit) {
    return new Container(
      width: StaticData.get_width(context) * 0.15,
      height: StaticData.get_width(context) * 0.15,
      alignment: Alignment.center,
      child: new Text(
        digit != null ? digit.toString() : "",
        style: new TextStyle(
          fontSize: 30.0,
          color: whiteColor,
        ),
      ),
      decoration: BoxDecoration(
          color: digit != null ? blackColor : greyColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 2.0,
          )),
    );
  }

  // Returns "Otp keyboard input Button"
  Widget _otpKeyboardInputButton({String label, VoidCallback onPressed}) {
    return new Material(
      color: Colors.transparent,
      child: new InkWell(
        onTap: onPressed,
        borderRadius: new BorderRadius.circular(40.0),
        child: new Container(
          height: 50.0,
          width: 50.0,
          decoration: new BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: new Center(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 30.0,
                color: whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Returns "Otp keyboard action Button"
  _otpKeyboardActionButton({Widget label, VoidCallback onPressed}) {
    return new InkWell(
      onTap: onPressed,
      borderRadius: new BorderRadius.circular(40.0),
      child: new Container(
        height: 80.0,
        width: 80.0,
        decoration: new BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: new Center(
          child: label,
        ),
      ),
    );
  }

  // Current digit
  void _setCurrentDigit(int i) {
    setState(() {
      _currentDigit = i;
      if (_firstDigit == null) {
        _firstDigit = _currentDigit;
      } else if (_secondDigit == null) {
        _secondDigit = _currentDigit;
      } else if (_thirdDigit == null) {
        _thirdDigit = _currentDigit;
      } else if (_fourthDigit == null) {
        _fourthDigit = _currentDigit;

        otp_code = _firstDigit.toString() +
            _secondDigit.toString() +
            _thirdDigit.toString() +
            _fourthDigit.toString();
        print("otp_Code : ${otp_code}");
// Verify your otp by here. API call
      }
    });
  }

  Future<Null> _startCountdown() async {
    setState(() {
      _hideResendButton = true;
      totalTimeInSeconds = time;
    });
    _controller.reverse(
        from: _controller.value == 0.0 ? 1.0 : _controller.value);
  }

  void clearOtp() {
    _fourthDigit = null;
    _thirdDigit = null;
    _secondDigit = null;
    _firstDigit = null;
    setState(() {});
  }

  String user_phone_number()  {
    number = StaticData.user_mobile_number ;
    String replaceCharAt(String oldString, int index, String newChar) {
      return oldString.substring(0, index) +
          newChar +
          oldString.substring(index + 1);
    }
    for (int i = StaticData.country_code.length; i < number.length - 3; i++) {
      number = replaceCharAt(number, i, "*");
    }
    print("newNumber : ${number}");
    return number;
  }

  // Returns "Appbar"
  get _getAppbar {
    return new AppBar(
      backgroundColor: blackColor,
      elevation: 0.0,
      title: Text(
        translator.translate("Verification Code"),
        style: TextStyle(color: whiteColor),
      ),
      leading: new InkWell(
        borderRadius: BorderRadius.circular(30.0),
        child: new Icon(
          Icons.arrow_back_ios,
          color: whiteColor,
          size: 20,
        ),
        onTap: () {
          switch(widget.route){
            case 'SignUpScreen':
              customPushNamedNavigation(context,SignUpScreen());
              break;
            case 'ForgetPasswordScreen':
              customPushNamedNavigation(context,ForgetPasswordScreen());
              break;
            case 'LoginWithPhoneScreen':
              customPushNamedNavigation(context,LoginWithPhoneScreen());
              break;
          }
        },
      ),
      centerTitle: true,
    );
  }

  // Return "Verification Code" label
  get _getVerificationCodeLabel {
    return Padding(
      padding: EdgeInsets.all(StaticData.get_width(context) * 0.05),
      child: new Text(
        translator.translate("Confirmation"),
        // textAlign: TextAlign.right,
        style: new TextStyle(
            fontSize: 22.0, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Return "Email" label
  get _getEmailLabel {
    return Padding(
        padding: EdgeInsets.only(right:StaticData.get_width(context) * 0.06, left: StaticData.get_width(context) * 0.06,
        bottom: StaticData.get_width(context) * 0.06),
        child: new Text(
          "${translator.translate("Please type the verification code sent to")} (${user_phone_number()})",
          textAlign: TextAlign.center,
          style: new TextStyle(
              fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.w600),
        ));
  }

  // Return "OTP" input field
  get _getInputField {
    return Padding(
        padding: EdgeInsets.all(StaticData.get_width(context) * 0.1),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _otpTextField(_firstDigit),
            _otpTextField(_secondDigit),
            _otpTextField(_thirdDigit),
            _otpTextField(_fourthDigit),
          ],
        ));
  }

  // Returns "OTP" input part
  get _getInputPart {
    return new Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _getVerificationCodeLabel,
        _getEmailLabel,
        _getInputField,
        _hideResendButton ? _getTimerText : _getResendButton,
        _getOtpKeyboard
      ],
    );
  }

  // Returns "Timer" label
  get _getTimerText {
    return Container(
      height: 32,
      child: new Offstage(
        offstage: !_hideResendButton,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Icon(Icons.access_time),
            new SizedBox(
              width: 5.0,
            ),
            OtpTimer(_controller, 15.0, Colors.black)
          ],
        ),
      ),
    );
  }

  // Returns "Resend" button
  get _getResendButton {
    return InkWell(
      onTap: () {
        clearOtp();
        _hideResendButton = !_hideResendButton;
        forgetPassword_bloc.add(resendOtpClick(
            route: widget.route
        ));

      },
      child: Container(
          width: width(context) * .95,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              customDescriptionText(
                  context: context,
                  textColor: mainColor,
                  textAlign: TextAlign.end,
                  decoration: TextDecoration.underline,
                  text: "Resend SMS",
                  percentageOfHeight: .018),
              Icon(
                Icons.refresh,
                color: mainColor,
                size: isLandscape(context)
                    ? 2 * height(context) * .025
                    : height(context) * .025,
              ),
            ],
          )),
    );
  }

  // Returns "Otp" keyboard
  get _getOtpKeyboard {
    return Container(
      child: Column(
        children: [
          responsiveSizedBox(context: context, percentageOfHeight: .05),
          _getOtpConfirmationButton,
          responsiveSizedBox(context: context, percentageOfHeight: .02),
          new Container(
              height: _screenSize.width - 80,
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _otpKeyboardInputButton(
                            label: "1",
                            onPressed: () {
                              _setCurrentDigit(1);
                            }),
                        _otpKeyboardInputButton(
                            label: "2",
                            onPressed: () {
                              _setCurrentDigit(2);
                            }),
                        _otpKeyboardInputButton(
                            label: "3",
                            onPressed: () {
                              _setCurrentDigit(3);
                            }),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _otpKeyboardInputButton(
                            label: "4",
                            onPressed: () {
                              _setCurrentDigit(4);
                            }),
                        _otpKeyboardInputButton(
                            label: "5",
                            onPressed: () {
                              _setCurrentDigit(5);
                            }),
                        _otpKeyboardInputButton(
                            label: "6",
                            onPressed: () {
                              _setCurrentDigit(6);
                            }),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _otpKeyboardInputButton(
                            label: "7",
                            onPressed: () {
                              _setCurrentDigit(7);
                            }),
                        _otpKeyboardInputButton(
                            label: "8",
                            onPressed: () {
                              _setCurrentDigit(8);
                            }),
                        _otpKeyboardInputButton(
                            label: "9",
                            onPressed: () {
                              _setCurrentDigit(9);
                            }),
                      ],
                    ),
                  ),
                  new Expanded(
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new SizedBox(
                          width: 80.0,
                        ),
                        _otpKeyboardInputButton(
                            label: "0",
                            onPressed: () {
                              _setCurrentDigit(0);
                            }),
                        _otpKeyboardActionButton(
                            label: new Icon(
                              Icons.backspace,
                              color: whiteColor,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_fourthDigit != null) {
                                  _fourthDigit = null;
                                } else if (_thirdDigit != null) {
                                  _thirdDigit = null;
                                } else if (_secondDigit != null) {
                                  _secondDigit = null;
                                } else if (_firstDigit != null) {
                                  _firstDigit = null;
                                }
                              });
                            }),
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
      //      height: isLandscape(context) ? 2 * height(context) * .49 : height(context) * .49,
      width: width(context),
      decoration: BoxDecoration(
          color: blackColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(200), topLeft: Radius.circular(200))),
    );
  }

  get _getOtpConfirmationButton {
    return GestureDetector(
      onTap: otp_code == null ? (){} :() {
        forgetPassword_bloc.add(checkOtpClick(
            otp_code: otp_code,
          route: widget.route
        ));
      },
      child: BlocListener<ForgetPasswordBloc, AppState>(
          bloc: forgetPassword_bloc,
          listener: (context, state) async {
            var data = state.model as AuthenticationModel;
            if (state is Loading) {
              if (state.indicator == 'checkOtpClick') {
                _playAnimation();
              } else if (state.indicator == 'resendOtpClick') {}
            } else if (state is Done) {
              var data = state.model as AuthenticationModel;

              _stopAnimation();

              if (state.indicator == 'checkOtpClick') {
                print("------- Done ---------");
                switch(widget.route){
                  case 'SignUpScreen':
                    customPushNamedNavigation(context,GetStartedScreen(
                      token: data.token,
                    ));
                    break;
                  case 'ForgetPasswordScreen':
                    customPushNamedNavigation(context,ResetPasswordScreen());
                    break;
                  case 'LoginWithPhoneScreen':
                    customPushNamedNavigation(context,GetStartedScreen(
                      token: data.token,

                    ));
                    break;
                }
              } else if (state.indicator == 'resendOtpClick') {
                customAnimatedPushNavigation(context, VerificationCodeScreen());
              }
            } else if (state is ErrorLoading) {
              print('login ErrorLoading');
              var data = state.model as AuthenticationModel;

              _stopAnimation();
              print('login ErrorLoading 111111111');

              Flushbar(
                messageText: Row(
                  children: [
                    Text(
                      '${data.errormsg}',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(color: whiteColor),
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
                duration: Duration(seconds: 3),
              )..show(context);
              setState(() {
                _hideResendButton = false;
              });           //   customAnimatedPushNavigation(context, GetStartedScreen());
            }
          },
          child: Directionality(
              textDirection: translator.activeLanguageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Container(
                decoration: BoxDecoration(
                    color: greyColor, borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.only(
                    right: width(context) * .0, left: width(context) * .02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    customDescriptionText(
                        context: context,
                        text: "Confirm",
                        percentageOfHeight: .025),
                    Container(
                      decoration: BoxDecoration(
                          color: otp_code == null ? greyColor : greenColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: mainColor, width: 2)),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: isLandscape(context)
                              ? 2 * height(context) * .0
                              : height(context) * .05,
                        ),
                      ),
                      height: isLandscape(context)
                          ? 2 * height(context) * .06
                          : height(context) * .06,
                      width: width(context) * .16,
                    ),
                  ],
                ),
                width: width(context) * .5,
                height: isLandscape(context)
                    ? 2 * height(context) * .06
                    : height(context) * .06,
              ))),
    );
  }
}

class OtpTimer extends StatelessWidget {
  final AnimationController controller;
  double fontSize;
  Color timeColor = Colors.black;

  OtpTimer(this.controller, this.fontSize, this.timeColor);

  String get timerString {
    Duration duration = controller.duration * controller.value;
    if (duration.inHours > 0) {
      return '${duration.inHours}:${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
    }
    return '${duration.inMinutes % 60}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  Duration get duration {
    Duration duration = controller.duration;
    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return new Text(
            timerString,
            style: new TextStyle(
                fontSize: fontSize,
                color: timeColor,
                fontWeight: FontWeight.w600),
          );
        });
  }
}
