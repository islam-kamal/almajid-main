
import 'package:almajidoud/Model/WishListModel/get_all_wishlist_model.dart';
import 'package:almajidoud/Repository/WishListRepo/wishlist_repository.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';


class WishListBloc extends Bloc<AppEvent,AppState>  {

  WishListBloc():super(Start()){
    on<AddToWishListEvent>(_onAddToWishList);
    on<removeFromWishListEvent>(_onRemoveFromWishList);
    on<getAllWishList_click>(_onGetAllWishList);
    on<AddToCarFromWishListEvent>(_onAddToCarFromWishList);
  }

  final WishListRepository wishlistRepository = WishListRepository();

  final BehaviorSubject<GetAllWishListModel> _wishlist_subject = BehaviorSubject<GetAllWishListModel>();
  @override
  get wishlist_subject {
    return _wishlist_subject;
  }

  @override
  void drainStream() {
    _wishlist_subject.close();
  }


  @override
  void dispose() async{
    await _wishlist_subject.drain();
    _wishlist_subject.close();
  }

  Future<void> _onAddToWishList(AddToWishListEvent event , Emitter<AppState> emit)async{
    var response = await wishlistRepository.addProudctToWishList(
        product_id: event.product_id,
        product_qty: event.qty,
        context: event.context
    );
    if(response ==true){
      emit( Done(indicator: 'add_fav'));
    }else{
      emit(  ErrorLoading(indicator: 'add_fav'));
    }
  }

  Future<void> _onRemoveFromWishList(removeFromWishListEvent event , Emitter<AppState> emit)async{
    emit( Loading(indicator: 'remove_fav'));

    var response = await wishlistRepository.removeProudctToWishList(
      wishlist_item_id: event.wishlist_item_id,
    );
    if(response==true){
      emit(   Done(indicator: 'remove_fav'));
    }else{
      emit(    ErrorLoading( indicator: 'remove_fav'));
    }
  }

  Future<void> _onGetAllWishList(getAllWishList_click event , Emitter<AppState> emit)async{
    emit( Loading(indicator: 'get_fav'));
    var response =await wishlistRepository.getAllWishListItems();
    if(response.message == "The consumer isn't authorized to access %resources."){
    }else{
      if(response.items!.isNotEmpty){
        _wishlist_subject.sink.add(response);

        emit(   Done(model: response , indicator: 'get_fav'));
      }else{
        emit(    ErrorLoading(model: response ,indicator: 'get_fav'));
      }
    }
  }

  Future<void> _onAddToCarFromWishList(AddToCarFromWishListEvent event , Emitter<AppState> emit)async{
    emit( Loading(indicator: 'add_wishlist_item_to_cart'));
    var response = await wishlistRepository.add_product_from_wishlist_to_cart(
        product_qty: event.qty,
        wishlist_product_id: event.wishlist_product_id,
        context: event.context
    );
    if(response ==true){
      emit( Done(indicator: 'add_wishlist_item_to_cart'));
    }else{
      emit(  ErrorLoading(indicator: 'add_wishlist_item_to_cart'));
    }
  }


  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading(indicator: 'add_cart');
    if(event is AddToWishListEvent){
      var response = await wishlistRepository.addProudctToWishList(
        product_id: event.product_id,
        product_qty: event.qty,
        context: event.context
      );
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
      yield Loading(indicator: 'get_fav');
      var response =await wishlistRepository.getAllWishListItems();
      if(response.message == "The consumer isn't authorized to access %resources."){
      }else{
        if(response.items!.isNotEmpty){
          _wishlist_subject.sink.add(response);

          yield  Done(model: response , indicator: 'get_fav');
        }else{
          yield   ErrorLoading(model: response ,indicator: 'get_fav');
        }
      }

    }
    else  if(event is AddToCarFromWishListEvent){
      yield Loading(indicator: 'add_wishlist_item_to_cart');
      var response = await wishlistRepository.add_product_from_wishlist_to_cart(
          product_qty: event.qty,
          wishlist_product_id: event.wishlist_product_id,
          context: event.context
      );
      if(response ==true){
        yield Done(indicator: 'add_wishlist_item_to_cart');
      }else{
        yield  ErrorLoading(indicator: 'add_wishlist_item_to_cart');
      }
    }
  }


}
final wishlist_bloc = WishListBloc();
