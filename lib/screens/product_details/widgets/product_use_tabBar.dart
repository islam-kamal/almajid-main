import 'package:almajidoud/screens/product_details/widgets/descriptionAndShareRow.dart';
import 'package:almajidoud/screens/product_details/widgets/shippingAndReturnsWidget.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/gestures.dart';

class ProductUseTabBar extends StatelessWidget{
  var  how_to_use ,  description ;
  ProductUseTabBar({this.description='',this.how_to_use=''});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Directionality(textDirection: MyApp.app_langauge == 'ar' ? TextDirection.rtl : TextDirection.ltr,
        child: Container(
      height: width(context) * 0.6,
      child: DefaultTabController(
          length: 3,
          child: NestedScrollView(
              physics:NeverScrollableScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                new SliverAppBar(
                  pinned: true,
                  floating: false,

                  automaticallyImplyLeading: false,
                  backgroundColor: blackColor,

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
            body:TabBarView(
              physics: BouncingScrollPhysics(),
                children: <Widget>[
                //  DescriptionAndShar(description: description??'',),
                   descriptionAndShareRow(
                       context: context,
                      description: description??''
                 ),
                 // DescriptionAndShar(description:  how_to_use??'',),
                  descriptionAndShareRow(
                     context: context,
                      description: how_to_use??''
                 ),
                  shippingAndReturnsWidget(
                    context: context,

                  ),

                ],
                // physics: NeverScrollableScrollPhysics(),
              ),

          )
      ),

    ));
  }

}