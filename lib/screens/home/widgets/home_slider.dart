
import 'package:almajidoud/Base/Shimmer/slider_shimmer.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:almajidoud/utils//file_export.dart';
import 'package:flutter/material.dart';




class HomeSlider extends StatefulWidget {
  List<dynamic> gallery ;
  var height;
  HomeSlider({this.gallery,this.height});
  @override
  State<StatefulWidget> createState() {
    return _HomeSlider_State();
  }
}

class _HomeSlider_State extends State<HomeSlider> {
  int _current = 0;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
}
  @override
  // TODO: implemen
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Directionality(
          textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl :TextDirection.ltr,
          child:  InkWell(
            onTap: (){
            },
            child: Stack(
                overflow: Overflow.visible,
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                children: [
                  CarouselSlider(
                    items: widget.gallery.map((item) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      elevation: 0,
                      clipBehavior: Clip.none,
                      child:
                      Image.network(
                        '${item}',
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                    )).toList(),

                    options: CarouselOptions(
                        autoPlay: true,
                        viewportFraction: 16/9,
                        enlargeCenterPage: false,
                        aspectRatio: 2.7,
                        height: widget.height != null ? widget.height: null ,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }
                    ),
                  ),
                  Positioned(
                    bottom: -MediaQuery.of(context).size.width *0.06,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: widget.gallery.map((url) {
                        int index =  widget.gallery.indexOf(url);
                        return  Container(
                          width: 16.0,
                          height: 4.0,
                          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: _current == index
                                ? mainColor
                                : greyColor,
                          ),
                        ) ;
                      }).toList(),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }


}

