
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:almajidoud/utils/file_export.dart';

class CategoryBloc extends Bloc<AppEvent, AppState> with Validator{
  CategoryBloc(AppState initialState) : super(initialState);

  BehaviorSubject<String> category_search_controller = BehaviorSubject<String>();
  Function(String) get category_search_change => category_search_controller.sink.add;
  Stream<String> get category_search => category_search_controller.stream.transform(input_text_validator);

  BehaviorSubject<CategoryModel> _category_subject = new BehaviorSubject<CategoryModel>();
  get categories_subject {
    return _category_subject;
  }
  void set_category_subject(var value){
    _category_subject.sink.add(value);
  }

  BehaviorSubject<String> categories_search_value = new BehaviorSubject<String>();
  get get_categories_search_value{
    return categories_search_value;
  }



  void drainStream() {
   // _category_subject.value = null;
   // _category_product_subject.value = null;
  }

  void dispose(){
   // categoryBloc.drainStream();
    //categoryBloc.dispose();

  }
  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is getAllCategories) {
      yield Loading();
      final response = await categoryRepository.getCategoriesList();
      if (response.childrenData != null || response.childrenData!.isNotEmpty) {
        _category_subject.sink.add(response);
        yield Done(model: response);
      } else if (response.childrenData == null || response.childrenData!.isEmpty) {
        yield ErrorLoading(model: response);
      }
    }


  }

}

CategoryBloc categoryBloc = new CategoryBloc(null!);
