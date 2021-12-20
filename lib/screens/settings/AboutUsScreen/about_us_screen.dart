import 'package:almajidoud/utils/file_export.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
          child:  WillPopScope(
            onWillPop: (){
              customPushNamedNavigation(context,SettingsScreen());
            },
            child: Scaffold(
              backgroundColor: whiteColor,
              body:  Column(
                children: [
                  ScreenAppBar(
                    right_icon: 'cart',
                    category_name: translator.translate("About Us" ),
                    screen: SettingsScreen(),
                  ),
                  Expanded(child: Container(
                    height: height(context),
                    child: NestedScrollView(
                      headerSliverBuilder:
                          (BuildContext context, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            leading: null,
                            expandedHeight: isLandscape(context)
                                ? 2 * height(context) * .4
                                : height(context) * .4,
                            floating: false,
                            backgroundColor: whiteColor,
                            elevation: 0,
                            pinned: false,
                            flexibleSpace: FlexibleSpaceBar(
                              background: Container(
                                width: width(context),
                                height: isLandscape(context)
                                    ? 2 * height(context) * .4
                                    : 2 * height(context) * .4,
                                child: Image.asset(
                                  "assets/images/intro1.png" , fit: BoxFit.fill,),
                              ),
                            ),
                          )
                        ];
                      },
                      body: Container(
                          height: height(context) * .7,
                          padding: EdgeInsets.only(
                              right: width(context) * .05, left: width(context) * .05),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .01),
                                Row(
                                  children: [
                                    customDescriptionText(
                                        context: context,
                                        percentageOfHeight: .025,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start,
                                        textHeight: 1.3,
                                        maxLines: 500,
                                        textColor: mainColor.withOpacity(.7),
                                        text: "lorim ipsum")
                                  ],
                                ),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .01),
                                customDescriptionText(
                                    context: context,
                                    percentageOfHeight: .022,
                                    textAlign: TextAlign.justify,
                                    textHeight: 1.3,
                                    maxLines: 500,
                                    textColor: greyColor.withOpacity(.7),
                                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .01),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .01),
                                Row(
                                  children: [
                                    customDescriptionText(
                                        context: context,
                                        percentageOfHeight: .025,
                                        fontWeight: FontWeight.bold,
                                        textAlign: TextAlign.start,
                                        textHeight: 1.3,
                                        maxLines: 500,
                                        textColor: mainColor.withOpacity(.7),
                                        text: "lorim ipsum")
                                  ],
                                ),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .01),
                                customDescriptionText(
                                    context: context,
                                    percentageOfHeight: .022,
                                    textAlign: TextAlign.justify,
                                    textHeight: 1.3,
                                    maxLines: 500,
                                    textColor: greyColor.withOpacity(.7),
                                    text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum"),
                                responsiveSizedBox(
                                    context: context, percentageOfHeight: .01),


                              ],
                            ),
                          )),
                    ),
                  ),)
                ],
              ),
            ),
          )
      )
    );
  }
}
