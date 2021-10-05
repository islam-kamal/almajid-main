
import 'dart:convert';
import 'package:almajidoud/Model/NotificationsModel/notifications_model.dart';
import 'package:almajidoud/utils/file_export.dart';


class NotificationsRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<NotificationsModel> getAllNotifications() async{
print("token ########: ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
    Map<String, String> headers = {
      'lang': translator.currentLanguage,
         'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    };
    return NetworkUtil.internal().get(NotificationsModel(), Urls.GET_ALL_NOTIFICATIONS, headers: headers);
  }

  Future<NotificationsModel> remove_notification(List<int> id) async{

    Map<String, String> headers = {
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
    "ids" : id.join(','),
    };
    return NetworkUtil.internal().delete(NotificationsModel(), Urls.REMOVE_NOTIFICATIONS, headers: headers);
  }
}
NotificationsRepository notificationsRepository = new NotificationsRepository();