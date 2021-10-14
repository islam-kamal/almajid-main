
import 'package:almajidoud/utils/file_export.dart';
class ReviewsRepository {
  static SharedPreferenceManager sharedPreferenceManager = SharedPreferenceManager();

  Future<ProductReviewModel> getProductReviews({var product_sku}) async{

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
    };
    print("product_sku : ${product_sku}");
    return NetworkUtil.internal().get(ProductReviewModel(),'/rest/V1/products/${product_sku}/reviews/', headers: headers);

  }
}
ReviewsRepository reviewsRepository = new ReviewsRepository();