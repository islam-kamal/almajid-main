import 'package:almajidoud/screens/categories/categories_screen.dart';
import 'package:almajidoud/screens/home/widgets/categories_buttons.dart';
import 'package:almajidoud/screens/home/widgets/home_bottom_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_header.dart';
import 'package:almajidoud/screens/home/widgets/new_arrivals_listview.dart';
import 'package:almajidoud/screens/home/widgets/title_text.dart';
import 'package:almajidoud/screens/home/widgets/top_slider.dart';
import 'package:almajidoud/utils/file_export.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    FocusNode fieldNode = FocusNode();
    return Scaffold(backgroundColor: whiteColor ,
      key: _drawerKey
      ,body:
      Container(
          height: height(context),width: width(context),
          child:
          Stack(children: [
            Container(
              height: height(context),child:
      SingleChildScrollView(child:
                     Column(
                       children: [
                         responsiveSizedBox(context: context , percentageOfHeight: .13),
                         responsiveSizedBox(context: context , percentageOfHeight: .01),
                         titleText(context: context , text: "Shop By Category") ,
                         responsiveSizedBox(context: context , percentageOfHeight: .01),
                         categoriesButtons(context : context),
                         responsiveSizedBox(context: context , percentageOfHeight: .002),
                         topSlider(context: context),
                         responsiveSizedBox(context: context , percentageOfHeight: .01),
                         titleText(context: context , text: "New Arrivals") ,
                         responsiveSizedBox(context: context , percentageOfHeight: .01),
                         newArrivalsListView(context: context),
                         responsiveSizedBox(context: context , percentageOfHeight: .01),
                         topSlider(context: context),
                         responsiveSizedBox(context: context , percentageOfHeight: .11),],)),
            ),
            Container(height: height(context) , width: width(context) ,
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              homeHeader(context: context , onTapCategoryDrawer: (){
                _drawerKey.currentState.openDrawer();
              })  ,
                homeBottomNavigationBar(context: context)


            ],),) ,
          ],)),
       drawer: SettingsDrawer(
      node: fieldNode,
    ),
     );
  }
}
