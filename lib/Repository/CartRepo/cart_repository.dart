import 'package:almajidoud/Model/CartModel/add_cart_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class CartRepository {

  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<AddCartModel> getCategoriesList() async {
    Map<String, String> headers = {
      //'lang': translator.currentLanguage,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().get(
        AddCartModel(), Urls.GET_ALL_CATEGORIES, headers: headers);
  }
}
CartRepository cartRepository = CartRepository();