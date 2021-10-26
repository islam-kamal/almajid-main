import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/screens/Products/product_slider.dart';
import 'package:almajidoud/screens/Reviews/product_reviews.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/Favourites/custom_favourite.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:share/share.dart';

class singleCategoryProductItem extends StatelessWidget {
  Items product;
  singleCategoryProductItem({this.product});
  @override
  Widget build(BuildContext context) {
    List<String> gallery = new List<String>();
    product.mediaGalleryEntries.forEach((element) {
      gallery
          .add(ProductImages.getProductImageUrlByName(imageName: element.file));
    });
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            responsiveSizedBox(context: context, percentageOfHeight: .02),
            Neumorphic(
                child: Container(
                    width: width(context) * .9,
                    child: Row(
                      children: [
                        Container(
                          height: StaticData.get_height(context) * .23,
                          width: StaticData.get_width(context) * .3,
                          child: MyProductSlider(
                            data: gallery,
                            viewportFraction: 1.0,
                            aspect_ratio: 3.0,
                            border_radius: 5.0,
                            indicator: false,
                            motion: true,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              right: width(context) * .02,
                              left: width(context) * .02),
                          width: width(context) * .6,
                          height: isLandscape(context)
                              ? 2 * height(context) * .23
                              : height(context) * .23,
                          child: Column(
                            children: [
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              CustomFauvourite(
                                color: redColor,
                                favourite_status:
                                    product.status == 0 ? false : true,
                                product_id: product.id,
                              ),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .01),
                              customDescriptionText(
                                  context: context,
                                  textColor: mainColor,
                                  maxLines: 2,
                                  text: product.name,
                                  textAlign: TextAlign.start),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .012),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: customDescriptionText(
                                        context: context,
                                        textColor: mainColor,
                                        text: "${product.price} \$",
                                        textAlign: TextAlign.start,
                                        fontWeight: FontWeight.bold),
                                  ),
                               /*   RatingBar.readOnly(
                                    initialRating:
                                        product.visibility.toDouble(),
                                    maxRating: 5,
                                    isHalfAllowed: true,
                                    halfFilledIcon: Icons.star_half,
                                    filledIcon: Icons.star,
                                    emptyIcon: Icons.star_border,
                                    size: StaticData.get_width(context) * 0.03,
                                    filledColor:
                                        (product.visibility.toDouble() >= 1)
                                            ? Colors.yellow.shade700
                                            : Colors.yellow.shade700,
                                  ),*/

                             Container(
                                width: width(context) * 0.3,
                                height: 30,
                                child:     ProductReviews(
                                  product_sku: product.sku,
                                ),
                              )
                                ],
                              ),
                              responsiveSizedBox(
                                  context: context, percentageOfHeight: .02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: width(context) * .4,
                                    height: isLandscape(context)
                                        ? 2 * height(context) * .05
                                        : height(context) * .05,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: mainColor)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.shopping_cart_outlined),
                                        SizedBox(width: width(context) * .02),
                                        customDescriptionText(
                                            context: context,
                                            textColor: mainColor,
                                            text: "Add to cart",
                                            textAlign: TextAlign.start),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      final RenderBox box =
                                          context.findRenderObject();
                                      Share.share('${product.name}',
                                          subject: 'Welcome To Ezhyper',
                                          sharePositionOrigin:
                                              box.localToGlobal(Offset.zero) &
                                                  box.size);
                                    },
                                    child: Container(
                                      width: width(context) * .15,
                                      height: isLandscape(context)
                                          ? 2 * height(context) * .05
                                          : height(context) * .05,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: mainColor)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [Icon(Icons.share_outlined)],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(color: backGroundColor))),
          ],
        ),
      ],
    );
  }
}
