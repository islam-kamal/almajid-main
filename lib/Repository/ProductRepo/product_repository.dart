import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/RateAndReviewModel/rateAndReview_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';


class ProductRepository{

  Future<RateAndReviewModel> productRateAndReviewFunc(
      {var value, var product_quality, var product_id, var delivery_time,
        var comment ,var using_experiences,}) async{
    FormData formData = FormData.fromMap({
     'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      // 'token' : 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9yZWZyZXNoIiwiaWF0IjoxNjIxNzk0NzEzLCJuYmYiOjE2MjE3OTU3NjYsImp0aSI6Imx2UEJadWt1cmVwc0hQakIiLCJzdWIiOjUsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.RaZj3RGPbYHZ92hSKyXG584EFb2x1KBlQLCV-9_IcZc',
      "value": value,
      "product_quality": product_quality,
      "product_id": product_id,
      "delivery_time": delivery_time,
      "using_experiences": using_experiences,
      "comment" : comment
    });

    return NetworkUtil.internal().post(
        RateAndReviewModel(), Urls.RATE_AND_REVIEW, body: formData);
  }


  Future<ProductModel> getRecommendedProductList({var offset}) async{
    Map<String, String> headers = {
      'lang': translator.activeLanguageCode,
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      'offset' : offset.toString()
    };
    return NetworkUtil.internal().get(ProductModel(), Urls.GET_ALL_RECOMMENDED_PRODUCT, headers: headers);
  }


  Future<ProductModel> getMostSellingList({var offset}) async{
    Map<String, String> headers = {
      'lang': translator.activeLanguageCode,
     // 'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      'most_selling' : 'desc',
      'offset' : offset.toString()
    };
    return NetworkUtil.internal().get(ProductModel(), Urls.GET_MOST_SELLING , headers: headers);
  }

  Future<ProductModel> get_purchase_list({int offset}) async{
    Map<String, String> headers = {
      'lang': translator.activeLanguageCode,
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      'purchase_list' : '1',
      'offset' : offset.toString()
    };
    return NetworkUtil.internal().get(ProductModel(), Urls.GET_PURCHASE_LIST , headers: headers);
  }

  Future<ProductModel> get_releated_products({int product_id , int offset}) async{
    Map<String, String> headers = {
      'lang': translator.activeLanguageCode,
      'token' : await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN),
      'offest' : offset.toString()
    };
    return NetworkUtil.internal().get(ProductModel(), Urls.GET_RELEATED_PRODUCTS + '${product_id.toString()}' , headers: headers);
  }
}

final product_repository = ProductRepository();