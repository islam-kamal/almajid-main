import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class ReviewsBloc extends Bloc<AppEvent, AppState> with Validator{
  ReviewsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<List<ProductReviewModel>> _product_reviews_subject = new BehaviorSubject<List<ProductReviewModel>>();
  get product_reviews_subject {
    return _product_reviews_subject;
  }

  BehaviorSubject<String> review_search_controller = BehaviorSubject<String>();
  Function(String) get review_search_change => review_search_controller.sink.add;
  Stream<String> get review_search => review_search_controller.stream.transform(input_text_validator);


  void drainStream() {
    _product_reviews_subject.value = null;
  }

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {

   if(event is CreateReviewEvent){
     yield Loading(indicator: "CreateReview");
     final response = await reviewsRepository.create_product_review(
      nickname: event.nickname,
      detail: event.detail,
      title:  event.title,
      product_id: event.product_id
     );
     if (response.message == null) {
       yield Done(model: response,indicator: "CreateReview");
     }else{
       yield ErrorLoading(model: response,indicator: "CreateReview");
     }
   }

    else if (event is GetProductReviewsEvent) {
      yield Loading(indicator: 'GetProductReviews');
      final response = await reviewsRepository.getProductReviews(
        product_sku: event.product_sku
      );
      if (response != null) {
        _product_reviews_subject.sink.add(response);
      yield Done(general_model: response , indicator: 'GetProductReviews');
      } else if (response == null) {
        yield ErrorLoading(indicator: 'GetProductReviews');
      }
    }
  }
}

ReviewsBloc reviewsBloc = new ReviewsBloc(null);
