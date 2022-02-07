import 'package:almajidoud/utils/file_export.dart';

class LogoutDialog extends StatefulWidget {
  final String name;
  LogoutDialog({this.name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LogoutDialogState();
  }
}

class LogoutDialogState extends State<LogoutDialog> {

  @override
  Widget build(BuildContext context) {

    return StatefulBuilder(
      builder: (context, setState) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return Container(
          width: width,
          height: height ,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(height * .1)),
          child: AlertDialog(
            contentPadding: EdgeInsets.all(0.0),
            content: SafeArea(
              child: SingleChildScrollView(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Container(
                    width: width,
                    height: height / 1.8,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * 0.4)),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: width * 0.06),
                            child: Container(
                            margin: EdgeInsets.all(width * 0.0),
                            child: Column(
                              children: [
                                Text(
                                  widget.name??'',
                                  style: TextStyle(
                                      color: mainColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: AlmajedFont.header_font_size),
                                ),
                                Wrap(
                                  children: [

                                    Text(
                                      translator.translate(" Thanks "),
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: AlmajedFont.primary_font_size),
                                    ),

                                    Text(
                                      translator.translate(translator.translate(" for chossing Us ")    ),
                                      style: TextStyle(
                                          color: mainColor,
                                          fontSize: AlmajedFont.primary_font_size),
                                    ),

                                  ],
                                )
                              ],
                            )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: width * 0.02),
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/icons/Group 9.png',
                            color: mainColor,
                          ),
                          width: width * 0.30,
                          height: width * 0.30,
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: width * 0.02),
                          child: Container(
                            margin: EdgeInsets.all(width * 0.02),
                            child: Text(
                              translator.translate("?Are You Sure You Want To Logout"),
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: AlmajedFont.primary_font_size),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: width * 0.01),
                          child: Padding(
                            padding: EdgeInsets.all(width * 0.05),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                               InkWell(
                                 onTap: (){
                                   Navigator.pop(context);
                                 },
                                 child:  Container(
                                     width: width * .3,
                                     alignment: Alignment.center,
                                     decoration: BoxDecoration(
                                         color: mainColor,
                                         borderRadius:
                                         BorderRadius.circular(8)),
                                     child: customDescriptionText(
                                         context: context,
                                         text: translator.translate("Cancel"),
                                         percentageOfHeight: .025,
                                         textColor: whiteColor),
                                     height: isLandscape(context)
                                         ? 2 * height * .050
                                         : height * .050),
                               ),
                                SizedBox(
                                  width: width * 0.05,
                                ),
                          InkWell(
                            onTap: (){
                              sharedPreferenceManager.removeData(CachingKey.AUTH_TOKEN);
                              StaticData.vistor_value = '';
                              customAnimatedPushNavigation(context, SignInScreen());
                            },
                            child:Container(
                                    width: width * .3,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: mainColor,
                                        borderRadius:
                                        BorderRadius.circular(8)),
                                    child: customDescriptionText(
                                        context: context,
                                        text: "Yes",
                                        percentageOfHeight: .025,
                                        textColor: whiteColor),
                                    height: isLandscape(context)
                                        ? 2 * height * .050
                                        : height * .050),
                          )
                              ],
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
