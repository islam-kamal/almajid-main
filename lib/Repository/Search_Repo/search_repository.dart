import 'dart:convert';

import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';



class SearchRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<SearchModel> search_products_fun({String search_text}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        SearchModel(),
        '${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/mstore/products?searchCriteria[filter_groups][0][filters][0][field]=name&searchCriteria[filter_groups][0][filters][0][value]=%${search_text}%&searchCriteria[filter_groups][0][filters][0][condition_type]=like',
        headers: headers);
  }
}
final search_repository = SearchRepository();