import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';
class HomeBloc extends Bloc<AppEvent, AppState> {
  HomeBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<Items>> _new_arrivals_products_subject = new BehaviorSubject<List<Items>>();
  get new_arrivals_products_subject {
    return _new_arrivals_products_subject;
  }

  BehaviorSubject<List<Items>> _best_seller_products_subject = new BehaviorSubject<List<Items>>();
  get best_seller_products_subject {
    return _best_seller_products_subject;
  }




  @override
  void dispose() {


  }
  final _newArrivalsProducts_list = <Items>[];
  final _bestSellerProducts_list = <Items>[];

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GetHomeNewArrivals) {
      print("1");
      yield Loading();

      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items.isEmpty?_new_arrivals_products_subject : _newArrivalsProducts_list.addAll(response.items);
        _new_arrivals_products_subject.sink.add(_newArrivalsProducts_list);
        yield Done(model: response);
      } else if (response.message != null) {
        yield ErrorLoading(model: response);
      }
    }

    else  if (event is GetHomeBestSeller) {
      yield Loading();

      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items.isEmpty?_best_seller_products_subject : _bestSellerProducts_list.addAll(response.items);
        _best_seller_products_subject.sink.add(_bestSellerProducts_list);
        yield Done(model: response);
      } else if (response.message != null) {
        yield ErrorLoading(model: response);
      }
    }

  }
}

final home_bloc = HomeBloc(null);
