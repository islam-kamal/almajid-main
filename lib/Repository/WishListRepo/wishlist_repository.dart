import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart';
import 'package:almajidoud/Model/WishListModel/wishlist_item_model.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:dio/dio.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:shared_preferences/shared_preferences.dart';
class WishListRepository {

  Future<GetAllWishListModel> getAllWishListItems()async{
    Map<String, String> headers =  {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
    };
    return NetworkUtil.internal().get(
        GetAllWishListModel(), '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist',
        headers: headers);
  }

  Future<List<WishlistItemModel>> getWishListIDS(BuildContext context)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    try {
      final response = await dio.get(
          Urls.BASE_URL+ '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist',
          options: Options(
              headers:  Map<String, String>.from({
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
              },)
          ));
      if (response.statusCode == 200) {
        final jsonresponse = response.data['items'];
        List<WishlistItemModel> temp = (jsonresponse as List)
            .map((f) => WishlistItemModel.fromJson(f))
            .toList();
        List<Map> wishlist_data = [];
        temp.forEach((i) {
          wishlist_data.add({i.id.toString():i.product.id});
        });
       await sharedPreferenceManager.setListOfMaps(wishlist_data, 'wishlist_data_ids');
        return temp;
      } else {
       // errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("@@@@@@"+e.toString());
    //  errorDialog(context: context, text: "The consumer isn't authorized to access %resources.");
    }
  }

  Future<bool> addProudctToWishList({BuildContext context ,var product_id, var product_qty})async {
    Dio dio = new Dio();
    try {
      final response = await dio.put(
          "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist/add/${product_id}",
          data: {
            'buyRequest': {
              'qty': product_qty,
            }
          },
          options: Options(
              headers:  {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              }
          ));
      print("response : ${response.data}");
      if (response.statusCode == 200) {
        return response.data;
      } else {
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }
  }

  Future<bool> removeProudctToWishList({BuildContext context ,var wishlist_item_id})async {
    print("remove wishlist_item_id : ${wishlist_item_id}");
    Dio dio = new Dio();
    try {
      final response = await dio.post(
          "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist/item/remove/${wishlist_item_id}",
          options: Options(
              headers:  {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              }
          ));
      print("remove wishlist_item_id 1 : ${response}");
      if (response.statusCode == 200) {
        print("remove wishlist_item_id 2");
        return response.data;
      } else {
        print("remove wishlist_item_id 3");
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("remove wishlist_item_id 4");
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }
  }

  Future<bool> add_product_from_wishlist_to_cart({BuildContext context, var wishlist_product_id , var product_qty})async{
    Dio dio = new Dio();
    String url =
        "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/quote/is_active/"
        "${StaticData.vistor_value == 'visitor' ? await sharedPreferenceManager.readString(CachingKey.GUEST_CART_QUOTE) : await sharedPreferenceManager.readString(CachingKey.CART_QUOTE)}/${StaticData.vistor_value == 'visitor' ? 1 : 0}";

    final check_quote_response = await dio.get(url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${Urls.ADMIN_TOKEN}'
          },
        ));

    if (check_quote_response.data['status']) {
      try {
        final add_response = await dio.post(
            "${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist/addCart/${wishlist_product_id}",
          data: {
            "qty": 1
          },
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization':'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              },

            )
        );
        if(add_response.statusCode == 200){
          print("add_response : ${add_response}");
          return add_response.data;
        }else{
          print("else add_response : ${add_response.data['message']}");
          errorDialog(context: context, text: add_response.data['message']);
          return null;
        }

      } catch (e) {
        print("error : ${e.toString()}");
        errorDialog(context: context, text: e.toString());
      }
    }
    else if (check_quote_response.data['status'] == false) {
      try {
        //create_quote
        final response = await dio.post(
            StaticData.vistor_value == 'visitor'
                ? Urls.BASE_URL + '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/'
                : Urls.BASE_URL + '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/carts/mine',
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': StaticData.vistor_value == 'visitor'
                    ? null
                    : 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              },
            ));
        if (response.statusCode == 200) {
          StaticData.vistor_value == 'visitor'
              ? sharedPreferenceManager.writeData(
              CachingKey.GUEST_CART_QUOTE, response.data.toString())
              : sharedPreferenceManager.writeData(
              CachingKey.CART_QUOTE, response.data.toString());
          try {
            final add_response = await dio.post("${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist/addCart/${wishlist_product_id}",
                options: Options(
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization':'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
                  },
                )
            );
            if(add_response.statusCode == 200){
              return add_response.data;
            }else{
              errorDialog(context: context, text: add_response.data['message']);
              return null;
            }

          } catch (e) {
            print("error : ${e.toString()}");
            errorDialog(context: context, text: e.toString());
          }
        } else {
          errorDialog(context: context, text: response.data['message']);
          return null;
        }
      } catch (e) {
        print("error : ${e.toString()}");
        errorDialog(context: context, text: e.toString());
      }
    }
    else {
      try {
        //create_quote
        final response = await dio.post(
            Urls.BASE_URL + StaticData.vistor_value == 'visitor'
                ? Urls.BASE_URL + '/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/guest-carts/'
                : Urls.BASE_URL + '/${MyApp.app_langauge}-${MyApp.app_location}/rest/V1/carts/mine',
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': StaticData.vistor_value == 'visitor'
                    ? null
                    : 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              },
            ));
        if (response.statusCode == 200) {
          StaticData.vistor_value == 'visitor'
              ? sharedPreferenceManager.writeData(
              CachingKey.GUEST_CART_QUOTE, response.data.toString())
              : sharedPreferenceManager.writeData(
              CachingKey.CART_QUOTE, response.data.toString());
          try {
            final add_response = await dio.post("${Urls.BASE_URL}/${MyApp.app_langauge}-${MyApp.app_location}/index.php/rest/V1/mstore/me/wishlist/addCart/${wishlist_product_id}",
                options: Options(
                  headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                    'Authorization':'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
                  },
                )
            );
            if(add_response.statusCode == 200){
              return add_response.data;
            }else{
              errorDialog(context: context, text: add_response.data['message']);
              return null;
            }

          } catch (e) {
            print("error : ${e.toString()}");
            errorDialog(context: context, text: e.toString());
          }
        } else {
          errorDialog(context: context, text: response.data['message']);
          return null;
        }
      } catch (e) {
        print("error : ${e.toString()}");
        errorDialog(context: context, text: e.toString());
      }
    }

  }
}
WishListRepository wishListRepository = new WishListRepository();