import 'package:almajidoud/utils/file_export.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MyProductSlider extends StatefulWidget {
  List<String> data;
  bool indicator;
  var aspect_ratio;
  var border_radius;
  var viewportFraction;
  var details_page;
  var slider_width;
  var slider_height;
  bool motion; // true if you want slider image movement , false if not
  MyProductSlider(
      {this.data,
      this.indicator,
      this.aspect_ratio,
      this.border_radius,
      this.viewportFraction,
      this.details_page = false,
      this.slider_width,
      this.slider_height,
      this.motion = false})
      : super();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyProductSliderState();
  }
}

class _MyProductSliderState extends State<MyProductSlider> {
  int _current = 0;
  bool full_screen = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.all(Radius.circular(height * .015)),
      ),
      child: widget.motion ? CarouselSlider(
        items: widget.data
            .map((item) => ClipRRect(
            borderRadius: BorderRadius.circular(widget.border_radius ?? 0),
            child:   Container(
                decoration: BoxDecoration(
                  borderRadius:
                  BorderRadius.all(Radius.circular(height * .0)),
                ),
                child: ClipRRect(
                    borderRadius:
                    BorderRadius.all(Radius.circular(height * .0)),
                    child: Image.network(
                      item,
                      fit: BoxFit.fill,
                    )
                ),
                height: height ,
                width: width ,
              ),

        ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          height:  widget.slider_height??=MediaQuery.of(context).size.height/4.5,
          enlargeCenterPage: true,
          aspectRatio: widget.aspect_ratio ?? 2,
          viewportFraction: widget.viewportFraction ?? 1,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
      ) :  ClipRRect(
          borderRadius:
          BorderRadius.all(Radius.circular(height * .015)),
          child: Image.network(
            widget.data.isEmpty? 'assets/images/breakfast.png':  widget.data[0],
             height: MediaQuery.of(context).size.height/5,
            fit: BoxFit.fill,
          ),
      ),

    );
  }
}
