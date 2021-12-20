
import 'package:almajidoud/Bloc/Authentication_Bloc/SignupBloc/sign_up_bloc.dart';
import 'package:almajidoud/Model/AuthenticationModel/authentication_model.dart';
import 'package:almajidoud/custom_widgets/custom_animated_push_navigation.dart';
import 'package:almajidoud/custom_widgets/flushbar_widget.dart';
import 'package:almajidoud/screens/auth/widgets/already_have_an_account.dart';
import 'package:almajidoud/screens/auth/widgets/sign_button.dart';
import 'package:almajidoud/screens/auth/widgets/social_media_widget.dart';
import 'package:almajidoud/screens/auth/widgets/auth_text_field.dart';
import 'package:almajidoud/screens/auth/widgets/phone_textfield.dart';

import 'package:almajidoud/screens/auth/widgets/top_auth_buttons.dart';
import 'package:almajidoud/screens/auth/widgets/top_header.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
/*import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_code_picker/country_localizations.dart';*/
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:almajidoud/custom_widgets/stagger_animation.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  String _countryCode = "+966";
  bool _passwordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    StaticData.country_code = _countryCode;
    _passwordVisible = false;
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
      backgroundColor: whiteColor,
      body:  BlocListener<SignUpBloc, AppState>(
        bloc: signUpBloc,
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
          duration: Duration(seconds: 6),
        )..show(_drawerKey.currentState.context);

      } else if (state is Done) {
        print("done");
        _stopAnimation();
        StaticData.user_mobile_number = StaticData.country_code + signUpBloc.mobile_controller.value;
        forgetPassword_bloc.add(sendOtpClick(
            phone: StaticData.user_mobile_number,
            route: 'SignUpScreen'
        ));
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return VerificationCodeScreen(
                route: "SignUpScreen",
                user_phone: StaticData.country_code +signUpBloc.mobile_controller.value,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              topHeader(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .002),
              topAuthButtons(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .1),
              frist_nameTextField(context: context, hint: "First Name"),

              responsiveSizedBox(context: context, percentageOfHeight: .02),
              last_nameTextField(context: context, hint: "Last Name"),

              responsiveSizedBox(context: context, percentageOfHeight: .01),
              mobile_textfield(),

              responsiveSizedBox(context: context, percentageOfHeight: .01),

              emailTextField(context: context, hint: "Email"),

              responsiveSizedBox(context: context, percentageOfHeight: .01),

              passwordTextField(context: context, hint: "Password", isPasswordField: true),

              responsiveSizedBox(context: context, percentageOfHeight: .05),
              signButton(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .05),
              alreadyHaveAnAccount(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .03),
            ],
          ),
        ),
      ),)
    )) );
  }

  signButton({BuildContext context, bool isSignUp: true}) {
    return StaggerAnimation(
      titleButton: isSignUp == true ?   translator.translate("Sign Up") : translator.translate("Sign In"),
      buttonController: _loginButtonController.view,
      btn_width: width(context) * .7,
      onTap: () {
        if(signUpBloc.fristname_controller.valueOrNull != null &&
            signUpBloc.lastname_controller.valueOrNull != null &&
            signUpBloc.mobile_controller.valueOrNull != null &&
            signUpBloc.email_controller.valueOrNull != null &&
            signUpBloc.password_controller.valueOrNull != null
        ){
          signUpBloc.add(click());

        }else{
          Flushbar(
            messageText: Row(
              children: [
                Container(
                  width: StaticData.get_width(context) * 0.7,
                  child: Wrap(
                    children: [
                      Text(
                        'You Must Fill All Fields',
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
            duration: Duration(seconds: 6),
          )..show(_drawerKey.currentState.context);
        }

      },
    );
  }


  frist_nameTextField({BuildContext context, String hint,}) {
    return StreamBuilder<String>(
      stream: signUpBloc.fristname,
      builder: (context, snapshot) {
        return Container(
            width: width(context) * .8,
            child: TextField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint),

                ),
            onChanged:  signUpBloc.fristname_change,
            )
        );

      },
    );

  }

  last_nameTextField({BuildContext context, String hint,}) {
    return StreamBuilder<String>(
      stream: signUpBloc.lastname,
      builder: (context, snapshot) {
        return Container(
            width: width(context) * .8,
            child: TextField(
              decoration: InputDecoration(
                hintText: translator.translate(hint),

              ),
              onChanged:  signUpBloc.lastname_change,
            )
        );

      },
    );

  }

  emailTextField({BuildContext context, String hint,}) {
    return StreamBuilder<String>(
      stream: signUpBloc.email,
      builder: (context, snapshot) {
        return Container(
            width: width(context) * .8,
            child: TextField(
              decoration: InputDecoration(
                hintText: translator.translate(hint),

              ),
              onChanged:  signUpBloc.email_change,
            )
        );

      },
    );

  }

  mobile_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.mobile,
        builder: (context, snapshot) {
          return Container(
            width: width(context) * .8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
                  children: [

                    Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: translator.translate("Phone"),
                          ),
                          onChanged:  signUpBloc.mobile_change,
                            keyboardType: TextInputType.number
                        )
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width *0.25,
                        child:  CountryListPick(
                          appBar: AppBar(
                            backgroundColor: Colors.black,
                            title: Text(translator.translate('country_code')),
                          ),

                          // if you need custome picker use this
                          pickerBuilder: (context, CountryCode countryCode){
                            return Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(countryCode.dialCode,style: TextStyle(color: Colors.black),),
                                SizedBox(width: MediaQuery.of(context).size.width * 0.02,),
                                Image.asset(
                                  countryCode.flagUri,
                                  package: 'country_list_pick',width: 30,height: 20,
                                ),

                              ],
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

                        ) ),
                  ],
                )



          );
        });
  }

  passwordTextField({BuildContext context, String hint, bool isPasswordField: false,
        bool containPrefixIcon: false, IconData prefixIcon}) {

    return StreamBuilder<String>(
        stream: signUpBloc.password,
        builder: (context, snapshot) {
          return Container(
              width: width(context) * .8,
              child: TextField(
                  obscureText:!_passwordVisible,
                  decoration: InputDecoration(
                      prefixIcon: containPrefixIcon == false ? null : Icon(prefixIcon),

                      hintText: translator.translate(hint),
          suffixIcon: IconButton(
          icon: Icon(
          // Based on passwordVisible state choose the icon
          _passwordVisible ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
          // Update the state i.e. toogle the state of passwordVisible variable
          setState(() {
          _passwordVisible = !_passwordVisible;
          });
          },
          ),
          ),
          onChanged: signUpBloc.password_change,
              )
          );
        });


    return Container(
        width: width(context) * .8,
        child: TextField(
            decoration: InputDecoration(
                prefixIcon: containPrefixIcon == false ? null : Icon(prefixIcon),
                hintText: translator.translate(hint),
                suffixIcon: isPasswordField == true
                    ? Icon(
                  MdiIcons.eyeOff,
                  size: 18,
                  color: mainColor,
                )
                    : null)));
  }
}
