import 'package:almajidoud/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:almajidoud/Model/AuthenticationModel/authentication_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/custom_widgets/stagger_animation.dart';
import 'package:almajidoud/screens/auth/get_started_screen.dart';
import 'package:almajidoud/screens/auth/widgets/already_have_an_account.dart';
import 'package:almajidoud/screens/auth/widgets/forget_password_button.dart';
import 'package:almajidoud/screens/auth/widgets/top_auth_buttons.dart';
import 'package:almajidoud/screens/auth/widgets/top_header.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/rendering.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  bool? _passwordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

  late AnimationController _loginButtonController;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    return new Semantics(
      container: true,
      button: true,
      enabled: true,
      child:  NetworkIndicator(
            child: PageContainer(
                child: Scaffold(
                  key: _drawerKey,
                  backgroundColor: whiteColor,
                  body:  BlocListener<SigninBloc, AppState>(
                      bloc: signIn_bloc,
                      listener: (context, state) {
                        if (state is Loading) {
                          _playAnimation();
                        }
                        else if (state is ErrorLoading) {
                          _stopAnimation();
                          Flushbar(
                            messageText:  Text(
                              translator.translate(
                                  "account sign-in was incorrect or your account is disabled temporarily."),
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: whiteColor),
                            ),
                            maxWidth: MediaQuery.of(context).size.width,
                            flushbarPosition: FlushbarPosition.BOTTOM,
                            backgroundColor: redColor,
                            flushbarStyle: FlushbarStyle.FLOATING,
                            duration: Duration(seconds: 6),
                          )..show(_drawerKey.currentState!.context);
                        }
                        else if (state is Done) {
                          var data = state.general_value;
                          _stopAnimation();
                          customPushNamedNavigation(context,GetStartedScreen(
                            token: data,
                            route: 'SignInScreen',
                          ));
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
                              topAuthButtons(context: context, isSignUp: false),
                              responsiveSizedBox(context: context, percentageOfHeight: .1),
                              responsiveSizedBox(context: context, percentageOfHeight: .06),
                              Form(
                                key: _formKey,
                                child:Column(
                                  children: [
                                    emailTextField(
                                      context: context,
                                      hint: "Email",
                                    ),
                                    responsiveSizedBox(context: context, percentageOfHeight: .02),
                                    passwordTextField(
                                        context: context,
                                        hint: "Password",
                                        isPasswordField: true,
                                        containPrefixIcon: true,
                                        prefixIcon: Icons.lock_outline),
                                  ],
                                ),
                              ),

                              responsiveSizedBox(context: context, percentageOfHeight: .02),
                              forgetPasswordButton(context: context),
                              responsiveSizedBox(context: context, percentageOfHeight: .05),
                              signButton(context: context, isSignUp: false),
                              responsiveSizedBox(context: context, percentageOfHeight: .01),
                              loginUsingPhoneText,
                              responsiveSizedBox(context: context, percentageOfHeight: .03),
                              alreadyHaveAnAccount(context: context, isSignUp: false),
                            ],
                          ),
                        ),
                      ) ),
                ))),

    );

  }

  emailTextField({BuildContext? context, String? hint,}) {
    return StreamBuilder<String?>(
      stream: signIn_bloc.email,
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Container(
              width: width(context) * .8,
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: translator.translate(hint!),
                  prefixIcon: Icon(Icons.email_outlined),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  errorText: snapshot.error.toString(),
                ),
                onChanged:  signIn_bloc.email_change,
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
                  prefixIcon: Icon(Icons.email_outlined),
                  contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                 // errorText: snapshot.error.toString(),
                ),
                onChanged:  signIn_bloc.email_change,
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

  passwordTextField({BuildContext? context, String? hint, bool isPasswordField: false,
    bool containPrefixIcon: false, IconData? prefixIcon}) {

    return StreamBuilder<String?>(
        stream: signIn_bloc.password,
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            return Container(
                width: width(context) * .8,
                child: TextFormField(
                  obscureText: !_passwordVisible!,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    contentPadding: new EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    errorText: snapshot.error.toString(),
                    hintText: translator.translate(hint!),
                    suffixIcon: IconButton(
                      icon: Icon(
                        // Based on passwordVisible state choose the icon
                        _passwordVisible! ? Icons.visibility_off : Icons
                            .visibility,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _passwordVisible = !_passwordVisible!;
                        });
                      },
                    ),
                  ),
                  onChanged: signIn_bloc.password_change,
                  validator: (value) {
                    if (value!.length < 8 || value.isEmpty) {
                      return '${translator.translate(
                          "Please enter")} ${translator.translate("Password")}';
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
                    prefixIcon: Icon(Icons.lock_outline),
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
                  onChanged: signIn_bloc.password_change,
                  validator: (value) {
                    if (value!.length < 8 || value.isEmpty) {
                      return '${translator.translate("Please enter")} ${translator.translate("Password")}';
                    }
                    return null;
                  },
                )
            );
          }

        });

  }


  signButton({BuildContext? context, bool isSignUp: true}) {

      return StaggerAnimation(
        titleButton: isSignUp == true
            ? translator.translate("SING UP")
            : translator.translate("Sign In"),
        buttonController: _loginButtonController,
        btn_width: width(context) * .7,
        onTap: () {

    if (_formKey.currentState!.validate() ) {
      signIn_bloc.add(click());
    }
        },
      );
    }


  get loginUsingPhoneText {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(translator.translate("OR"),style: TextStyle(color: Colors.grey,),),
        responsiveSizedBox(context: context, percentageOfHeight: .03),

        InkWell(
          onTap: (){

            customPushNamedNavigation(
              context,LoginWithPhoneScreen());
          },
          child: Text(
            translator.translate("!Continue Using Phone Number"),
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize:AlmajedFont.primary_font_size
            ),
          ),
        )
      ],
    );
  }
}
