import 'package:almajidoud/Model/OffersModel/offer_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/Model/CountriesModel/countries_model.dart';
import 'package:dio/dio.dart';

class CountriesRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<List<CountriesModel>> getCountriesList() async {
    Dio dio = new Dio();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
      };
      final response = await dio.get(Urls.BASE_URL+ Urls.GET_APP_COUNTRIES, options: Options(
          headers: headers
      ));
      if (response.statusCode == 200) {
        print("1");
        final jsonresponse = response.data;
        print("2");
        if (jsonresponse == null) {
          print("3");
          return null;
        } else {
          print("4");
          List<CountriesModel> temp = (jsonresponse as List)
              .map((f) => CountriesModel.fromJson(f))
              .toList();
          print("5");
          print("temp : ${temp}");
          return temp;
        }
      } else {
        print("response.statusCode  : ${response.statusCode }");
      }
    } catch (e) {
      print("response error  : ${e.toString() }");
    }

/*    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(CountriesModel(), Urls.GET_APP_COUNTRIES, headers: headers);
  }*/
  }
}
CountriesRepository countriesRepository = new CountriesRepository();