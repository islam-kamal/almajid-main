

import 'package:almajidoud/Model/StoreLocatorModel/store_locator_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';

class StoreLocatorReopistory {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();
/*
  Future<StoreLocatorModel> get_stores_locators() async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        StoreLocatorModel(),
        '${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/store-locator',
        headers: headers);
  }*/
  Future<List<StoreLocatorModel>> get_stores_locators() async {
    Dio dio = new Dio();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
      };
      final response = await dio.get(Urls.BASE_URL+ '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/store-locator',
          options: Options(
              headers: headers
          ));
      if (response.statusCode == 200) {
        final jsonresponse = response.data;
        if (jsonresponse == null) {
          return null;
        } else {
          List<StoreLocatorModel> temp = (jsonresponse as List)
              .map((f) => StoreLocatorModel.fromJson(f))
              .toList();
          return temp;
        }
      } else {
      }
    } catch (e) {
    }

  }
}
final store_locator_repo = StoreLocatorReopistory();