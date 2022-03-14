import 'package:almajidoud/screens/product_details/widgets/descriptionAndShareRow.dart';
import 'package:almajidoud/utils/file_export.dart';

class ProductUseTabBar extends StatelessWidget{
  var  how_to_use ,  description ;
  ProductUseTabBar({this.description='',this.how_to_use=''});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Directionality(textDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
      height: width(context) * 0.5,
      child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  pinned: true,
                  floating: true,
                  automaticallyImplyLeading: false,
                  title: TabBar(
                    isScrollable: true,
                   physics: NeverScrollableScrollPhysics(),
                    tabs: [
                      Tab(child: Text(translator.translate("Description"))),
                      Tab(child: Text(translator.translate("How To Use"))),
                      Tab(child: Text(translator.translate("Shipping And Returns"))),


                    ],
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: <Widget>[
                descriptionAndShareRow(
                    context: context,
                    description: description??''
                ),
                descriptionAndShareRow(
                    context: context,
                    description: how_to_use??''
                ),
                descriptionAndShareRow(
                    context: context,
                    description: translator.translate( "shipping&returns"),

                ),




              ],

              // physics: NeverScrollableScrollPhysics(),
            ),
          )),

    ));
  }

}