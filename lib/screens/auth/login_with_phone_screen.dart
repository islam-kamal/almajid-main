import 'package:almajidoud/screens/auth/widgets/already_have_an_account.dart';
import 'package:almajidoud/screens/auth/widgets/send_code_top_header.dart';
import 'package:almajidoud/screens/auth/widgets/send_code_top_icon.dart';
import 'package:almajidoud/screens/auth/widgets/we_will_send_you_code_text.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';
import 'package:flutter/services.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  @override
  LoginWithPhoneScreenState createState() => LoginWithPhoneScreenState();
}

class LoginWithPhoneScreenState extends State<LoginWithPhoneScreen>
    with TickerProviderStateMixin {
  String _countryCode = "+966";
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final _formKey = GlobalKey<FormState>();

 late  AnimationController _loginButtonController;
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
          backgroundColor: mainColor,
          body: BlocListener<ForgetPasswordBloc, AppState>(
              bloc: forgetPassword_bloc,
              listener: (context, state) {
                var data = state.model as AuthenticationModel;
                if (state is Loading) {
                  _playAnimation();
                }
                else if (state is ErrorLoading) {
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
                    duration: Duration(seconds: 3),
                  )..show(_drawerKey.currentState!.context);

                }
                else if (state is Done) {
                  _stopAnimation();
                  Navigator.pushReplacement(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) {
                        return VerificationCodeScreen(
                          route: "LoginWithPhoneScreen",
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
              child:SingleChildScrollView(
                child: Container(
                  height: height(context),
                  width: width(context),
                  child: Container(
                    color: whiteColor,
                      child: Column(
                        children: [
                          sendCodeTopHeader(context: context),
                          responsiveSizedBox(context: context, percentageOfHeight: .1),
                          sendCodeTopIcon(context: context),
                          responsiveSizedBox(context: context, percentageOfHeight: .02),
                          customDescriptionText(
                              context: context,
                              percentageOfHeight: .03,
                              fontWeight: FontWeight.w700,
                              text: "Personal Information",
                              textColor: mainColor),
                          responsiveSizedBox(context: context, percentageOfHeight: .025),
                          Container(

                            child: Column(
                              children: [
                                responsiveSizedBox(context: context, percentageOfHeight: .1),

                            Form(
                              key: _formKey,
                              child: mobile_textfield(),

                            ),

                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .05),
                                weWillSendYouCode(context: context),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .05),
                                LoginUsingPhoneButton(context: context),
                                responsiveSizedBox(context: context, percentageOfHeight: .010),

                                alreadyHaveAnAccount(context: context, isSignUp: false),

                              ],
                            ),
                            height: isLandscape(context)
                                ? 2 * height(context) * .60
                                : height(context) * .60,
                            width: width(context),
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(200),
                                    topLeft: Radius.circular(200))),
                          ),
                        ],
                      )
                  ),
                ),
              ))
        ),
      ),
    );
  }

  mobile_textfield(){
    return  Directionality(
        textDirection: MyApp.app_langauge == 'ar' ? TextDirection.ltr : TextDirection.ltr,
    child: StreamBuilder<String>(
        stream: forgetPassword_bloc.mobile,
        builder: (context, snapshot) {
      if(snapshot.hasError) {
        return Container(
            width: width(context) * .8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                CountryCodePicker(
                  onChanged: (Object object) {
                    _countryCode = object.toString();
                    StaticData.country_code = _countryCode;
                  },
                  initialSelection: MyApp.app_location == 'sa' ? 'SA' : MyApp
                      .app_location == 'kw' ? 'KW' : 'AE',
                  countryFilter: ['SA', 'KW', 'AE'],
                  showFlagDialog: true,
                ),
                Expanded(
                    child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],

                        decoration: InputDecoration(
                          hintText: translator.translate("Phone"),
                          errorText: snapshot.error.toString(),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),

                        ),
                        onChanged: forgetPassword_bloc.mobile_change,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${translator.translate(
                                "Please enter")} ${translator.translate(
                                "Phone")}';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number
                    )
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
                CountryCodePicker(
                  onChanged: (Object object) {
                    _countryCode = object.toString();
                    StaticData.country_code = _countryCode;
                  },
                  initialSelection: MyApp.app_location == 'sa' ? 'SA' : MyApp
                      .app_location == 'kw' ? 'KW' : 'AE',
                  countryFilter: ['SA', 'KW', 'AE'],
                  showFlagDialog: true,
                ),
                Expanded(
                    child: TextFormField(
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],

                        decoration: InputDecoration(
                          hintText: translator.translate("Phone"),
                         // errorText: snapshot.error.toString(),
                          contentPadding: new EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),

                        ),
                        onChanged: forgetPassword_bloc.mobile_change,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '${translator.translate(
                                "Please enter")} ${translator.translate(
                                "Phone")}';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.number
                    )
                ),

              ],
            )


        );
      }
        }));
  }
  LoginUsingPhoneButton({BuildContext? context,}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: StaggerAnimation(
        buttonController: _loginButtonController,
        btn_width:  width(context) * .2,
        btn_height:  isLandscape(context) ? 2 * height(context) * .08 : height(context) * .08,
        widget:  Container(
          decoration: BoxDecoration(color: blackColor, shape: BoxShape.circle),
          child: Center(
            child: Image.asset("assets/icons/right-arrow.png",
                height: isLandscape(context)
                    ? 2 * height(context) * .04
                    : height(context) * .04),
          ),
        ),
        onTap: () {
          if (_formKey.currentState!.validate() ) {
            StaticData.user_mobile_number = StaticData.country_code + forgetPassword_bloc.mobile_controller.value;
            forgetPassword_bloc.add(sendOtpClick(
                phone: StaticData.user_mobile_number,
                route: 'login'
            ));
          }

        },
      ),
    );
  }

}
