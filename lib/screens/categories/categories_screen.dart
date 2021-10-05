import 'package:almajidoud/screens/categories/widgets/single_category_item.dart';
import 'package:almajidoud/utils/file_export.dart';
class SettingsDrawer extends StatefulWidget {
  final FocusNode node;
  SettingsDrawer({Key key, this.node}) : super(key: key);
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  void initState() {
    super.initState();
    widget.node.unfocus();
  }

  @override
  void dispose() {
    widget.node.requestFocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          height: height(context),
          color: whiteColor,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                responsiveSizedBox(context: context, percentageOfHeight: .05),
                Container(
                  color: whiteColor,
                  padding: EdgeInsets.only(
                      right: width(context) * .05, left: width(context) * .05),
                  child: Column(
                    children: [
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .01),
                      Container(
                          width: width(context) * .6,
                          child: customDescriptionText(
                              context: context,
                              textAlign: TextAlign.start,
                              textColor: mainColor,
                              text: "Categories",
                              percentageOfHeight: .025)),
                      Divider(
                        color: mainColor,
                      ) ,
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "PERFUME"  , onTapSingleCategory: (){} , imagePath: "assets/icons/perfume (1).png" ) ,
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "PERFUME OIL"  , onTapSingleCategory: (){} , imagePath: "assets/icons/dropper.png" ) ,
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "SPRAY & LOTION"  , onTapSingleCategory: (){} , imagePath: "assets/icons/lotion.png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "OUD & INCENCE"  , onTapSingleCategory: (){} , imagePath: "assets/icons/censer.png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "FRESHENER"  , onTapSingleCategory: (){} , imagePath: "assets/icons/air-freshener (2).png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "COLLECTION"  , onTapSingleCategory: (){} , imagePath: "assets/icons/perfume (1).png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "SAFFRON"  , onTapSingleCategory: (){} , imagePath: "assets/icons/saffron.png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "TESTAHL"  , onTapSingleCategory: (){} , imagePath: "assets/icons/lotion.png" ) ,
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "GIFTS"  , onTapSingleCategory: (){} , imagePath: "assets/icons/surprise.png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "MY ACCOUNT"  , onTapSingleCategory: (){} , imagePath: "assets/icons/profile2.png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "SETTINGS"  , onTapSingleCategory: (){} , imagePath: "assets/icons/settings (3).png" ),
                      responsiveSizedBox(
                          context: context, percentageOfHeight: .02),
                      singleCategoryItem(context: context ,
                          text: "NOTIFICATIONS"  , onTapSingleCategory: (){} , imagePath: "assets/icons/notifi2.png" )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
