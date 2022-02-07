import 'package:almajidoud/Bloc/Authentication_Bloc/SignupBloc/sign_up_bloc.dart';

import 'package:almajidoud/screens/auth/widgets/forget_password_button.dart';
import 'package:almajidoud/screens/auth/widgets/forget_password_top_header.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:country_code_picker/country_code_picker.dart';
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
          backgroundColor: backGroundColor,
          body:  BlocListener<ForgetPasswordBloc, AppState>(
          bloc: forgetPassword_bloc,
        listener: (context, state) {
      var data = state.model as AuthenticationModel;
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
          duration: Duration(seconds: 3),
        )..show(_drawerKey.currentState.context);

      } else if (state is Done) {
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

                  Form(
                      key: _formKey,
                      child: mobile_textfield(),

                  ),
                  responsiveSizedBox(context: context, percentageOfHeight: .01),
                  responsiveSizedBox(context: context, percentageOfHeight: .15),
                  forgetPasswordButton(context: context)
                ],
              )),
            ),
    )),
        ),
      ),
    );
  }


  mobile_textfield(){
    return  StreamBuilder<String>(
        stream: forgetPassword_bloc.mobile,
        builder: (context, snapshot) {
          return Container(
              width: width(context) * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  CountryCodePicker(
                    onChanged: (Object object){
                      _countryCode=object.toString();
                      StaticData.country_code = _countryCode;
                    },
                    initialSelection: MyApp.app_location == 'sa' ?'SA' : MyApp.app_location == 'kw' ? 'KW' : 'AE',
                    countryFilter: ['SA', 'KW', ],
                    showFlagDialog: true,
                  ),
                  Expanded(
                      child: TextFormField(
                          decoration: InputDecoration(
                            hintText: translator.translate("Phone"),
                            errorText: snapshot.error,
                          ),
                          onChanged:  forgetPassword_bloc.mobile_change,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '${translator.translate("Please enter")} ${translator.translate("Phone")}';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number
                      )
                  ),

                ],
              )



          );
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
          if (_formKey.currentState.validate() ) {
            StaticData.user_mobile_number = StaticData.country_code + forgetPassword_bloc.mobile_controller.value;
            forgetPassword_bloc.add(sendOtpClick(
                phone: StaticData.user_mobile_number,
                route: 'ForgetPasswordScreen'
            ));
          }

        },
      ),
    );
  }
}
