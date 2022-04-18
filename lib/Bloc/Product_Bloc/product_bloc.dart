import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';
class ProductBloc extends Bloc<AppEvent, AppState> {
  ProductBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<Items>> _products_subject = new BehaviorSubject<List<Items>>();
  get products_subject {
    return _products_subject;
  }

  BehaviorSubject<List<Items>> _cat_products_subject = new BehaviorSubject<List<Items>>();
  get cat_products_subject {
    return _cat_products_subject;
  }



  @override
  void dispose() {


  }
  final _categoryProducts_list = <Items>[];
  final _second_level_categoryProducts_list = <Items>[];

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
     if (event is getCategoryProducts) {
      yield Loading();

      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_cat_products_subject : _categoryProducts_list.addAll(response.items!);
        _cat_products_subject.sink.add(_categoryProducts_list);
        yield Done(model: response);
      } else if (response.message != null) {
        yield ErrorLoading(model: response);
      }
    }


  }
}

final product_bloc = ProductBloc(Start());
