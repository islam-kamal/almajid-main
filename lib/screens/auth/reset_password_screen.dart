import 'package:almajidoud/screens/auth/sing_in_screen.dart';
import 'package:almajidoud/screens/auth/widgets/forget_password_top_header.dart';
import 'package:almajidoud/screens/auth/widgets/resend_message_button.dart';
import 'package:almajidoud/screens/auth/widgets/reset_password_text_fields.dart';
import 'package:almajidoud/screens/auth/widgets/send_or_done_button.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  @override
  ResetPasswordScreenState createState() => ResetPasswordScreenState();
}

class ResetPasswordScreenState extends State<ResetPasswordScreen>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

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
    return NetworkIndicator(
      child: PageContainer(
          child: BlocListener<ForgetPasswordBloc, AppState>(
              bloc: forgetPassword_bloc,
              listener: (context, state) {
                if (state is Loading) {
                  _playAnimation();
                } else if (state is ErrorLoading) {
                  var data = state.model as ResetPasswordModel;
                  _stopAnimation();
                  Flushbar(
                    messageText: Row(
                      children: [
                        Text(
                          '${state.message == null? data.errormsg : state.message}',
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
                    duration: Duration(seconds: 6),
                  )..show(_drawerKey.currentState.context);
                } else if (state is Done) {
                  var data = state.model as ResetPasswordModel;

                  print("done");
                  _stopAnimation();
print("11111111111111111111111");
                  Flushbar(
                    messageText: Row(
                      children: [
                        Container(
                          width: StaticData.get_width(context) * 0.7,
                          child: Wrap(
                            children: [
                              Text(
                                '${data.successmsg}',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(color: whiteColor),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: (){
                            Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (Context)=>SignInScreen()
                            ));
                          },
                          child:  Text(
                            translator.translate( "sign in"),
                            textDirection: TextDirection.rtl,
                            style: TextStyle(color: whiteColor),
                          ),
                        )
                      ],
                    ),
                    flushbarPosition: FlushbarPosition.BOTTOM,
                    backgroundColor: greenColor,
                    flushbarStyle: FlushbarStyle.FLOATING,
                  )..show(_drawerKey.currentState.context);
                }
              },
              child: Directionality(
                textDirection: translator.currentLanguage == 'ar'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                child: Scaffold(
                  backgroundColor: backGroundColor,
                  key: _drawerKey,
                  body: Container(
                    height: height(context),
                    width: width(context),
                    child: Container(
                      child: SingleChildScrollView(
                          child: Column(
                        children: [
                          passwordTopHeader(
                              context: context, isResetScreen: true),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .1),
                          Image.asset(
                            "assets/icons/Group 22.png",
                            height: isLandscape(context)
                                ? 2 * height(context) * .25
                                : height(context) * .25,
                          ),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .035),
                          customDescriptionText(
                              context: context,
                              percentageOfHeight: .03,
                              textColor: blackColor,
                              text: "Reset Your Password",
                              fontWeight: FontWeight.w300),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .06),
                          //   resetPasswordTextFields(context: context, hint: "Verification Code"),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .02),
                          passwordTextField(
                              context: context, hint: "New Password"),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .02),
                          confirmPasswordTextField(
                              context: context, hint: "Retype New Password"),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .10),
                          //  sendAndDoneButton(context: context, isResetScreen: true)
                          ResetPasswordButton(context: context),
                        ],
                      )),
                    ),
                  ),
                ),
              ))),
    );
  }

  ResetPasswordButton({
    BuildContext context,
  }) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.all(10),
      child: StaggerAnimation(
        titleButton: translator.translate("Done"),
        buttonController: _loginButtonController.view,
        btn_width: width(context) * .3,
        btn_height: width(context) * .1,
        isResetScreen: true,
        onTap: () {
          forgetPassword_bloc.add(changePasswordClick());
        },
      ),
    );
  }

  passwordTextField({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: forgetPassword_bloc.password,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .08
              : height(context) * .08,
          child: TextFormField(
            style: TextStyle(
                color: blackColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            onChanged: forgetPassword_bloc.password_change,
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(1),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: whiteColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: blackColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: blackColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: blackColor)),
            ),
          ),
        );
      },
    );
  }

  confirmPasswordTextField({BuildContext context, String hint}) {
    return StreamBuilder<String>(
      stream: forgetPassword_bloc.confirm_password,
      builder: (context, snapshot) {
        return Container(
          padding: EdgeInsets.only(
              right: width(context) * .05, left: width(context) * .05),
          height: isLandscape(context)
              ? 2 * height(context) * .08
              : height(context) * .08,
          child: TextFormField(
            style: TextStyle(
                color: blackColor,
                fontSize: isLandscape(context)
                    ? 2 * height(context) * .02
                    : height(context) * .02),
            cursorColor: greyColor.withOpacity(.5),
            onChanged: forgetPassword_bloc.confirm_password_change,
            decoration: InputDecoration(
              hintText: translator.translate(hint),
              hintStyle: TextStyle(
                  color: greyColor.withOpacity(1),
                  fontWeight: FontWeight.bold,
                  fontSize: isLandscape(context)
                      ? 2 * height(context) * .018
                      : height(context) * .018),
              filled: true,
              fillColor: whiteColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: blackColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: blackColor)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3),
                  borderSide: BorderSide(color: blackColor)),
            ),
          ),
        );
      },
    );
  }
}
