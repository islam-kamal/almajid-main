
import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart';
import 'package:almajidoud/Repository/WishListRepo/wishlist_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';


class WishListBloc extends Bloc<AppEvent,AppState>  {


  final WishListRepository wishlistRepository = WishListRepository();

  final BehaviorSubject<GetAllWishListModel> _wishlist_subject = BehaviorSubject<GetAllWishListModel>();
  @override
  get wishlist_subject {
    return _wishlist_subject;
  }


  WishListBloc(AppState initialState) : super(initialState);

  @override
  void drainStream() {
    _wishlist_subject.value = null;
  }


  @override
  void dispose() async{
    await _wishlist_subject.drain();
    _wishlist_subject.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading(indicator: 'add_cart');
    if(event is AddToWishListEvent){
      print('event.product_id : ${event.product_id}');
      var response = await wishlistRepository.addProudctToWishList(
        product_id: event.product_id,
        product_qty: event.qty,
        context: event.context
      );

      print('event.response : ${response}');
      if(response ==true){
        yield Done(indicator: 'add_fav');
      }else{
        yield  ErrorLoading(indicator: 'add_fav');
      }
    }
    else if(event is removeFromWishListEvent){
      yield Loading(indicator: 'remove_fav');

    var response = await wishlistRepository.removeProudctToWishList(
        wishlist_item_id: event.wishlist_item_id,
      );
      if(response==true){
        yield  Done(indicator: 'remove_fav');
      }else{
        yield   ErrorLoading( indicator: 'remove_fav');
      }
    }
    else if(event is getAllWishList_click){
      print("fav 1");
      yield Loading(indicator: 'get_fav');
      var response =await wishlistRepository.getAllWishListItems();
      print("fav 2");
     print("all fav response  : ${response}");
      if(response.message == "The consumer isn't authorized to access %resources."){
      }else{
        if(response.items.isNotEmpty){
          print("fav 3");
          _wishlist_subject.sink.add(response);
          yield  Done(model: response , indicator: 'get_fav');
          print("fav 4");
        }else{
          print("fav 5");
          yield   ErrorLoading(model: response ,indicator: 'get_fav');
        }
      }

    }
    else  if(event is AddToCarFromWishListEvent){
      print('event.product_id : ${event.wishlist_product_id}');
      var response = await wishlistRepository.add_product_from_wishlist_to_cart(
          product_qty: event.qty,
          wishlist_product_id: event.wishlist_product_id,
          context: event.context
      );
      print('event.response : ${response}');
      if(response ==true){
        yield Done(indicator: 'add_cart');
      }else{
        yield  ErrorLoading(indicator: 'add_cart');
      }
    }
  }


}
final wishlist_bloc = WishListBloc(null);
