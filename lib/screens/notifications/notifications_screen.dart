import 'package:almajidoud/screens/notifications/widgets/no_notifications_widget.dart';
import 'package:almajidoud/screens/notifications/widgets/notifications_header.dart';
import 'package:almajidoud/screens/notifications/widgets/single_notification_card.dart';
import 'package:almajidoud/utils/file_export.dart';
class NotificationsScreen extends StatelessWidget {
  bool thereIsNotifications = false  ;

  NotificationsScreen({this.thereIsNotifications});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:thereIsNotifications == true ? mainColor :whiteColor,
      body: Container(
        height: height(context),
        width: width(context),
        child: Container(
          child: SingleChildScrollView(
              child:
                  thereIsNotifications == true ?
              Column(
                children: [
                  notificationsHeader(context: context),
                  Divider(color: whiteColor,thickness: 5 ),
                  responsiveSizedBox(context: context , percentageOfHeight: .02),
                  Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
                    child: Row(children: [
                      customDescriptionText(context: context , text: "Today" , textColor: whiteColor ,percentageOfHeight: .025 , textAlign: TextAlign.start),
                    ],),
                  ) ,
                  responsiveSizedBox(context: context , percentageOfHeight: .01) ,
                  Container(height: height(context)*.5,
                    child: ListView.builder(itemBuilder: (context , index ){
                      return  singleNotificationCard(context: context , index: index);

                    } , itemCount:3),
                  ),
                  Divider(color: whiteColor,thickness: 5 ),
                  responsiveSizedBox(context: context , percentageOfHeight: .02),
                  Container(padding: EdgeInsets.only(right: width(context)*.05 , left: width(context)*.05),
                    child: Row(children: [
                      customDescriptionText(context: context , text: "Yesterday" , textColor: whiteColor ,
                          percentageOfHeight: .025 , textAlign: TextAlign.start),
                    ],),
                  ) ,
                  responsiveSizedBox(context: context , percentageOfHeight: .01) ,
                  Container(height: height(context)*.5,
                    child: ListView.builder(itemBuilder: (context , index ){
                      return  singleNotificationCard(context: context , index: index);

                    } , itemCount:3),
                  ),



                ],
              ) : noNotificationsWidget(context: context)) ,
        ),
      ),
    );
  }
}
