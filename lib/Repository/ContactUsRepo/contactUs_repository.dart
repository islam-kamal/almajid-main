import 'package:almajidoud/Model/ContactUsModel/complain_model.dart';
import 'package:almajidoud/Model/ContactUsModel/contactUs_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';

class ContactUsRepository {

   Future<ComplainModel> send_contact_message({String name, String email, String message
   ,String phone , String subject})async{
    FormData formData=FormData.fromMap({
       'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      // 'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxOTI2NjMzNCwibmJmIjoxNjE5MjY2MzM0LCJqdGkiOiJFandCUUpFNWdhcllDM3NsIiwic3ViIjoxMCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.vXHRpONRObtwz6ce5SWWQXOlJNqhXUwxeTfL0BWxGSg',
      "name" : name,
      "email" : email,
      "message" :  message,
      'phone': phone,
      'subject' : subject ,

    });

    return NetworkUtil.internal().post(ComplainModel(), Urls.SEND_COMPLAIN,body: formData);
  }


   Future<ContactUsModel> get_user_complains() async{
     print("1-1");
     Map<String, String> headers = {
          'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
       //   'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxOTI2NjMzNCwibmJmIjoxNjE5MjY2MzM0LCJqdGkiOiJFandCUUpFNWdhcllDM3NsIiwic3ViIjoxMCwicHJ2IjoiODdlMGFmMWVmOWZkMTU4MTJmZGVjOTcxNTNhMTRlMGIwNDc1NDZhYSJ9.vXHRpONRObtwz6ce5SWWQXOlJNqhXUwxeTfL0BWxGSg',
     };
     return NetworkUtil.internal().get(ContactUsModel(), Urls.GET_USER_COMPLAINS, headers: headers);
   }
}
ContactUsRepository contactUsRepository = ContactUsRepository();