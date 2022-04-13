import 'package:almajidoud/utils/file_export.dart';

topSlider({BuildContext? context , List? gallery}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: width(context),
        height: isLandscape(context)
            ? 2 * height(context) * .2
            : height(context) * .2,
        child: Carousel(
          dotIncreasedColor: mainColor,
          borderRadius: false,
          dotSize: 3.0,
          showIndicator: true,
          dotSpacing: 13,
          onImageTap: (index) {
          },
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.transparent,
          boxFit: BoxFit.fill,
          images: gallery,

        ),
      )
    ],
  );
}
