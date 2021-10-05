import 'package:almajidoud/Model/FavouriteModel/favourite_list_model.dart';
import 'package:almajidoud/Model/FavouriteModel/favourite_model.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';

class FavouriteRepository {

  Future<FavouriteListModel> getAllFavourite()async{
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    print('getAllFavourite (token) : ${token}');
    Map<String, String> headers = {
      'token' : token,
     // 'token':'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvZWF6eWh5cGVyLndvdGhvcS5jb1wvYXBpXC9hdXRoXC9sb2dpbiIsImlhdCI6MTYxNzA5MjI0NSwiZXhwIjoxNjE3MTE3NDQ1LCJuYmYiOjE2MTcwOTIyNDUsImp0aSI6IlpTblpTSHJrOXFGbFc2UnAiLCJzdWIiOjQzLCJwcnYiOiI4N2UwYWYxZWY5ZmQxNTgxMmZkZWM5NzE1M2ExNGUwYjA0NzU0NmFhIn0.zkjbKzV5QZkR6SumHFoP3-N2kTE2wejRRhLrozNa0O0',
    };
    return NetworkUtil.internal().get(
        FavouriteListModel(), Urls.GET_ALL_FAVOURITES,
        headers: headers);
  }

  Future<FavouriteModel> addProudctToFavourite({int product_id, })async {
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    FormData formData = FormData.fromMap({
      'token': token,
      'product_id': product_id,
    });
    return NetworkUtil.internal().post(
        FavouriteModel(), Urls.ADD_TO_FAVOURITE, body: formData);
  }

  Future<FavouriteListModel> removeProudctFromFavourite({int product_id,})async{
    var token = await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN);
    FormData formData =FormData.fromMap({
      'token' : token,
      'product_id':product_id,
    });
    return NetworkUtil.internal().post(FavouriteListModel(), Urls.REMOVE_FROM_FAVOURITE,body: formData);

  }
}