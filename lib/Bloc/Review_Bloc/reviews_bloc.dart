import 'package:almajidoud/utils/file_export.dart';
import 'package:rxdart/rxdart.dart';

class ReviewsBloc extends Bloc<AppEvent, AppState> with Validator{
  ReviewsBloc(AppState initialState) : super(initialState);

  BehaviorSubject<ProductReviewModel> _product_reviews_subject = new BehaviorSubject<ProductReviewModel>();
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
    if (event is GetProductReviewsEvent) {
      yield Loading();
      final response = await reviewsRepository.getProductReviews(
        product_sku: event.product_sku
      );
      print("response : $response");
      if (response != null) {
        _product_reviews_subject.sink.add(response);
        yield Done(model: response);
      } else if (response == null) {
        yield ErrorLoading(response);
      }
    }
  }
}

ReviewsBloc reviewsBloc = new ReviewsBloc(null);
