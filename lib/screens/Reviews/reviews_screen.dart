import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Reviews/product_reviews.dart';
import 'package:almajidoud/screens/Reviews/reviews_screen.dart';
import 'package:almajidoud/screens/Reviews/widgets/reviews_chart.dart';
import 'package:almajidoud/screens/Reviews/widgets/reviews_header.dart';
import 'package:almajidoud/screens/Reviews/widgets/single_review_item.dart';

class ReviewsScreen extends StatelessWidget {
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
                    reviewsHeader(context: context),
                    Container(
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
                                    (BuildContext context, bool innerBoxIsScrolled) {
                                  return <Widget>[
                                    SliverAppBar(
                                      automaticallyImplyLeading: false,
                                      leading: null,
                                      expandedHeight: isLandscape(context)
                                          ? 2 * height(context) * .4
                                          : height(context) * .4,
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
                                                    percentageOfHeight: .02),

                                                customDescriptionText(
                                                    context: context,
                                                    percentageOfHeight: .035,
                                                    text: "Overall Rating",
                                                    textColor: greyColor),
                                                responsiveSizedBox(
                                                    context: context,
                                                    percentageOfHeight: .01),

                                                customDescriptionText(
                                                    context: context,
                                                    percentageOfHeight: .05,
                                                    text: "5.0",
                                                    fontWeight: FontWeight.bold),
                                                responsiveSizedBox(
                                                    context: context,
                                                    percentageOfHeight: .01),

                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.star,
                                                      color: mainColor,
                                                    ),
                                                    SizedBox(
                                                      width: width(context) * .01,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: mainColor,
                                                    ),
                                                    SizedBox(
                                                      width: width(context) * .01,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: mainColor,
                                                    ),
                                                    SizedBox(
                                                      width: width(context) * .01,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: mainColor,
                                                    ),
                                                    SizedBox(
                                                      width: width(context) * .01,
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: mainColor,
                                                    ),
                                                    SizedBox(
                                                      width: width(context) * .01,
                                                    ),
                                                  ],
                                                ),
                                                responsiveSizedBox(
                                                    context: context,
                                                    percentageOfHeight: .01),

//                --------------------------------------------------------- chart part
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      singleChartWidget(
                                                          context: context,
                                                          color: Colors.green,
                                                          lineWidth: .5,
                                                          text: "Excellent"),
                                                      responsiveSizedBox(
                                                          context: context,
                                                          percentageOfHeight: .02),
                                                      singleChartWidget(
                                                          context: context,
                                                          color: Colors.lightGreen,
                                                          lineWidth: .45,
                                                          text: "Good"),
                                                      responsiveSizedBox(
                                                          context: context,
                                                          percentageOfHeight: .02),
                                                      singleChartWidget(
                                                          context: context,
                                                          color: Colors.yellowAccent,
                                                          lineWidth: .4,
                                                          text: "Average"),
                                                      responsiveSizedBox(
                                                          context: context,
                                                          percentageOfHeight: .02),
                                                      singleChartWidget(
                                                          context: context,
                                                          color: Colors.orangeAccent,
                                                          lineWidth: .3,
                                                          text: "Below Averge"),
                                                      responsiveSizedBox(
                                                          context: context,
                                                          percentageOfHeight: .02),
                                                      singleChartWidget(
                                                          context: context,
                                                          color: Colors.red,
                                                          lineWidth: .1,
                                                          text: "Poor"),
                                                      responsiveSizedBox(
                                                          context: context,
                                                          percentageOfHeight: .02),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          )),
                                    )
                                  ];
                                },
                                body: Container(
                                  color: backGroundColor,
                                  height: height(context) * .7,
                                  padding: EdgeInsets.only(
                                      right: width(context) * .05,
                                      left: width(context) * .05),
                                  child: ListView.builder(
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return singleRatingWidget(context: context);
                                    },
                                  ),
                                ),
                              ),
                            ),
//            ----------------------------------- top part
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
