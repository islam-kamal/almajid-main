import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';

class BagsRepository{

 static Future<bool?> send_bags_number({BuildContext? context ,var bags_number,})async {
    Dio dio = new Dio();
    try {
      print("@@bags number : ${bags_number}");

      final response = await dio.post(
          StaticData.vistor_value == 'visitor' ?
             "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/amasty_checkout/guest-carts/${ await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE)}/delivery"
           : "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/amasty_checkout/carts/${ await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/delivery",
          data: {
              "cartId" : StaticData.vistor_value == 'visitor' ? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE) : await sharedPreferenceManager.readString(CachingKey.CART_QUOTE),
              "date" : "",
              "cases" : bags_number.toString()

          },
          options: Options(
              headers:  {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
              }
          ));
      print("bags number : ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
       // errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      // errorDialog(context: context, text: e.toString());
    }
  }

}