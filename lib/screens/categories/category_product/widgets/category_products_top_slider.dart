import 'package:almajidoud/utils/file_export.dart';

categoryDetailsTopSlider({BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: width(context),
        height: isLandscape(context)
            ? 2 * height(context) * .23
            : height(context) * .23,
        child: Carousel(
          dotIncreasedColor: mainColor,
          borderRadius: false,
          dotSize: 3.0,
          showIndicator: true,
          dotSpacing: 13,
          onImageTap: (index) {
            print('this is $index');
          },
          indicatorBgPadding: 5.0,
          dotBgColor: Colors.transparent,
          boxFit: BoxFit.fill,
          images: [
            AssetImage("assets/images/scroll.png"),
            AssetImage("assets/images/scroll.png"),
            AssetImage("assets/images/scroll.png")],),
      )
    ],
  );
}