import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerNotification extends StatelessWidget {
final int length;
ShimmerNotification({this.length=5});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
        itemCount: length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(StaticData.get_width(context) * 0.03),
            child: Shimmer.fromColors(
                baseColor: white_gray_color,
                highlightColor: Colors.grey[350],
                child
                    : Container(
                  decoration: BoxDecoration(
                      color: white_gray_color,
                      borderRadius: BorderRadius.circular(5.0)),

                  height: 100,
                  width: width * 0.75,

                )

            ),
          );

        }
    );



  }
}
