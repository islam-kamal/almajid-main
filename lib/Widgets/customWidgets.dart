import 'package:almajidoud/utils/file_export.dart';



class CustomComponents{

  static Future<bool> isFirstTime() async {
    bool isFirstTime = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_TIME);
    if (isFirstTime != null && !isFirstTime) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, true);
      return false;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_TIME, false);
      return true;
    }
  }
  static Future<bool> isFirstLogin() async {
    bool isFirstLogin = await sharedPreferenceManager.readBoolean(CachingKey.FRIST_LOGIN);
    print("--- isFirstLogin ---- : ${isFirstLogin}");
    if (isFirstLogin != null && !isFirstLogin) {
      sharedPreferenceManager.writeData(CachingKey.FRIST_LOGIN, true);
      return true;
    } else {
      sharedPreferenceManager.writeData(CachingKey.FRIST_LOGIN, false);
      return false;
    }
  }

  static Future<bool> isLogout() async {
    bool is_Logout = await sharedPreferenceManager.readBoolean(CachingKey.LOGOUT);
    if (is_Logout != null &&  !is_Logout ) {
      sharedPreferenceManager.writeData(CachingKey.LOGOUT, true);
      return true;
    } else {
      sharedPreferenceManager.writeData(CachingKey.LOGOUT, false);
      return false;
    }
  }

  static Widget buildLoadingWidget() {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0,
              width: 25.0,
              child: CircularProgressIndicator(
                valueColor:
                new AlwaysStoppedAnimation<Color>(greenColor),
                strokeWidth: 4.0,
              ),
            )
          ],
        ));
  }

  static Widget buildErrorWidget(String error) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Error occured: $error"),
          ],
        ));
  }

  static Widget buildEmptyListWidget(BuildContext context,String message) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('assets/Splash_Screen/splash_screen.png'),
              width: MediaQuery.of(context).size.width/2,
              height: MediaQuery.of(context).size.width/2,
              fit: BoxFit.fill,
            ),
            Text("$message",style: TextStyle(color: greenColor),),
          ],
        ));
  }

}