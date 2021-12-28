import 'package:almajidoud/Base/network-mappers.dart';
import 'package:almajidoud/Base/shared_preference_manger.dart';
import 'package:almajidoud/utils/urls.dart';
import 'package:dio/dio.dart';

class NetworkUtil {
  static final NetworkUtil _instance = new NetworkUtil.internal();
SharedPreferenceManager sharedPreferenceManager =SharedPreferenceManager();
  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  Dio dio = Dio();

  Future<ResponseType> get <ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map headers}) async {
    
    var response;
    print("headers : $headers");
    try {
      dio.options.baseUrl = Urls.BASE_URL;
      response = await dio.get(
          url,
   //       queryParameters:Map<String, dynamic>.from(headers),
        options: Options(
          headers: headers,
          contentType: 'application/json',
        )
      );

      print('res : ${response}');
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      }
    }
    return handleResponse(response, responseType);
  }

  Future<ResponseType> post<ResponseType extends Mappable>(ResponseType responseType, String url,
      {Map headers, FormData body, encoding}) async {
    print('1');
    var response;
    dio.options.baseUrl = Urls.BASE_URL;
    print('2');
    try {
      print(headers);
      print(body.fields);
      print(body.files);
      print('3');
      response = await dio.post(url,
          data: body,
          options: Options(headers: headers, requestEncoder: encoding ,
              followRedirects: false,  validateStatus: (status) { return status < 500; }));
      print('4');
      print("response card : $response");

    } on DioError catch (e) {
      if (e.response != null) {
        print('5');
        response = e.response;
      }
    }
    return handleResponse(response, responseType);

  }


  Future<ResponseType> delete<ResponseType extends Mappable>(ResponseType responseType,String url, {Map headers}) {
print("delete 1");
    return dio
        .delete(
      url,
      options: Options(headers: headers),

    )
        .then((Response response) {
      print("delete 2");

      return handleResponse(response, responseType);
    });
  }

  Future<ResponseType> put<ResponseType extends Mappable>(ResponseType responseType,String url, {Map headers, body, encoding}) {
    return dio
        .put(url,
        data: body,
        options: Options(headers: headers, requestEncoder: encoding))
        .then((Response response) {
      return handleResponse(response, responseType);
    });
  }


  ResponseType handleResponse<ResponseType extends Mappable>(Response response, ResponseType responseType) {
    final int statusCode = response.statusCode;
    print("Status Code " + statusCode.toString());
    if (statusCode >= 200 && statusCode < 300) {
      print("correrct request: " + response.toString());
      print("Status Code " + statusCode.toString());
      return Mappable(responseType, response.toString()) as ResponseType;
    } else {
      print("request error: " + response.toString());
      print("Status Code " + statusCode.toString());
      return Mappable(responseType, response.toString()) as ResponseType;
    }
  }


}
