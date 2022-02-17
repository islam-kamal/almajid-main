import 'dart:io';

import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/my_account/widgets/user_image_widget.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileImage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProfileImageState();
  }

}
class ProfileImageState extends State<ProfileImage>{
  String _imagePath;
  File _pickedImage;

  @override
  void initState() {
    _getImageData();
    super.initState();
  }

  void _getImageData() async {
    _imagePath = await sharedPreferenceManager.readString(CachingKey.PROFILE_IMAGE);
    if(_imagePath !='' ){
      _pickedImage = File(_imagePath);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return            userImageWidget(
      context: context,
      imagePath: _pickedImage,
      onTapAddImage: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Directionality(
                  textDirection: MyApp.app_langauge =='ar' ? TextDirection.rtl :TextDirection.ltr,
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
                            onTap: ()async{
                              final picker = ImagePicker();
                              final pickedImage = await picker.pickImage(source: ImageSource.camera);
                              final pickedImageFile = File(pickedImage?.path??"");

// getting a directory path for saving
                              final Directory extDir = await getApplicationDocumentsDirectory();
                              String dirPath = extDir.path;
                              final String filePath = '$dirPath/profile_image.png';
                              //save the path in preference
                              sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, filePath);

                              final File newImage = await pickedImageFile.copy(filePath);
                              if (pickedImageFile != null) {
                                setState(() {
                                  _pickedImage = newImage;
                                });
                              }
                              Navigator.pop(context);
                            },
                            splashColor: Colors.purpleAccent,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.camera,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                Text(
                                  translator.translate("Camera"),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.w500,
                                      color:
                                      mainColor),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: ()async{
                              final picker = ImagePicker();
                              final pickedImage = await picker.pickImage(source: ImageSource.gallery);
                              final pickedImageFile = File(pickedImage?.path??"");
                              // getting a directory path for saving
                              final Directory extDir = await getApplicationDocumentsDirectory();
                              String dirPath = extDir.path;
                              final String filePath = '$dirPath/profile_image.png';
                              final File newImage = await pickedImageFile.copy(filePath);
                              sharedPreferenceManager.writeData(CachingKey.PROFILE_IMAGE, filePath);

                              if (pickedImageFile != null) {
                                setState(() {
                                  _pickedImage = newImage;
                                });
                              }
                              //save the path in preference

                              Navigator.pop(context);

                            },
                            splashColor: Colors.purpleAccent,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.purpleAccent,
                                  ),
                                ),
                                Text(
                                  translator.translate("Gallery"),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.w500,
                                      color:
                                      mainColor),
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              sharedPreferenceManager.removeData(CachingKey.PROFILE_IMAGE);
                              setState(() {
                                _pickedImage = null;
                              });
                              Navigator.pop(context);
                              /*customAnimatedPushNavigation(context, CustomCircleNavigationBar(
                                  page_index: MyApp.app_langauge == 'ar' ?4 : 0));*/
                            },
                            splashColor: Colors.purpleAccent,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.remove_circle,
                                    color: Colors.red,
                                  ),
                                ),
                                Text(
                                  translator.translate("Remove"),
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
                  )     );
            });
      },
    );
  }

}