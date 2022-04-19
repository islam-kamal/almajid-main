import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';
class HomeBloc extends Bloc<AppEvent, AppState> {
 // HomeBloc(AppState initialState) : super(initialState);

  HomeBloc() : super(Start()) {
    on<GetHomeNewArrivals>(_onGetHomeNewArrivals);
    on<GetHomeBestSeller>(_onGetHomeBestSeller);
    on<GetWeeklyDealSeller>(_onGetWeeklyDealSeller);
    on<GetTestahelCollectionEvent>(_onGetTestahelCollection);
    on<ProductDetailsEvent>(_onProductDetails);
  }

  BehaviorSubject<List<Items>> _new_arrivals_products_subject = new BehaviorSubject<List<Items>>();
  get new_arrivals_products_subject {
    return _new_arrivals_products_subject;
  }

  BehaviorSubject<List<Items>> _best_seller_products_subject = new BehaviorSubject<List<Items>>();
  get best_seller_products_subject {
    return _best_seller_products_subject;
  }

  BehaviorSubject<List<Items>> _weekly_deal_products_subject = new BehaviorSubject<List<Items>>();
  get weekly_deal_products_subject {
    return _weekly_deal_products_subject;
  }

  BehaviorSubject<List<Items>> _testahel_collection_products_subject = new BehaviorSubject<List<Items>>();
  get testahel_collection_products_subject {
    return _testahel_collection_products_subject;
  }

  BehaviorSubject<List<Items>> _products_details_subject = new BehaviorSubject<List<Items>>();
  get products_details_subject {
    return _products_details_subject;
  }

    BehaviorSubject<List<Items>> _related_products_subject = new BehaviorSubject<List<Items>>();
  get related_products_subject {
    return _related_products_subject;
  }

  @override
  void dispose() {
    _products_details_subject.close();
  }
  final _newArrivalsProducts_list = <Items>[];
  final _bestSellerProducts_list = <Items>[];
  final _weekly_dealProducts_list = <Items>[];
  final _testahel_collection_Products_list = <Items>[];


  Future<void> _onGetHomeNewArrivals(GetHomeNewArrivals event, Emitter<AppState> emit) async{

    try {
      emit(Loading());
      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_new_arrivals_products_subject : _newArrivalsProducts_list.addAll(response.items!);
        _new_arrivals_products_subject.sink.add(_newArrivalsProducts_list);
        emit(Done(model: response));
      } else if (response.message != null) {
        emit(ErrorLoading(model: response));
      }


    } catch (e) {
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }

  Future<void> _onGetHomeBestSeller(GetHomeBestSeller event, Emitter<AppState> emit) async{

    try {
      emit(Loading());
      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_best_seller_products_subject : _bestSellerProducts_list.addAll(response.items!);
        _best_seller_products_subject.sink.add(_bestSellerProducts_list);
        emit(Done(model: response));
      } else if (response.message != null) {
        emit(ErrorLoading(model: response));
      }


    } catch (e) {
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }

  Future<void> _onGetWeeklyDealSeller(GetWeeklyDealSeller event, Emitter<AppState> emit) async{

    try {
      emit(Loading());
      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_weekly_deal_products_subject : _weekly_dealProducts_list.addAll(response.items!);
        _weekly_deal_products_subject.sink.add(_weekly_dealProducts_list);
        emit(Done(model: response));
      } else if (response.message != null) {
        emit(ErrorLoading(model: response));
      }

    } catch (e) {
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }

  Future<void> _onGetTestahelCollection(GetTestahelCollectionEvent event, Emitter<AppState> emit) async{

    try {
      emit(Loading());
      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_testahel_collection_products_subject :
        _testahel_collection_Products_list.addAll(response.items!);
        _testahel_collection_products_subject.sink.add(_testahel_collection_Products_list);
        emit(Done(model: response));
      } else if (response.message != null) {
        emit(ErrorLoading(model: response));
      }
    } catch (e) {
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }

  Future<void> _onProductDetails(ProductDetailsEvent event, Emitter<AppState> emit) async{

    try {
      var response;
      if(event.product_id == null){
        response = await categoryRepository.getProduct(
            sku: event.product_sku
        );
      }else{
        response = await categoryRepository.getProduct(
            id: event.product_id
        );
      }

      if(response.message == null){
        _products_details_subject.sink.add(response.items);
        emit( Done(model: response));
      }else{
        emit( ErrorLoading(model: response));
      }
    } catch (e) {
      emit(
        ErrorLoading(message: "Failed to fetch data. Is your device online ?",
        ),
      );
    }
  }


/*  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GetHomeNewArrivals) {
      yield Loading();

      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_new_arrivals_products_subject : _newArrivalsProducts_list.addAll(response.items!);
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
        response.items!.isEmpty?_best_seller_products_subject : _bestSellerProducts_list.addAll(response.items!);
        _best_seller_products_subject.sink.add(_bestSellerProducts_list);
        yield Done(model: response);
      } else if (response.message != null) {
        yield ErrorLoading(model: response);
      }
    }

    else  if (event is GetWeeklyDealSeller) {
      yield Loading();
      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_weekly_deal_products_subject : _weekly_dealProducts_list.addAll(response.items!);
        _weekly_deal_products_subject.sink.add(_weekly_dealProducts_list);
        yield Done(model: response);
      } else if (response.message != null) {
        yield ErrorLoading(model: response);
      }
    }
    else  if (event is GetTestahelCollectionEvent) {
      yield Loading();

      final response = await categoryRepository.getCategoryProducts(
          category_id: event.category_id,
          offset: event.offset
      );
      if (response.message == null) {
        response.items!.isEmpty?_testahel_collection_products_subject :
        _testahel_collection_Products_list.addAll(response.items!);
        _testahel_collection_products_subject.sink.add(_testahel_collection_Products_list);
        yield Done(model: response);
      } else if (response.message != null) {
        yield ErrorLoading(model: response);
      }
    }

    else if(event is ProductDetailsEvent){
      var response;
      if(event.product_id == null){
         response = await categoryRepository.getProduct(
            sku: event.product_sku
        );
      }else{
         response = await categoryRepository.getProduct(
        id: event.product_id
        );
      }

      if(response.message == null){
        _products_details_subject.sink.add(response.items);
        yield Done(model: response);
      }else{
        yield ErrorLoading(model: response);
      }
    }

  }*/
}

final home_bloc = HomeBloc();
