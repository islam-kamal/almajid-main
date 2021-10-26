import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/Repository/Search_Repo/search_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<AppEvent,AppState>{
  SearchBloc(AppState initialState) : super(initialState);
  BehaviorSubject<SearchModel> _search_products_subject = new BehaviorSubject<SearchModel>();
  get search_products_subject {
    return _search_products_subject;
  }


  void drainStream() {
    _search_products_subject.value = null;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async*{
    if(event is SearchProductsEvent){
      yield Loading(indicator: 'search');
      var response = await search_repository.search_products_fun(
          search_text: event.search_text
      );
      if(response.totalCount != null ){
        _search_products_subject.sink.add(response);

        yield Done(model: response,indicator: 'search');
      }else{
        yield ErrorLoading(model: response,indicator: 'search');
      }
    }
  }

}

final search_bloc = SearchBloc(null);