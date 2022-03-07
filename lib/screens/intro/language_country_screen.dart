import 'package:almajidoud/utils/file_export.dart';

class LanguageCountryScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LanguageCountryScreenState();
  }

}

class LanguageCountryScreenState extends State<LanguageCountryScreen>{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
        child:Scaffold(
          key: _scaffoldKey,
          body:     Container(
            width: width(context),
            height: height(context),
            decoration: BoxDecoration(
              color: small_grey
            ),
            child:Padding(
              padding: EdgeInsets.symmetric(vertical:width(context) * 0.3, horizontal:width(context) * 0.3 ),
              child: Container(

                child:   Text("Almajed Oud",style: TextStyle(color: mainColor,fontSize: 22,fontWeight: FontWeight.bold),),
              ),
            )

          ),
          bottomSheet: BottomSheet(
            onClosing: (){

            },
            backgroundColor:    small_grey,
            builder: (context){
              return Container(
                height: height(context) * 0.55,
                decoration: BoxDecoration(

                    shape: BoxShape.rectangle,
                    color: whiteColor,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(height(context) * .05),
                        topLeft: Radius.circular(height(context) * .05))
                ),
                child:Column(
                  children: [
                    Expanded(
                        flex: 1,
                        child: Center(
                      child: Text(translator.translate("Select Language" ),style: TextStyle(color: mainColor,fontSize: 14),),
                    )),
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Row(
                            children: [

                            ],
                          )
                        )),
                    Divider(color: mainColor,),
                    Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(translator.translate("Select Country" ),style: TextStyle(color: mainColor,fontSize: 14),),
                        )),
                    Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(translator.translate("Select Language" ),style: TextStyle(color: mainColor,fontSize: 16),),
                        )),
                    Expanded(
                      flex: 1,
                      child:    GestureDetector(
                      onTap: () {

                      },
                      child: Container(
                          width: width(context) * .9,
                          decoration: BoxDecoration(
                              color: mainColor,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(
                              child: customDescriptionText(
                                  context: context,
                                  text: "Continue",
                                  percentageOfHeight: .025,
                                  textColor: whiteColor
                              )
                          ),
                          height: isLandscape(context)
                              ? 2 * height(context) * .065
                              : height(context) * .065),
                    ),)
                  ],
                )
              );
            },
          ),

    )));
  }

}