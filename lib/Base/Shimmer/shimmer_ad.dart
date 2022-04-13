import 'package:almajidoud/Base/Shimmer/chip_design.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerAd extends StatefulWidget {
  @override
  _ShimmerAdState createState() => _ShimmerAdState();
}

class _ShimmerAdState extends State<ShimmerAd> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer.fromColors(
          baseColor: greyColor,
          highlightColor: Colors.grey![350]!,
          child: Container(
            margin: EdgeInsets.only(right: 20),
            height: 95,
            width: 95,
            decoration: BoxDecoration(
                color: greyColor, borderRadius: BorderRadius.circular(10.0)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: greyColor,
                highlightColor: Colors.grey![350]!,
                child: ChipDesign(
                  color: greyColor,
                  label: '                                                  ',
                  txtColor: greenColor,
                ),
              ),
              Row(children: [
                Shimmer.fromColors(
                  baseColor: greyColor,
                  highlightColor: Colors.grey![350]!,
                  child: ChipDesign(
                    color: greyColor,
                    label: '                  ',
                    txtColor: greenColor,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: Shimmer.fromColors(
                    baseColor: greyColor,
                    highlightColor: Colors.grey![350]!,
                    child: ChipDesign(
                      color: greyColor,
                      label: '                 ',
                      txtColor: greenColor,
                    ),
                  ),
                )
              ])
            ],
          ),
        )
      ],
    );
  }
}
