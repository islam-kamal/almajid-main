
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
class ReviewsRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<List<ProductReviewModel>> getProductReviews({BuildContext context , var product_sku}) async{

    String Review_Url = Urls.BASE_URL + '/rest/V1/products/${2128}/reviews/';
    Dio dio = new Dio();
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
      };
      final response = await dio.get(Review_Url,options: Options(
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
          List<ProductReviewModel> temp = (jsonresponse as List)
              .map((f) => ProductReviewModel.fromJson(f))
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

 /*   Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    print("product_sku : ${product_sku}");
    return NetworkUtil.internal().get(ProductReviewModel(),'/rest/V1/products/${2128}/reviews/', headers: headers);
*/
  }
}
ReviewsRepository reviewsRepository = new ReviewsRepository();