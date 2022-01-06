import 'package:almajidoud/Base/Shimmer/shimmer_notification.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/product_reviews_screen.dart';
import 'package:almajidoud/screens/Reviews/widgets/reviews_chart.dart';
import 'package:almajidoud/screens/Reviews/widgets/reviews_header.dart';
import 'package:almajidoud/screens/Reviews/widgets/single_review_item.dart';

class ProductReviewsScreen extends StatefulWidget{
  var product_suk;
  var product_id;
  ProductReviewsScreen({this.product_suk,this.product_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductReviewsScreenState();
  }

}
class ProductReviewsScreenState extends State<ProductReviewsScreen> {
  @override
  void initState() {
    print("product_suk : ${widget.product_suk}");
    reviewsBloc.add(GetProductReviewsEvent(
        product_sku: widget.product_suk
    ));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
            body: Container(
          height: isLandscape(context) ? 2 * height(context) : height(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                reviewsHeader(context: context,
                product_id: widget.product_id),
                BlocBuilder(
                  bloc: reviewsBloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      if(state.indicator ==  'GetProductReviews')
                      return Center(child: ShimmerNotification(),);
                    } else if (state is Done) {
                      if(state.indicator ==  'GetProductReviews')
                      return StreamBuilder<List<ProductReviewModel>>(
                        stream: reviewsBloc.product_reviews_subject,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              height: isLandscape(context)
                                  ? 2 * height(context) * .88
                                  : height(context) * .88,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      height: isLandscape(context)
                                          ? 2 * height(context) * .88
                                          : height(context) * .88,
                                      child: NestedScrollView(
                                        headerSliverBuilder:
                                            (BuildContext context,
                                                bool innerBoxIsScrolled) {
                                          return <Widget>[
                                            SliverAppBar(
                                              automaticallyImplyLeading: false,
                                              leading: null,
                                              expandedHeight:
                                                  isLandscape(context)
                                                      ? 2 * height(context) * .2 : height(context) * .2,
                                              floating: false,
                                              backgroundColor: whiteColor,
                                              elevation: 0,
                                              pinned: false,
                                              flexibleSpace: FlexibleSpaceBar(
                                                  background: Container(
                                                child: Column(
                                                  children: [
                                                    responsiveSizedBox(
                                                        context: context,
                                                        percentageOfHeight:
                                                            .02),

                                                    customDescriptionText(
                                                        context: context,
                                                        percentageOfHeight:
                                                            .035,
                                                        text: translator.translate("Overall Rating"),
                                                        textColor: greyColor),
                                                    responsiveSizedBox(
                                                        context: context,
                                                        percentageOfHeight:
                                                            .01),

                                                    customDescriptionText(
                                                        context: context,
                                                        percentageOfHeight: .05,
                                                        text: snapshot.data
                                                                    .length >
                                                                0
                                                            ? "5.0"
                                                            : "0.0",
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    responsiveSizedBox(
                                                        context: context,
                                                        percentageOfHeight:
                                                            .01),

                                                    SmoothStarRating(
                                                      rating:
                                                          snapshot.data.length >
                                                                  0
                                                              ? 5.0
                                                              : 0.0,
                                                      isReadOnly: true,
                                                      size: height(context) *
                                                          .045,
                                                      color:
                                                          Colors.orangeAccent,
                                                      borderColor:
                                                          Colors.orangeAccent,
                                                      filledIconData:
                                                          Icons.star,
                                                      halfFilledIconData:
                                                          Icons.star_half,
                                                      defaultIconData:
                                                          Icons.star_border,
                                                      starCount: 5,
                                                      allowHalfRating: true,
                                                      spacing: 5.0,
                                                    ),
                                                    responsiveSizedBox(
                                                        context: context,
                                                        percentageOfHeight:
                                                            .01),

                                                  ],
                                                ),
                                              )),
                                            )
                                          ];
                                        },
                                        body: Container(
                                          color: snapshot.data.isEmpty ? whiteColor :backGroundColor,
                                          height: height(context) * .7,
                                          padding: EdgeInsets.only(
                                              top: width(context) * .05,
                                              right: width(context) * .02,
                                              left: width(context) * .02),
                                          child: snapshot.data.isEmpty
                                              ? no_data_widget(
                                                  context: context,
                                                  message: translator.translate("No Reviews Yet!"))
                                              : ListView.builder(
                                                  itemCount:
                                                      snapshot.data.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return singleRatingWidget(
                                                        context: context,
                                                        nickname: snapshot
                                                            .data[index]
                                                            .nickname,
                                                        detail: snapshot
                                                            .data[index].detail,
                                                        createdAt: snapshot
                                                            .data[index]
                                                            .createdAt);
                                                  },
                                                ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                          } else if (snapshot.hasError) {
                            return Container(
                              child: Text('${snapshot.error}'),
                            );
                          } else {
                            return Center(
                              child: ShimmerNotification(),
                            );
                            ;
                          }
                        },
                      );
                    } else if (state is ErrorLoading) {
                      if(state.indicator ==  'GetProductReviews')
                      return Container();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
