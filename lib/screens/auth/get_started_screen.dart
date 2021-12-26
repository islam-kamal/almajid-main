import 'package:almajidoud/Bloc/Authentication_Bloc/SigninBloc/sign_in_bloc.dart';
import 'package:almajidoud/Repository/CartRepo/cart_repository.dart';
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/home_screen.dart';
import 'package:almajidoud/utils/file_export.dart';

class GetStartedScreen extends StatefulWidget {
  final String token;
  final String route;
  GetStartedScreen({this.token,this.route});
  @override
  GetStartedScreenState createState() => new GetStartedScreenState();
}

class GetStartedScreenState extends State<GetStartedScreen>
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
          child: Scaffold(
              key: _drawerKey,
              backgroundColor: whiteColor,
              body: BlocListener<SigninBloc, AppState>(
                  bloc: signIn_bloc,
                  listener: (context, state) {
                    var data = state.model as UserInfoModel;
                    if (state is Loading) {
                      print("Loading");
                      _playAnimation();
                    } else if (state is ErrorLoading) {
                      var data = state.model as UserInfoModel;
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
                                    '${data.message}',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(color: whiteColor),
                                  ),
                                ],
                              ),
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
                      print("done");
                      _stopAnimation();
                      StaticData.vistor_value = null;
                      cartRepository.create_quote(context:context);

                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) {
                            return CustomCircleNavigationBar(page_index: 2,);
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
                  child: Center(
                    child: Column(
                      children: [
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .25),
                        Image.asset(
                          "assets/icons/Group 10.png",
                          width: width(context) * .7,
                        ),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        customDescriptionText(
                            context: context,
                            textColor: mainColor,
                            text: translator.translate("Awesome !"),
                            percentageOfHeight: .03),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .02),
                        customDescriptionText(
                            context: context,
                            textColor: greyColor,
                            text: widget.route == 'SignInScreen' ?translator.translate("Your Account has been verified sucessfully")
                              : translator.translate("Your phone number has been verified sucessfully"),
                            percentageOfHeight: .025,
                            maxLines: 3),
                        responsiveSizedBox(
                            context: context, percentageOfHeight: .1),

                        getStartedButton(
                            context:context
                        ),
                      ],
                    ),
                  )))),
    );
  }

  getStartedButton({BuildContext context, bool isSignUp: true}) {
    return StaggerAnimation(
      titleButton:translator.translate( "Get Started",),
      buttonController: _loginButtonController.view,
      btn_width: width(context) * .7,
      onTap: () {
        signIn_bloc.add(UserInfoClick(
            token:  widget.token
             ));
      },
    );
  }
}
