import 'package:almajidoud/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:almajidoud/Model/AuthenticationModel/authentication_model.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/custom_widgets/stagger_animation.dart';
import 'package:almajidoud/screens/auth/get_started_screen.dart';
import 'package:almajidoud/screens/auth/widgets/already_have_an_account.dart';
import 'package:almajidoud/screens/auth/widgets/forget_password_button.dart';
import 'package:almajidoud/screens/auth/widgets/top_auth_buttons.dart';
import 'package:almajidoud/screens/auth/widgets/top_header.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with TickerProviderStateMixin {
  bool _passwordVisible;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AnimationController _loginButtonController;
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
      body:  BlocListener<SigninBloc, AppState>(
        bloc: signIn_bloc,
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
        var data = state.model as AuthenticationModel;

        print("done");
        _stopAnimation();
        sharedPreferenceManager.removeData(CachingKey.CART_QUOTE);

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) {
              return GetStartedScreen(
                token: data.token,
                route: 'SignInScreen',
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
              topAuthButtons(context: context, isSignUp: false),
              responsiveSizedBox(context: context, percentageOfHeight: .1),
              responsiveSizedBox(context: context, percentageOfHeight: .06),
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
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              forgetPasswordButton(context: context),
              responsiveSizedBox(context: context, percentageOfHeight: .13),
              signButton(context: context, isSignUp: false),
              responsiveSizedBox(context: context, percentageOfHeight: .02),
              loginUsingPhoneText,
              responsiveSizedBox(context: context, percentageOfHeight: .083),
              alreadyHaveAnAccount(context: context, isSignUp: false),
            ],
          ),
        ),
    ) ),
    )));
  }

  emailTextField({BuildContext context, String hint,}) {
    return StreamBuilder<String>(
      stream: signIn_bloc.email,
      builder: (context, snapshot) {
        return Container(
            width: width(context) * .8,
            child: TextField(
              decoration: InputDecoration(
                hintText: translator.translate(hint),
                prefixIcon: Icon(Icons.email_outlined)
              ),
              onChanged:  signIn_bloc.email_change,

            )
        );

      },
    );

  }

  passwordTextField({BuildContext context, String hint, bool isPasswordField: false,
    bool containPrefixIcon: false, IconData prefixIcon}) {

    return StreamBuilder<String>(
        stream: signIn_bloc.password,
        builder: (context, snapshot) {
          return Container(
              width: width(context) * .8,
              child: TextField(
                obscureText:!_passwordVisible,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),

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
                onChanged: signIn_bloc.password_change,
              )
          );
        });

  }


  signButton({BuildContext context, bool isSignUp: true}) {
    return StaggerAnimation(
      titleButton: isSignUp == true
          ? translator.translate("SING UP")
          : translator.translate("Sign In"),
      buttonController: _loginButtonController.view,
      btn_width: width(context) * .7,
      onTap: () {
        signIn_bloc.add(click(
          context: context
        ));
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
