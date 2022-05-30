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
  String? _imagePath;
  File? _pickedImage;

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
                                            : FileImage(_pickedImage!)  as ImageProvider,
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
              ],
            )),
      ],
    );

  }
}
