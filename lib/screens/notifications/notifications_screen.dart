import 'package:almajidoud/screens/notifications/widgets/no_notifications_widget.dart';
import 'package:almajidoud/screens/notifications/widgets/notifications_header.dart';
import 'package:almajidoud/screens/notifications/widgets/single_notification_card.dart';
import 'package:almajidoud/utils/file_export.dart';

class NotificationsScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationsScreenState();
  }

}

class NotificationsScreenState extends State<NotificationsScreen> {
  bool thereIsNotifications = false;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: WillPopScope(
      onWillPop: () {
        customPushNamedNavigation(context, HomeScreen());
      },
      child: Scaffold(
        key: _drawerKey,
        body: Column(
          children: [
          Expanded(child:   Container(
            height: height(context),
            width: width(context),
            child: thereIsNotifications == true ?  Container(
              color: greyColor,
              child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ScreenAppBar(
                        right_icon: "assets/icons/notifi.png",
                        category_name: translator.translate("Notifications"),
                      ),
                      responsiveSizedBox(context: context, percentageOfHeight: .02),
                      Container(
                        padding: EdgeInsets.only(
                            right: width(context) * .05, left: width(context) * .05),
                        child: Row(
                          children: [
                            customDescriptionText(
                                context: context,
                                text: "Today",
                                textColor: whiteColor,
                                percentageOfHeight: .025,
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      responsiveSizedBox(context: context, percentageOfHeight: .01),
                      Container(
                        height: height(context) * .5,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return singleNotificationCard(
                                  context: context, index: index);
                            },
                            itemCount: 3),
                      ),
                      Divider(color: whiteColor, thickness: 5),
                      responsiveSizedBox(context: context, percentageOfHeight: .02),
                      Container(
                        padding: EdgeInsets.only(
                            right: width(context) * .05, left: width(context) * .05),
                        child: Row(
                          children: [
                            customDescriptionText(
                                context: context,
                                text: "Yesterday",
                                textColor: whiteColor,
                                percentageOfHeight: .025,
                                textAlign: TextAlign.start),
                          ],
                        ),
                      ),
                      responsiveSizedBox(context: context, percentageOfHeight: .01),
                      Container(
                        height: height(context) * .5,
                        child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return singleNotificationCard(
                                  context: context, index: index);
                            },
                            itemCount: 3),
                      ),
                    ],
                  )

              ),
            ) : no_notifications_widget() ,
          ),),


          ],
        )
      ),
    )));
  }

  Widget no_notifications_widget(){
    return Container(
      color: whiteColor,
      child: Column(
        children: [
          responsiveSizedBox(context: context , percentageOfHeight: .25),
          Image.asset("assets/icons/Group 10.png" , width: width(context)*.7,),
          responsiveSizedBox(context: context , percentageOfHeight: .02),
          customDescriptionText(context: context , textColor: mainColor , text: "No Notifications Yet !" , percentageOfHeight: .03) ,
          responsiveSizedBox(context: context , percentageOfHeight: .02),
          customDescriptionText(context: context , textColor: greyColor , text: "Tap the button below to referesh and check again") ,
          responsiveSizedBox(context: context , percentageOfHeight: .1),
          InkWell(
            child:     Container(
                width: width(context) * .8,
                decoration: BoxDecoration(
                    color: mainColor, borderRadius: BorderRadius.circular(8)),
                child: Center(
                    child: customDescriptionText(
                        context: context,
                        text: "Refresh",

                        percentageOfHeight: .025,
                        textColor: whiteColor)),
                height: isLandscape(context)
                    ? 2 * height(context) * .065
                    : height(context) * .065),
            onTap: (){
              setState(() {
                thereIsNotifications = !thereIsNotifications;
              });
            },
          )





        ],
      ),
    );
  }
}
