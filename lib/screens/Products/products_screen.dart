import 'package:almajidoud/utils/file_export.dart';

class ProductsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductsScreenState();
  }

}
class ProductsScreenState extends State<ProductsScreen>{
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
          backgroundColor: whiteColor,
          key: _drawerKey,
          body: Container(
              height: height(context),
              width: width(context),
              child: Stack(
                children: [
                  Container(
                    height: height(context),
                    child: SingleChildScrollView(
                        child: Container() /*Column(
                          children: [
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .13),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            titleText(context: context, text: "Shop By Category"),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            categoriesButtons(context: context),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .002),
                            topSlider(context: context),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            titleText(context: context, text: "New Arrivals"),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            newArrivalsListView(context: context),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .01),
                            topSlider(context: context),
                            responsiveSizedBox(
                                context: context, percentageOfHeight: .11),
                          ],
                        )*/),
                  ),
                ],
              )),
        ),
      ),
    );
  }

}