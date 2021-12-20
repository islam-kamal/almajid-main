import 'package:almajidoud/screens/auth/widgets/already_have_an_account.dart';
import 'package:almajidoud/screens/auth/widgets/choose_country_widget_in_reset_password.dart';
import 'package:almajidoud/screens/auth/widgets/phone_number_widget_in_reset_password.dart';
import 'package:almajidoud/screens/auth/widgets/send_button_in_reset_password.dart';
import 'package:almajidoud/screens/auth/widgets/send_code_top_header.dart';
import 'package:almajidoud/screens/auth/widgets/send_code_top_icon.dart';
import 'package:almajidoud/screens/auth/widgets/we_will_send_you_code_text.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:country_list_pick/country_list_pick.dart';

class LoginWithPhoneScreen extends StatefulWidget {
  @override
  LoginWithPhoneScreenState createState() => LoginWithPhoneScreenState();
}

class LoginWithPhoneScreenState extends State<LoginWithPhoneScreen>
    with TickerProviderStateMixin {
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
          backgroundColor: mainColor,
          body: BlocListener<ForgetPasswordBloc, AppState>(
              bloc: forgetPassword_bloc,
              listener: (context, state) {
                var data = state.model as AuthenticationModel;
                if (state is Loading) {
                  print("Loading");
                  _playAnimation();
                }
                else if (state is ErrorLoading) {
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

                }
                else if (state is Done) {
                  print("done");
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
                              textColor: whiteColor),
                          responsiveSizedBox(context: context, percentageOfHeight: .025),
                          Container(
                            child: Column(
                              children: [
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .1),
                                //  chooseCountryWidgetInResetPassword(context: context) ,
                                //  responsiveSizedBox(context: context, percentageOfHeight: .02) ,
                                // phoneNumberWidgetInResetPassword(context: context) ,
                                mobile_textfield(),

                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .02),
                                weWillSendYouCode(context: context),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .04),
                                //  sendButtonInResetPassword(context: context)
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

  mobile_textfield() {
    return StreamBuilder<String>(
        stream: forgetPassword_bloc.mobile,
        builder: (context, snapshot) {
          return Container(
              width: width(context) * .9,
              height: width(context) * .42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: CountryListPick(
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          title: Text(translator.translate('country_code')),
                        ),

                        // if you need custome picker use this
                        pickerBuilder: (context, CountryCode countryCode) {
                          return Neumorphic(
                            child: Container(
                              height: StaticData.get_width(context) * 0.13,
                              padding: EdgeInsets.only(
                                  right: width(context) * .02,
                                  left: width(context) * .02),
                              color: whiteColor,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    countryCode.flagUri,
                                    package: 'country_list_pick',
                                    width: StaticData.get_width(context) * 0.15,
                                    height: StaticData.get_width(context) * 0.1,
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 25,
                                    color: blackColor,
                                  ),
                                ],
                              ),
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
                      child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                            height: StaticData.get_width(context) * 0.1,
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(color: blackColor),
                              left: BorderSide(color: blackColor),
                              top: BorderSide(color: blackColor),
                              bottom: BorderSide(color: blackColor),
                            ),
                            ),
                            child: TextField(
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: StaticData.country_code,
                                  border: InputBorder.none,
                                  enabled: false,
                                  hintStyle: TextStyle(fontSize: 12,)),

                            )),
                      ),
                      Expanded(
                          flex: 1,
                          child: Container()),
                      Expanded(
                        flex: 6,
                        child: Container(
                            height: StaticData.get_width(context) * 0.1,
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(color: blackColor),
                              left: BorderSide(color: blackColor),
                              top: BorderSide(color: blackColor),
                              bottom: BorderSide(color: blackColor),
                            )),
                            child: TextField(
                              textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                    hintText: translator
                                        .translate("Type Your Mobile Number"),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 12)),
                                onChanged: forgetPassword_bloc.mobile_change,
                                keyboardType: TextInputType.number,
                              ),

                        ),
                      )
                    ],
                  )),

                ],
              ));
        });
  }

  LoginUsingPhoneButton({BuildContext context,}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      child: StaggerAnimation(
        buttonController: _loginButtonController.view,
        btn_width: width(context) * .15,
        btn_height:  width(context) * .15,
        image: "assets/icons/right-arrow.png",
        onTap: () {
          StaticData.user_mobile_number = StaticData.country_code + forgetPassword_bloc.mobile_controller.value;
          forgetPassword_bloc.add(sendOtpClick(
              phone: StaticData.user_mobile_number,
              route: 'login'
          ));
        },
      ),
    );
  }

}
