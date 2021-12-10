import 'package:almajidoud/Base/Shimmer/chip_design.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';



class ListShimmer extends StatefulWidget {
  final String type;
  ListShimmer({this.type});

  @override
  _ListShimmerState createState() => _ListShimmerState();
}

class _ListShimmerState extends State<ListShimmer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: widget.type == 'horizontal'? ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: white_gray_color,
                highlightColor: Colors.grey[350],
                child: Container(
                  //margin: EdgeInsets.only(right: 20),
                  height: 95,
                  width: 60,
                  decoration: BoxDecoration(
                      color: white_gray_color, borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 7),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: white_gray_color,
                      highlightColor: Colors.grey[350],
                      child: ChipDesign(
                        color: white_gray_color,
                        label: '                                                  ',
                        txtColor: mainColor,
                      ),
                    ),
                    Row(children: [
                      Shimmer.fromColors(
                        baseColor: white_gray_color,
                        highlightColor: Colors.grey[350],
                        child: ChipDesign(
                          color: white_gray_color,
                          label: '                  ',
                          txtColor: mainColor,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Shimmer.fromColors(
                          baseColor: white_gray_color,
                          highlightColor: Colors.grey[350],
                          child: ChipDesign(
                            color: white_gray_color,
                            label: '                 ',
                            txtColor: mainColor,
                          ),
                        ),
                      )
                    ])
                  ],
                ),
              )
            ],
          );
          /*    return  Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        child: Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: Colors.grey[350],
            child: Padding(
              padding: EdgeInsets.only(right: 5,left: 5),
              child: Container(
                height: StaticData.get_width(context) * 0.30,
                width: StaticData.get_width(context) * 0.25,
                decoration: BoxDecoration(
                    color: greyColor, borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            )
        ),
        );*/
        },

      )

          : GridView.builder(
          itemCount: 10,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 9/14,
            // childAspectRatio: StaticData.get_width(context) * 0.002,
          ),
          itemBuilder: (BuildContext context, int index) {
            return  Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: Colors.grey[350],
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    height: StaticData.get_width(context) * 0.25,
                    width: StaticData.get_width(context) * 0.25,
                    decoration: BoxDecoration(
                        color: greyColor, borderRadius: BorderRadius.circular(10.0)),
                  ),
                )
            );
          }),
    );
    return widget.type == 'horizontal'? ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
         return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer.fromColors(
              baseColor: white_gray_color,
              highlightColor: Colors.grey[350],
              child: Container(
                //margin: EdgeInsets.only(right: 20),
                height: 95,
                width: 60,
                decoration: BoxDecoration(
                    color: white_gray_color, borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: white_gray_color,
                    highlightColor: Colors.grey[350],
                    child: ChipDesign(
                      color: white_gray_color,
                      label: '                                                  ',
                      txtColor: mainColor,
                    ),
                  ),
                  Row(children: [
                    Shimmer.fromColors(
                      baseColor: white_gray_color,
                      highlightColor: Colors.grey[350],
                      child: ChipDesign(
                        color: white_gray_color,
                        label: '                  ',
                        txtColor: mainColor,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Shimmer.fromColors(
                        baseColor: white_gray_color,
                        highlightColor: Colors.grey[350],
                        child: ChipDesign(
                          color: white_gray_color,
                          label: '                 ',
                          txtColor: mainColor,
                        ),
                      ),
                    )
                  ])
                ],
              ),
            )
          ],
        );
    /*    return  Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
        child: Shimmer.fromColors(
            baseColor: greyColor,
            highlightColor: Colors.grey[350],
            child: Padding(
              padding: EdgeInsets.only(right: 5,left: 5),
              child: Container(
                height: StaticData.get_width(context) * 0.30,
                width: StaticData.get_width(context) * 0.25,
                decoration: BoxDecoration(
                    color: greyColor, borderRadius: BorderRadius.circular(10.0)
                ),
              ),
            )
        ),
        );*/
      },

    )

    : GridView.builder(
        itemCount: 10,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 9/14,
         // childAspectRatio: StaticData.get_width(context) * 0.002,
        ),
        itemBuilder: (BuildContext context, int index) {
          return  Shimmer.fromColors(
              baseColor: greyColor,
              highlightColor: Colors.grey[350],
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  height: StaticData.get_width(context) * 0.25,
                  width: StaticData.get_width(context) * 0.25,
                  decoration: BoxDecoration(
                      color: greyColor, borderRadius: BorderRadius.circular(10.0)),
                ),
              )
          );
        });
  }
}
