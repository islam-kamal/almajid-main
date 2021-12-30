import 'package:almajidoud/Base/Shimmer/shimmer_notification.dart';
import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';

import 'package:almajidoud/utils/file_export.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String category_id;
  final String category_name;
  CategoryProductsScreen({this.category_id,this.category_name});
  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  var offset = 1;
  ScrollController _controller;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    _controller = ScrollController()..addListener(_scrollListener);

    product_bloc.add(
        getCategoryProducts(category_id: widget.category_id, offset: offset));
    super.initState();
  }

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      setState(() {
        offset += 1;
        print("---- offest ------ :${offset}");
      });
      product_bloc.add(
          getCategoryProducts(offset: offset, category_id: widget.category_id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return NetworkIndicator(
        child: PageContainer(
            child: Scaffold(
              key: _drawerKey,
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
          child: Column(
        children: [
          ScreenAppBar(
            right_icon: 'cart',
            category_name: widget.category_name,
            screen: CustomCircleNavigationBar(),
          ),
          Container(
            height: height(context),
              child: Container(
                // height: isLandscape(context) ? 2 * height(context) * .65 : height(context) * .65,
                child: BlocBuilder(
                  bloc: product_bloc,
                  builder: (context, state) {
                    if (state is Loading) {
                      return Center(
                        child: ShimmerNotification(),
                      );
                    } else if (state is Done) {
                      var data = state.model as ProductModel;
                      if (data.items == null || data.items.isEmpty) {
                        return Container();
                      } else {
                        return StreamBuilder<List<product_model.Items>>(
                          stream: product_bloc.cat_products_subject,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data == null) {
                                return Container();
                              } else {
                                print("length : ${snapshot.data.length}");

                                return ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, index) {

                                      return index >= snapshot.data.length
                                          ? MyLoader(25, 25)
                                          : snapshot.data[index] == null
                                              ? Container()
                                              : singleCategoryProductItem(
                                        product: snapshot.data[index] ,
                                        scafffoldKey: _drawerKey,
                                      );

                                    });

                              }
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
                      }
                    } else if (state is ErrorLoading) {
                      return Container();
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
          )
        ],
      )),
    )));
  }


}

class MyLoader extends StatelessWidget {
  final double width;
  final double height;

  MyLoader(this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            backgroundColor: mainColor,
          ),
        ),
      ),
    );
  }
}
