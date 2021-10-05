import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/responsive.dart';
import 'package:almajidoud/utils/static_data.dart';
import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final VoidCallback onTap;
  final String titleButton;
  final double btn_width;
  final double btn_height;
  final bool isResetScreen;
  final String image;
  StaggerAnimation(
      {Key key,
      this.buttonController,
      this.onTap,
      this.titleButton = "Sign In",
      this.btn_width,
      this.btn_height,
      this.image,
      this.isResetScreen})
      : buttonSqueezeanimation = Tween(
          begin: 240.0,
          end: 50.0,
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.0,
              0.150,
            ),
          ),
        ),
        containerCircleAnimation = EdgeInsetsTween(
          begin: const EdgeInsets.only(bottom: 30.0),
          end: const EdgeInsets.only(bottom: 0.0),
        ).animate(
          CurvedAnimation(
            parent: buttonController,
            curve: const Interval(
              0.500,
              0.800,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final AnimationController buttonController;
  final Animation<EdgeInsets> containerCircleAnimation;
  final Animation buttonSqueezeanimation;

  Widget _buildAnimation(BuildContext context, Widget child) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: btn_width ?? buttonSqueezeanimation.value,
        height: btn_height ?? height * .07,
        alignment: isResetScreen == null
            ? FractionalOffset.center
            : FractionalOffset.bottomRight,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: buttonSqueezeanimation.value > 75.0
            ? isResetScreen == null
                ? Container(
                    height: isLandscape(context)
                        ? 2 * StaticData.get_height(context) * .06
                        : StaticData.get_height(context) * .06,
                    width: width(context) * .3,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        image== null?  customDescriptionText(
                              context: context,
                              text: isResetScreen == null
                                  ? titleButton
                                  : isResetScreen
                                      ? "Done"
                                      : "Send",
                              textColor: whiteColor) : Center(child: Image.asset(image , height: isLandscape(context)
                            ? 2 * StaticData.get_height(context) * .04
                            : StaticData.get_height(context) * .04),),
                          SizedBox(width: width(context) * .03),
                          isResetScreen == null
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.all(isLandscape(context)
                                      ? 2 *
                                          StaticData.get_height(context) *
                                          .005
                                      : StaticData.get_height(context) * .005),
                                  height: isLandscape(context)
                                      ? 2 * StaticData.get_height(context) * .08
                                      : StaticData.get_height(context) * .08,
                                  width: width(context) * .055,
                                  decoration: BoxDecoration(
                                      color: whiteColor,
                                      shape: BoxShape.circle),
                                  child: Center(
                                      child:
                                          StaticData.get_height(context) == true
                                              ? Icon(
                                                  Icons.check,
                                                  color: blackColor,
                                                  size: isLandscape(context)
                                                      ? 2 *
                                                          StaticData.get_height(
                                                              context) *
                                                          .02
                                                      : StaticData.get_height(
                                                              context) *
                                                          .02,
                                                )
                                              : Image.asset(
                                                  "assets/icons/send.png")))
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: isLandscape(context)
                        ? 2 * StaticData.get_height(context) * .06
                        : StaticData.get_height(context) * .06,
                    width: width(context) * .3,
                    decoration: BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customDescriptionText(
                              context: context,
                              text: isResetScreen ? "Done" : "Send",
                              textColor: whiteColor),
                          SizedBox(width: width(context) * .03),
                          Container(
                              padding: EdgeInsets.all(isLandscape(context)
                                  ? 2 * StaticData.get_height(context) * .005
                                  : StaticData.get_height(context) * .005),
                              height: isLandscape(context)
                                  ? 2 * StaticData.get_height(context) * .08
                                  : StaticData.get_height(context) * .08,
                              width: width(context) * .055,
                              decoration: BoxDecoration(
                                  color: whiteColor, shape: BoxShape.circle),
                              child: Center(
                                  child: StaticData.get_height(context) == true
                                      ? Icon(
                                          Icons.check,
                                          color: blackColor,
                                          size: isLandscape(context)
                                              ? 2 *
                                                  StaticData.get_height(
                                                      context) *
                                                  .02
                                              : StaticData.get_height(context) *
                                                  .02,
                                        )
                                      : Image.asset("assets/icons/send.png")))
                        ],
                      ),
                    ),
                  )
            : const CircularProgressIndicator(
                value: null,
                strokeWidth: 1.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
