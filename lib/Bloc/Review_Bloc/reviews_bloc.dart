import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class ReviewsBloc extends Bloc<AppEvent, AppState> with Validator{

  ReviewsBloc():super(Start()){
    on<CreateReviewEvent>(_onCreateReviewEvent);
    on<GetProductReviewsEvent>(_onGetProductReviewsEvent);
  }

  BehaviorSubject<List<ProductReviewModel>> _product_reviews_subject = new BehaviorSubject<List<ProductReviewModel>>();
  get product_reviews_subject {
    return _product_reviews_subject;
  }

  BehaviorSubject<String> review_search_controller = BehaviorSubject<String>();
  Function(String) get review_search_change => review_search_controller.sink.add;
  Stream<String> get review_search => review_search_controller.stream.transform(input_text_validator);


  void drainStream() {
    _product_reviews_subject.close();
  }

  Future<void> _onCreateReviewEvent(CreateReviewEvent event , Emitter<AppState> emit)async{
    emit( Loading(indicator: "CreateReview"));
    final response = await reviewsRepository.create_product_review(
        nickname: event.nickname,
        detail: event.detail,
        title:  event.title,
        product_id: event.product_id
    );
    if (response.message == null) {
      emit( Done(model: response,indicator: "CreateReview"));
    }else{
      emit( ErrorLoading(model: response,indicator: "CreateReview"));
    }
  }

  Future<void> _onGetProductReviewsEvent(GetProductReviewsEvent event , Emitter<AppState> emit)async{
    emit( Loading(indicator: 'GetProductReviews'));
    final response = await reviewsRepository.getProductReviews(
        product_sku: event.product_sku
    );
    if (response != null) {
      _product_reviews_subject.sink.add(response);
      emit(  Done(general_model: response , indicator: 'GetProductReviews'));
    } else if (response == null) {
        emit(  ErrorLoading(indicator: 'GetProductReviews'));
    }
  }

}

ReviewsBloc reviewsBloc = new ReviewsBloc();
