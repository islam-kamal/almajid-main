
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:dio/dio.dart';
class ReviewsRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<ProductReviewModel> create_product_review({var title, var detail,var nickname,var product_id}){
    FormData formData=FormData.fromMap(
        {
          "review": {
            "title": title??'',
            "detail": detail??'',
            "nickname": nickname??'',
            "ratings": [
              {
                "rating_name": "Rating",
                "value": 1
              },
              {
                "rating_name": "Quality",
                "value": 1
              }
            ],
            "review_entity": "product",
            "review_status": 1,
            "entity_pk_value": product_id
          }
        }
    );
    Map<String, String> headers = {
      //'lang': translator.activeLanguageCode,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    return NetworkUtil.internal().post(ProductReviewModel(),
        Urls.CREATE_PRODUCT_REVIEW,
        body: formData,
    headers: headers);
  }

  Future<List<ProductReviewModel>> getProductReviews({BuildContext context , var product_sku}) async{

    String Review_Url = Urls.BASE_URL + '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/products/${product_sku}/reviews/';
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
        final jsonresponse = response.data;
        if (jsonresponse == null) {
          return null;
        } else {
          List<ProductReviewModel> temp = (jsonresponse as List)
              .map((f) => ProductReviewModel.fromJson(f))
              .toList();
          print("temp : ${temp}");
          return temp;
        }
      } else {
        print("response.statusCode  : ${response.data['message'] }");
      }
    } catch (e) {
      print("response error  : ${e.toString() }");
    }


  }
}
ReviewsRepository reviewsRepository = new ReviewsRepository();