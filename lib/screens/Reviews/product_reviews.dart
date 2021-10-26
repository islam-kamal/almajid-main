import 'package:almajidoud/utils/file_export.dart';
import 'package:rating_bar/rating_bar.dart';
class  ProductReviews extends StatefulWidget{
  final String product_sku;
  ProductReviews({this.product_sku});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductReviewsState();
  }

}

class ProductReviewsState extends State<ProductReviews>{

  @override
  void initState() {
    reviewsBloc.add(GetProductReviewsEvent(
      product_sku: widget.product_sku
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child:BlocBuilder(
      bloc: reviewsBloc,
      builder: (context, state) {
        if (state is Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is Done) {
          var data = state.general_model as List<ProductReviewModel>;
          if (data == null ) {
            return Container();
          } else {
            return StreamBuilder<List<ProductReviewModel>>(
              stream: reviewsBloc.product_reviews_subject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data == null) {
                    return Container();
                  } else {
                    print("length : ${snapshot.data[0].ratings.length}");
                    List rating_list=[];
                    snapshot.data[0].ratings.forEach((element) {
                      rating_list.add(element.value);
                    });
                    var value = rating_list.reduce((a, b) => a + b) /snapshot.data[0].ratings.length ;
                    return RatingBar.readOnly(
                      initialRating: value.toDouble(),
                      maxRating: 5,
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      emptyIcon: Icons.star_border,
                      size: StaticData.get_width(context) * 0.03,
                      filledColor:
                      (value.toDouble() >= 1)
                          ? Colors.yellow.shade700
                          : Colors.yellow.shade700,
                    );

                  }
                } else if (snapshot.hasError) {
                  return Container(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                  ;
                }
              },
            );
          }
        } else if (state is ErrorLoading) {
          return Container();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
        ) );
  }

}