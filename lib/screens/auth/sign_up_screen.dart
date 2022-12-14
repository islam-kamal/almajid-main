
import 'package:almajidoud/Bloc/Authentication_Bloc/SignupBloc/sign_up_bloc.dart';
import 'package:almajidoud/Model/AuthenticationModel/authentication_model.dart';

import 'package:almajidoud/screens/auth/widgets/already_have_an_account.dart';

import 'package:almajidoud/screens/auth/widgets/top_auth_buttons.dart';
import 'package:almajidoud/screens/auth/widgets/top_header.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:almajidoud/custom_widgets/stagger_animation.dart';
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with TickerProviderStateMixin {
  String _countryCode = "+966";
  bool? _passwordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  late AnimationController _loginButtonController;
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
      key: _drawerKey,
      backgroundColor: whiteColor,
      body:  BlocListener<SignUpBloc, AppState>(
        bloc: signUpBloc,
        listener: (context, state) {
      if (state is Loading) {
        _playAnimation();
      } else if (state is ErrorLoading) {
        var data = state.model as AuthenticationModel;
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
        )..show(_drawerKey.currentState!.context);

      } else if (state is Done) {
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
                user_phone: StaticData.country_code + signUpBloc.mobile_controller.value,
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
          Form(
            key: _formKey,
            child:Column(
              children: [
                frist_nameTextField(context: context, hint: "First Name"),

                responsiveSizedBox(context: context, percentageOfHeight: .02),
                last_nameTextField(context: context, hint: "Last Name"),

                responsiveSizedBox(context: context, percentageOfHeight: .01),
                mobile_textfield(),

                responsiveSizedBox(context: context, percentageOfHeight: .01),

                emailTextField(context: context, hint: "Email"),

                responsiveSizedBox(context: context, percentageOfHeight: .01),

                passwordTextField(context: context, hint: "Password", isPasswordField: true),
              ],
            )
          ),


              responsiveSizedBox(context: context, percentageOfHeight: .05),
              signButton(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .03),
              alreadyHaveAnAccount(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .03),
            ],
          ),
        ),
      ),)
    )) );
  }

  signButton({BuildContext? context, bool isSignUp: true}) {
    return StaggerAnimation(
      titleButton: isSignUp == true ?   translator.translate("Sign Up") : translator.translate("Sign In"),
      buttonController: _loginButtonController,
      btn_width: width(context) * .7,
      onTap: () {
        if (_formKey.currentState!.validate() ) {
          signUpBloc.add(click());
        }


      }
    );
  }


  frist_nameTextField({BuildContext? context, String? hint,}) {
    return StreamBuilder<String>(
      stream: signUpBloc.fristname,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                  errorText: snapshot.error.toString(),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),
                onChanged:  signUpBloc.fristname_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${translator.translate("Please enter")} ${translator.translate("First Name")}';
                  }
                  return null;
                },
              )
          );
        }else{
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                 // errorText: snapshot.error.toString(),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),
                onChanged:  signUpBloc.fristname_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${translator.translate("Please enter")} ${translator.translate("First Name")}';
                  }
                  return null;
                },
              )
          );
        }


      },
    );

  }

  last_nameTextField({BuildContext? context, String? hint,}) {
    return StreamBuilder<String>(
      stream: signUpBloc.lastname,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                  errorText: snapshot.error.toString(),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),
                onChanged:  signUpBloc.lastname_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${translator.translate("Please enter")} ${translator.translate("Last Name")}';
                  }
                  return null;
                },
              )
          );
        }else{
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                  //errorText: snapshot.error.toString(),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),
                onChanged:  signUpBloc.lastname_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${translator.translate("Please enter")} ${translator.translate("Last Name")}';
                  }
                  return null;
                },
              )
          );
        }


      },
    );

  }

  emailTextField({BuildContext? context, String? hint,}) {
    return StreamBuilder<String>(
      stream: signUpBloc.email,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                  errorText: snapshot.error.toString(),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),
                onChanged:  signUpBloc.email_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${translator.translate("Please enter")} ${translator.translate("Email")}';
                  }
                  return null;
                },
              )
          );
        }else{
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                //  errorText: snapshot.error.toString(),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                ),
                onChanged:  signUpBloc.email_change,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return '${translator.translate("Please enter")} ${translator.translate("Email")}';
                  }
                  return null;
                },
              )
          );
        }


      },
    );

  }

  mobile_textfield(){
    return  StreamBuilder<String>(
        stream: signUpBloc.mobile,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Container(
                width: width(context) * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly
                              ,FilteringTextInputFormatter.deny(RegExp(r'^0+')),],
                            decoration: InputDecoration(


                              hintText: translator.translate("Phone"),
                              errorText: snapshot.error.toString(),
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                            ),
                            onChanged:  signUpBloc.mobile_change,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number
                        )
                    ),
                    CountryCodePicker(
                      onChanged: (Object object){
                        _countryCode=object.toString();
                        StaticData.country_code = _countryCode;
                      },
                      initialSelection: MyApp.app_location == 'sa' ?'SA' : MyApp.app_location == 'kw' ? 'KW' : 'AE',
                      countryFilter: ['SA', 'KW', 'AE' ],
                      showFlagDialog: true,
                    ),
                  ],
                )



            );
          }else{
            return Container(
                width: width(context) * .8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                            decoration: InputDecoration(
                              hintText: translator.translate("Phone"),
                       //       errorText: snapshot.error.toString(),
                              contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                            ),
                            onChanged:  signUpBloc.mobile_change,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number
                        )
                    ),
                    CountryCodePicker(
                      onChanged: (Object object){
                        _countryCode=object.toString();
                        StaticData.country_code = _countryCode;
                      },
                      initialSelection: MyApp.app_location == 'sa' ?'SA' : MyApp.app_location == 'kw' ? 'KW' : 'AE',
                      countryFilter: ['SA', 'KW', 'AE' ],
                      showFlagDialog: true,
                    ),
                  ],
                )



            );
          }

        });
  }

  passwordTextField({BuildContext? context, String? hint, bool isPasswordField: false,
        bool containPrefixIcon: false, IconData? prefixIcon}) {

    return StreamBuilder<String>(
        stream: signUpBloc.password,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Container(
                width: width(context) * .8,
                child: TextFormField(
                  obscureText:!_passwordVisible!,
                  decoration: InputDecoration(
                    prefixIcon: containPrefixIcon == false ? null : Icon(prefixIcon),
                    errorText: snapshot.error.toString(),
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    hintText: translator.translate(hint!),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible! ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible!;
                        });
                      },
                    ),
                  ),
                  onChanged: signUpBloc.password_change,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Password")}';
                    }
                    return null;
                  },
                )
            );
          }else{
            return Container(
                width: width(context) * .8,
                child: TextFormField(
                  obscureText:!_passwordVisible!,
                  decoration: InputDecoration(
                    prefixIcon: containPrefixIcon == false ? null : Icon(prefixIcon),
                  //  errorText: snapshot.error.toString(),
                    contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),

                    hintText: translator.translate(hint!),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible! ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible!;
                        });
                      },
                    ),
                  ),
                  onChanged: signUpBloc.password_change,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Password")}';
                    }
                    return null;
                  },
                )
            );
          }

        });



  }
}
