import 'package:almajidoud/screens/my_account/widgets/account_navigation_bar.dart';
import 'package:almajidoud/screens/my_account/widgets/logout_button.dart';
import 'package:almajidoud/screens/my_account/widgets/my_account_header.dart';
import 'package:almajidoud/screens/my_account/widgets/single_account_item.dart';
import 'package:almajidoud/screens/my_account/widgets/user_email.dart';
import 'package:almajidoud/screens/my_account/widgets/user_image_widget.dart';
import 'package:almajidoud/screens/my_account/widgets/user_name.dart';
import 'package:almajidoud/utils/file_export.dart';

class MyAccountScreen extends StatefulWidget {
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
          height: height(context),
          width: width(context),
          child: Stack(
            children: [
              Container(
                height: height(context),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .13),
                    userImageWidget(
                        context: context,
                        imagePath:
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyj-wgGa-GZ1vJSGgmf6LCmvd7fxUgl-Pl0w&usqp=CAU",
                        onTapAddImage: () {
                          print("add image tapped ");
                        }),
                    userName(context: context, name: "User Name"),
                    userEmail(context: context, email: "user@gmail.com"),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .03),

                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/share.png",
                        text: "Edit Profile",
                        isContainMoreIcon: true , onTap: (){}),
                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/tracking.png",
                        text: "My Orders" , isContainMoreIcon: true  , onTap: (){}),
                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/credit-card.png",
                        text: "My Cards" , isContainMoreIcon: true  , onTap: (){}),
                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/settings (3).png",
                        text: "Settings" , isContainMoreIcon: true  , onTap: (){}),
                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/help.png",
                        text: "Help Center" , isContainMoreIcon: true  , onTap: (){}),
                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/share.png",
                        text: "Share With Friends" , onTap: (){}  ),
                    singleAccountItem(
                        context: context,
                        iconPath: "assets/icons/star solid.png",
                        text: "Rate Us On Google Play"),
                    logoutButton(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .11),
                  ],
                )),
              ),
              Container(
                height: height(context),
                width: width(context),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    myAccountHeader(context: context),
                    accountBottomNavigationBar(context: context)
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
