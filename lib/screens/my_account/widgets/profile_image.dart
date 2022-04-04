import 'dart:io';


import 'package:almajidoud/utils/file_export.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileImageState();
  }
}

class ProfileImageState extends State<ProfileImage> {
  String _imagePath;
  File _pickedImage;

  @override
  void initState() {
    _getImageData();
    super.initState();
  }

  void _getImageData() async {
     await sharedPreferenceManager.readString(CachingKey.PROFILE_IMAGE).then((value){
      if (value != '') {
        _pickedImage = File(value);
      }
      setState(() {});
    });

  }

  final String _defaultImage =
      "https://cdn1.vectorstock.com/i/thumb-large/62/60/default-avatar-photo-placeholder-profile-image-vector-21666260.jpg";

  @override
  Widget build(BuildContext context) {
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
                                        image: _pickedImage == null
                                            ? NetworkImage(_defaultImage)
                                            : FileImage(_pickedImage),
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
                      ? 2 * height(context) * .22
                      : height(context) * .22,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RotatedBox(
                        quarterTurns: 1,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext ctx) {
                                  return Directionality(
                                      textDirection: MyApp.app_langauge == 'ar'
                                          ? TextDirection.rtl
                                          : TextDirection.ltr,
                                      child: AlertDialog(
                                        title: Text(
                                          translator.translate("Choose option"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: greenColor),
                                        ),
                                        content: SingleChildScrollView(
                                          child: ListBody(
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  final picker = ImagePicker();
                                                  final pickedImage =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .camera);
                                                  final pickedImageFile = File(
                                                      pickedImage?.path ?? "");

// getting a directory path for saving
                                                  final Directory extDir =
                                                      await getApplicationDocumentsDirectory();
                                                  String dirPath = extDir.path;
                                                  final String filePath =
                                                      '$dirPath/profile_image.png';

                                                  final File newImage =
                                                      await pickedImageFile
                                                          .copy(filePath);
                                                  if (pickedImageFile != null) {
                                                    setState(() {
                                                      _pickedImage = newImage;

                                                    });
                                                  }
                                                  //save the path in preference
                                                  sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, filePath);
                                                 Navigator.pop(ctx);
                                 //       MyApp.restartApp(context);

                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.camera,
                                                        color:
                                                            Colors.purpleAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      translator
                                                          .translate("Camera"),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: mainColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  final picker = ImagePicker();
                                                  final pickedImage =
                                                      await picker.pickImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  final pickedImageFile = File(
                                                      pickedImage?.path ?? "");
                                                  // getting a directory path for saving
                                                  final Directory extDir =
                                                      await getApplicationDocumentsDirectory();
                                                  String dirPath = extDir.path;
                                                  final String filePath =
                                                      '$dirPath/profile_image.png';
                                                  final File newImage =
                                                      await pickedImageFile
                                                          .copy(filePath);

                                                  sharedPreferenceManager
                                                      .writeData(
                                                          CachingKey
                                                              .PROFILE_IMAGE,
                                                          filePath);

                                                  if (pickedImageFile != null) {
                                                    setState(() {
                                                      _pickedImage = newImage;
                                                    });
                                                  }
                                                  //save the path in preference

                                                  Navigator.pop(ctx);
                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.image,
                                                        color:
                                                            Colors.purpleAccent,
                                                      ),
                                                    ),
                                                    Text(
                                                      translator
                                                          .translate("Gallery"),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: mainColor),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  sharedPreferenceManager
                                                      .removeData(CachingKey
                                                          .PROFILE_IMAGE);
                                                  setState(() {
                                                    _pickedImage = null;
                                                  });
                                                  Navigator.pop(ctx);

                                                },
                                                splashColor:
                                                    Colors.purpleAccent,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.remove_circle,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Text(
                                                      translator
                                                          .translate("Remove"),
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.red),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ));
                                });
                          },
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
                                          ))))),
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
}
