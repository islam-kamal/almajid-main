import 'package:almajidoud/screens/product_details/widgets/add_to_cart_button.dart';
import 'package:almajidoud/screens/product_details/widgets/descriptionAndShareRow.dart';
import 'package:almajidoud/screens/product_details/widgets/divider.dart';
import 'package:almajidoud/screens/product_details/widgets/favourite_and_name_row.dart';
import 'package:almajidoud/screens/product_details/widgets/prica_and_rating_row.dart';
import 'package:almajidoud/screens/product_details/widgets/product_details_name_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/product_details_top_slider.dart';
import 'package:almajidoud/screens/product_details/widgets/quantity_button.dart';
import 'package:almajidoud/screens/product_details/widgets/size_and_quantity_text.dart';
import 'package:almajidoud/screens/product_details/widgets/sizes_listView.dart';
import 'package:almajidoud/screens/product_details/widgets/sold_by_widget.dart';
import 'package:almajidoud/screens/product_details/widgets/vat_and_reviews_row.dart';
import 'package:almajidoud/screens/product_details/widgets/write_review_button.dart';
import 'package:almajidoud/utils/file_export.dart';

class ProductDetailsScreen extends StatefulWidget {
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          responsiveSizedBox(context: context, percentageOfHeight: .05),
          productDetailsNameWidget(context: context),
          responsiveSizedBox(context: context, percentageOfHeight: .03),
          productDetailsTopSlider(context: context),
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          favouriteAndNameRow(context: context),
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          descriptionAndShareRow(context: context),
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          priceAndRatingRow(context: context),
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          vatAndReviewsRow(context: context),
          divider(context: context),
          sizeAndQuantityText(context: context , text: "Size") ,
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          sizesListView(context: context) ,
          divider(context: context),
          sizeAndQuantityText(context: context , text: "Quantity") ,
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          quantityButton(context: context),
          divider(context: context),
          addToCartButton(context: context) ,
          responsiveSizedBox(context: context, percentageOfHeight: .01),
          Container(height: height(context)*.1,color: mainColor,child: Column(children: [
            responsiveSizedBox(context: context, percentageOfHeight: .01),
            writeReviewButton(context: context) ,
            responsiveSizedBox(context: context, percentageOfHeight: .005),

            soldByWidget(context: context)

          ],),),
        ],
      )),
    );
  }
}
