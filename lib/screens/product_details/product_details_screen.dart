import 'package:almajidoud/screens/home/widgets/home_slider.dart';
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
import 'package:almajidoud/Model/ProductModel/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  Items product;
  ProductDetailsScreen({this.product});
  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List product_images = [];
  var selected_size =0 ;
  @override
  void initState() {
    widget.product.mediaGalleryEntries.forEach((element) {
      product_images.add(
          "https://test.almajed4oud.com/media/catalog/product/cache/089af6965a318f5bf47750f284c40786" +
              element.file);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
      child: PageContainer(
        child: Scaffold(
            backgroundColor: whiteColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    productDetailsNameWidget(
                        context: context, product_name: widget.product.name),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .03),
                    HomeSlider(
                      gallery: product_images,
                    ),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .03),
                    favouriteAndNameRow(
                        context: context, product_name: widget.product.name),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    descriptionAndShareRow(
                        context: context,
                        description: widget.product.customAttributes[5].value,
                        product_name: widget.product.name),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    priceAndRatingRow(
                        context: context, price: widget.product.price),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    vatAndReviewsRow(context: context),
                    divider(context: context),
                    sizeAndQuantityText(context: context, text: "Size"),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    sizesListView(context: context),
                    divider(context: context),
                    sizeAndQuantityText(context: context, text: "Quantity"),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    quantityButton(context: context),
                    //divider(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .03),
                    addToCartButton(context: context),
                    responsiveSizedBox(
                        context: context, percentageOfHeight: .02),
                    Container(
                      height: height(context) * .1,
                      color: mainColor,
                      child: Column(
                        children: [
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .01),
                          writeReviewButton(context: context),
                          responsiveSizedBox(
                              context: context, percentageOfHeight: .005),
                          soldByWidget(context: context)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
  sizesListView({BuildContext context}) {

    return Container(
      width: width(context),
      height: isLandscape(context)
          ? 2 * height(context) * .07
          : height(context) * .07,
      child: ListView.builder(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                setState(() {
                  selected_size = index;
                });
              },
              child: Row(
                children: [
                  SizedBox(width: width(context) * .02),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: selected_size == index ?mainColor : greyColor, width: 2),
                        borderRadius: BorderRadius.circular(8)),
                    width: width(context) * .2,
                    child: Center(
                      child: customDescriptionText(
                          context: context, text: "90 ml", percentageOfHeight: .02),
                    ),
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
          scrollDirection: Axis.horizontal),
    );
  }
}
