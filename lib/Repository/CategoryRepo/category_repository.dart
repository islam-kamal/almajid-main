import 'package:almajidoud/Base/network_util.dart';
import 'package:almajidoud/utils/urls.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class CategoryRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<CategoryModel> getCategoriesList() async {
    Map<String, String> headers = {
      //'lang': translator.activeLanguageCode,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        CategoryModel(), '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/categories', headers: headers  );
  }


  Future<ProductModel> getCategoryProducts(
      {String category_id, int offset}) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        ProductModel(),
        "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/products?searchCriteria[filterGroups][0][filters][1][field]=category_id&searchCriteria[filterGroups][0][filters][1][value]=${category_id}&searchCriteria[filterGroups][0][filters][1][conditionType]=eq&searchCriteria[sortOrders][0][field]=position&searchCriteria[sortOrders][0][direction]=ASC&searchCriteria[pageSize]=10&searchCriteria[currentPage]=${offset}",
     //   "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/products?searchCriteria&searchCriteria[filterGroups][0][filters][1][field]=category_id&searchCriteria[filterGroups][0][filters][1][value]=${category_id}&searchCriteria[filterGroups][0][filters][1][conditionType]=eq&searchCriteria[sortOrders][0][field]=position&searchCriteria[sortOrders][0][direction]=ASC&searchCriteria[pageSize]=10&searchCriteria[currentPage]=${offset}",
        headers: headers);
  }


  @override
  Future<ProductModel> getProduct({id, sku}) async {
    var endPoint ;
    if(id== null){
      endPoint =
      '?searchCriteria[filterGroups][0][filters][1][field]=sku&searchCriteria[filterGroups][0][filters][1][condition_type]=eq';
      endPoint += '&searchCriteria[filterGroups][0][filters][1][value]=$sku';
    }else{
      endPoint =
      '?searchCriteria[filterGroups][0][filters][0][field]=entity_id&searchCriteria[filterGroups][0][filters][0][condition_type]=eq';
      endPoint += '&searchCriteria[filterGroups][0][filters][0][value]=$id';
    }
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        ProductModel(),
        '${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/products${endPoint}',
        headers: headers);

  }



}
CategoryRepository categoryRepository = new CategoryRepository();