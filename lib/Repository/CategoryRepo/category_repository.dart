import 'package:almajidoud/Base/network_util.dart';
import 'package:almajidoud/Base/urls.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class CategoryRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<CategoryModel> getCategoriesList() async {
    Map<String, String> headers = {
      //'lang': translator.currentLanguage,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        CategoryModel(), Urls.GET_ALL_CATEGORIES, headers: headers  );
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
        'https://test.almajed4oud.com/index.php/rest/V1/mstore/products?searchCriteria&searchCriteria[filterGroups][0][filters][1][field]=category_id&searchCriteria[filterGroups][0][filters][1][value]=${category_id}&searchCriteria[filterGroups][0][filters][1][conditionType]=eq&searchCriteria[sortOrders][0][field]=position& searchCriteria[sortOrders][0][direction]=ASC&searchCriteria[pageSize]=10',
    headers: headers);
  }




  Future<ProductModel> getSecondLevelSubcategoryProducts(
      {String second_level_subcategory_id, int offset}) async {
    Map<String, String> headers = {
      'lang': translator.currentLanguage,
      'category_id': second_level_subcategory_id,
      'offset': offset.toString()
    };
    return NetworkUtil.internal().get(
        ProductModel(), Urls.GET_SECOND_LEVEL_SUBCATEGORY_PRODUCTS, headers: headers);
  }

}
CategoryRepository categoryRepository = new CategoryRepository();