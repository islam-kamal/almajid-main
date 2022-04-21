import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/Repository/Search_Repo/search_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc extends Bloc<AppEvent,AppState> {

  SearchBloc() : super(Start()) {
    on<SearchProductsEvent>(_onSearchProductFun);
  }


  BehaviorSubject<ProductModel> _search_products_subject = new BehaviorSubject<ProductModel>();
  get search_products_subject {
    return _search_products_subject;
  }


  void drainStream() {
    _search_products_subject.close();
  }


  Future<void> _onSearchProductFun(SearchProductsEvent event, Emitter<AppState> emit) async {
    try {
      emit(Loading());
      var response = await search_repository.search_products_fun(
          search_text: event.search_text
      );

      if(response.totalCount != null ){
        _search_products_subject.sink.add(response);

        emit( Done(model: response,indicator: 'search'));
      }else{
        emit( ErrorLoading(model: response,indicator: 'search'));
      }

    } catch (e) {
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }

}

final search_bloc = SearchBloc();