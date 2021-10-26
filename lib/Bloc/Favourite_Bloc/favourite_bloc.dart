
import 'package:almajidoud/Model/FavouriteModel/favourite_list_model.dart';
import 'package:almajidoud/Repository/FavouriteRepo/favourite_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';


class FavouriteBloc extends Bloc<AppEvent,AppState>  {


  final FavouriteRepository favouriteRepository = FavouriteRepository();

  final BehaviorSubject<FavouriteListModel> _subject = BehaviorSubject<FavouriteListModel>();
  @override
  get subject {
    return _subject;
  }


  FavouriteBloc(AppState initialState) : super(initialState);

  @override
  void drainStream() {
    _subject.value = null;
  }


  @override
  void dispose() async{
    await _subject.drain();
    _subject.close();
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    yield Loading(indicator: 'add_fav');
    if(event is addFavourite_click){
      print('event.product_id : ${event.product_id}');
      var response = await favouriteRepository.addProudctToFavourite(
        product_id: event.product_id,
      );
      print('event.response : ${response}');
      if(response.status==true){
        yield Done(model: response ,indicator: 'add_fav');
      }else{
        yield  ErrorLoading(model: response ,indicator: 'add_fav');
      }
    }
    else if(event is removeFavourite_click){
      yield Loading(indicator: 'remove_fav');
      var response = await favouriteRepository.removeProudctFromFavourite(
        product_id: event.product_id,
      );
      if(response.status==true){
        yield  Done(model: response , indicator: 'remove_fav');
      }else{
        yield   ErrorLoading(model: response , indicator: 'remove_fav');
      }
    }else if(event is getAllFavoutites_click){
      print("fav 1");
      yield Loading(indicator: 'get_fav');
      var response =await favouriteRepository.getAllFavourite();
      print("fav 2");
      if(response.status==true){
        print("fav 3");
        _subject.sink.add(response);
        yield  Done(model: response , indicator: 'get_fav');
        print("fav 4");
      }else{
        print("fav 5");
        yield   ErrorLoading(model: response ,indicator: 'get_fav');
      }

    }
  }


}
final favourite_bloc = FavouriteBloc(null);
