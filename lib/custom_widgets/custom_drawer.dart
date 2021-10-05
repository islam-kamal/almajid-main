//import 'package:shareef/custom_widgets/custom_description_text.dart';
//import 'package:shareef/utils/file_export.dart';
//
//class Category {
//  Category(this.icon, this.itemText, this.isPressed  , this.isNew );
//  Widget  icon;
//  String itemText;
//  bool isPressed;
//  bool isNew ;
////  int count;
//}
//
//class SubCategory {
//  SubCategory(
//    this.subCategoryText,
//    this.onTapSubCategory,
//  );
//  String subCategoryText;
//  Function onTapSubCategory;
//
////  int count;
//}
//
//class CustomDrawer extends StatefulWidget {
//  final FocusNode node;
//
//  CustomDrawer({Key key, this.node}) : super(key: key);
//
//  @override
//  _CustomDrawerState createState() => _CustomDrawerState();
//}
//
//class _CustomDrawerState extends State<CustomDrawer> {
//  List<Category> categoryItemsList = [
//    Category(  Icon(Icons.access_time ) , 'New Arrivals', false ,  false  ),
//    Category(  Icon(MdiIcons.labelPercentOutline), 'Today’s Deals', false , false ),
//    Category(  Icon(Icons.computer ), 'Computer / Tablet', false , true  ),
//    Category(  Icon(Icons.print_outlined ), 'Printers & Projcetors', false ,  false ),
//    Category(  Icon(Icons.phone_iphone ), 'Phones & Accessories', false ,  false ),
//    Category(  Icon(Icons.tv ),  'TV, Video & Sound ', false ,  false ),
//    Category(  Icon(MdiIcons.lightbulbOnOutline), 'Electrical Appliances', false ,  false ),
//    Category(Icon(Icons.camera_alt_outlined), 'Photo & Camera', false , false ),
//    Category(Icon(MdiIcons.playOutline), 'Games & Consols', false ,  false ),
//  ];
//
//  List<SubCategory> subCategoryItemsList = [
//    SubCategory("Gaming Computer", () {
//      print(' Gaming Computers is pressed');
//    }),
//    SubCategory("Gaming Equipment", () {
//      print(' Gaming Equipment is pressed');
//    }),
//    SubCategory("Mouse", () {
//      print(' Mouse is pressed');
//    }),
//    SubCategory("Headse", () {
//      print(' Headse is pressed');
//    }),
//    SubCategory("Keyboards", () {
//      print(' Keyboards is pressed');
//    }),
//  ];
//  @override
//  void initState() {
//    super.initState();
//    widget.node.unfocus();
//  }
//
//  @override
//  void dispose() {
//    widget.node.requestFocus();
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
//      child: SingleChildScrollView(
//
//        child: Column(
////        padding: EdgeInsets.zero,
//          children: <Widget>[
//            responsiveSizedBox(context: context, percentageOfHeight: .05),
//            drawerHeader(context: context),
//            responsiveSizedBox(context: context, percentageOfHeight: .03),
//            Container(
//              height: height(context)*.8,
//              child: ListView.builder(
//                  itemCount: categoryItemsList.length,
////                shrinkWrap: true,
//                  itemBuilder: (BuildContext context, int index) {
//                    return Column(
//                      children: [
//                        singleDrawerItem(
//                            context: context,
//                            icon : categoryItemsList[index].icon,
//                            text: categoryItemsList[index].itemText,
//                            index: index,
//                            isNew:  categoryItemsList[index].isNew,
//                            sinIndex: categoryItemsList[index]),
//                        responsiveSizedBox(
//                            context: context, percentageOfHeight: .02),
//                        AnimatedContainer(
//                          duration: Duration(milliseconds: 500),
//                          height: categoryItemsList[index].isPressed == true
//                              ? height(context) * .25
//                              : 0,
//                          child: ListView.builder(
//                            shrinkWrap: true ,
//                              itemCount: subCategoryItemsList.length,
//                              itemBuilder: (BuildContext context, int subIndex) {
//                                return Container(
//                                  padding:
//                                      EdgeInsets.only(left: width(context) * .173),
//                                  color: backGroundColor,
//                                  child: GestureDetector(
//                                    onTap: subCategoryItemsList[subIndex]
//                                        .onTapSubCategory,
//                                    child: Column(
//                                      mainAxisSize: MainAxisSize.min,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: [
//                                       customDescriptionTextText(context : context  , text :  subCategoryItemsList[subIndex]
//                                            .subCategoryText  , percentageOfHeight: .019 , textColor: blackColor),
//                                        responsiveSizedBox(
//                                            context: context,
//                                            percentageOfHeight: .02),
//                                      ],
//                                    ),
//                                  ),
//                                );
//                              }),
//                        ),
//                      ],
//                    );
//                  }),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  drawerHeader({BuildContext context}) {
//    return Container(
//      padding: EdgeInsets.only(
//          right: width(context) * .05, left: width(context) * .05),
//      child: Row(
//        children: [
//          customDescriptionTextText(
//              context: context,
//              text: "CATEGORIES",
//              textColor: greyColor,
//              percentageOfHeight: .025)
//        ],
//      ),
//    );
//  }
//
//  singleDrawerItem(
//      {BuildContext context,
//      Widget  icon ,
//      String text,
//      int index,
//        bool isNew ,
//      sinIndex}) {
//    return Column(
//      children: [
//        responsiveSizedBox(context: context, percentageOfHeight: .025),
//        GestureDetector(
//          onTap: () {
//            print("item pressed ");
//            setState(() {
//              categoryItemsList[index].isPressed =
//                  !categoryItemsList[index].isPressed;
//            });
//          },
//          child: Container(
//            padding: EdgeInsets.only(
//                right: width(context) * .05, left: width(context) * .05),
//            child: Row(
//              children: [
//                Container(
//                  height: isLandscape(context) ? height(context)*.03:height(context)*.03,
//                    child: icon) ,
//                SizedBox(
//                  width: isLandscape(context)
//                      ? 0.5 * width(context) * .05
//                      : width(context) * .05,
//                ),
//                customDescriptionTextText(
//                    context: context,
//                    text: text,
//                    textColor: blackColor,
//                    percentageOfHeight:  isLandscape(context)  ?  0.019 : .023) ,
//                SizedBox(
//                  width: isLandscape(context)
//                      ? 0.5 * width(context) * .05
//                      : width(context) * .05,
//                ),
//               isNew == true ?
//               Container(
//                   height: isLandscape(context) ? height(context)*.04:height(context)*.04,
//                   child:
//                   Image.asset(AppIcons.newProduct)) :
//                   SizedBox()
//
//              ],
//            ),
//          ),
//        ),
//      ],
//    );
//  }
//
//  Widget subCategoriesBox(
//      {BuildContext context,
//      int index,
//      Function onTapSubCategory,
//      String subCategoryText}) {
//    return AnimatedContainer(
//      duration: Duration(milliseconds: 300),
//      height: categoryItemsList[index].isPressed == true
//          ? height(context) * .35
//          : 0,
//      child: ListView(
////        shrinkWrap: true,
//        padding: EdgeInsets.zero,
//        children: <Widget>[
//          Container(
//            padding: EdgeInsets.only(left: width(context) * .173),
//            color: backGroundColor,
//            child: ListView.builder(
//                itemCount: subCategoryItemsList.length,
//                shrinkWrap: true,
//                itemBuilder: (BuildContext context, int index) {
//                  return GestureDetector(
//                    onTap: onTapSubCategory,
//                    child: Column(
//                      children: [
//                       customDescriptionTextText(context: context , text: subCategoryText , percentageOfHeight: .012),
//                        responsiveSizedBox(
//                            context: context, percentageOfHeight: .02),
//                      ],
//                    ),
//                  );
//                }),
//          ),
//        ],
//      ),
//    );
//  }
//}
