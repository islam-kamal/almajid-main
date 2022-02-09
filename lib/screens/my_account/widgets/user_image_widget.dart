import 'dart:io';

import 'package:almajidoud/utils/file_export.dart';

userImageWidget(
    {BuildContext context, File imagePath, Function onTapAddImage}) {
  final String _defaultImage = "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg";
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
          height: isLandscape(context)
              ? 2 * height(context) * .22
              : height(context) * .22,
          width: width(context) * .5,
          child: Stack(
            children: [
              Container(
                width: width(context) * .5,
                height: isLandscape(context)
                    ? 2 * height(context) * .22
                    : height(context) * .22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Polygon(
                        sides: 6,
                        child: Container(
                          color: Colors.black,
                          width: 150.0,
                          height: 150.0,
                          child: Center(
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:  imagePath == null
                                          ? NetworkImage(_defaultImage)
                                          : FileImage(imagePath),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: isLandscape(context)
                        ? 2 * height(context) * .04
                        : height(context) * .04,
                    left: isLandscape(context)
                        ? width(context) * .15
                        : width(context) * .25),
                alignment: Alignment.bottomCenter,
                width: width(context) * .5,
                height: isLandscape(context)
                    ? 2 * height(context) * .22       : height(context) * .22,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: GestureDetector(
                        onTap: onTapAddImage,
                        child: Polygon(
                            sides: 6,
                            child: Container(
                                color: Colors.black,
                                width: 35.0,
                                height: 35.0,
                                child: Center(
                                    child: RotatedBox(
                                        quarterTurns: 3,
                                        child: Center(
                                          child: Icon(Icons.add,
                                              color: whiteColor),
                                        )

                                      /*          child: ClipRRect(
                                  child: Image.network
                                    (
  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSyj-wgGa-GZ1vJSGgmf6LCmvd7fxUgl-Pl0w&usqp=CAU"
                                    , fit: BoxFit.contain),
                                ),*/
                                    )))),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    ],
  );
}
