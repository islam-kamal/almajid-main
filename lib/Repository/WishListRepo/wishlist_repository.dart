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
        GetAllWishListModel(), Urls.GET_ALL_WISHLIST_ITEMS,
        headers: headers);
  }

  Future<List<WishlistItemModel>> getWishListIDS(BuildContext context)async{
    print("********** 1");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    try {
      print("********** 1");
      final response = await dio.get(
          Urls.BASE_URL+ Urls.GET_ALL_WISHLIST_ITEMS,
          options: Options(
              headers:  Map<String, String>.from({
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}',
              },)
          ));
      print("wishlist response : ${response}");
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

        print("sharedPreferences : ${sharedPreferences.getStringList('WISHLIST_IDS')}");
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
    print("product_id :: ${product_id}");
    print("product_qty :: ${product_qty}");
    try {
      final response = await dio.put(
          "${Urls.BASE_URL}/index.php/rest/V1/mstore/me/wishlist/add/${product_id}",
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
        print("res 4");
        return response.data;
      } else {
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("res 6");
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }
  }

  Future<bool> removeProudctToWishList({BuildContext context ,var wishlist_item_id})async {
    Dio dio = new Dio();
    print("wishlist_item_id :: ${wishlist_item_id}");
    try {
      final response = await dio.post(
          "${Urls.BASE_URL}/index.php/rest/V1/mstore/me/wishlist/item/remove/${wishlist_item_id}",
          options: Options(
              headers:  {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization': 'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              }
          ));
      print("remove response : ${response.data}");
      if (response.statusCode == 200) {
        print("res 4");
        return response.data;
      } else {
        errorDialog(context: context, text: response.data['message']);
      }
    } catch (e) {
      print("res 6");
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }
  }

  Future<bool> add_product_from_wishlist_to_cart({BuildContext context, var wishlist_product_id ,
    var product_qty})async{
    print("1");
    Dio dio = new Dio();
    try {
      print("user---- token : ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}");
      print("user type : ${ StaticData.vistor_value}");
      //create_quote
      final response = await dio.post( Urls.BASE_URL +Urls.CREATE_Client_QUOTE,
          options: Options(
            headers: {

              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization':'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
            },

          ));
      print("response : ${response.data}");
      if (response.statusCode == 200) {
        sharedPreferenceManager.writeData(CachingKey.CART_QUOTE, response.data.toString());

        final add_response = await dio.post("${Urls.BASE_URL}/index.php/rest/V1/mstore/me/wishlist/addCart/${wishlist_product_id}",
            options: Options(
              headers: {
                'Content-Type': 'application/json',
                'Accept': 'application/json',
                'Authorization':'Bearer ${await sharedPreferenceManager.readString(CachingKey.AUTH_TOKEN)}'
              },
            )
        );
        print("--------- 3 ---------");
        print("--------- add_response : ${add_response} ---------");
        if(add_response.statusCode == 200){
          return add_response.data;
        }else{
          errorDialog(context: context, text: response.data['message']);
          return null;
        }

      } else {
        print("------ message : ${response.data['message']}");
        errorDialog(context: context, text: response.data['message']);
        return null;
      }
    } catch (e) {
      print("error : ${e.toString()}");
      errorDialog(context: context, text: e.toString());
    }

  }
}
WishListRepository wishListRepository = new WishListRepository();