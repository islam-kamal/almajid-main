

import 'dart:convert';

import 'package:almajidoud/Base/Shimmer/shimmer_notification.dart';
import 'package:almajidoud/Bloc/Product_Bloc/product_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/screens/bottom_Navigation_bar/custom_circle_navigation_bar.dart';
import 'package:almajidoud/screens/home/widgets/categories_tap.dart';
import 'package:almajidoud/screens/home/widgets/home_slider.dart';

import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/scheduler.dart';
import 'package:almajidoud/Repository/CategoryRepo/category_repository.dart';
class CategoryProductsScreen extends StatefulWidget {
  final String category_id;
  final String category_name;
  var category_index;
  CategoryProductsScreen({this.category_id,this.category_name,this.category_index});
  @override
  _CategoryProductsScreenState createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  //var offset = 0;
  // The controller for the ListView

  ScrollController _controller;
  int _page = 1;
  int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _posts = [];
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res = await categoryRepository.getCategoryProducts(
          category_id: widget.category_id,
          offset: _page
      );
      setState(() {
        _posts = res.items;
      });
    } catch (err) {
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        final res = await categoryRepository.getCategoryProducts(
            category_id: widget.category_id,
            offset: _page
        );

        final List fetchedPosts = res.items;
        if (fetchedPosts.length > 0) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final product_bloc = ProductBloc(null);

  @override
  void initState() {
    _firstLoad();
    _controller = new ScrollController()..addListener(_loadMore);
    super.initState();
  }
  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
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
                          child:_isFirstLoadRunning
                              ? Center(
                            child: CircularProgressIndicator(
                            ),
                          )
                              :Column(
                            children: [
                              CategoriesTap(
                                category_index: widget.category_index,
                                category_name: widget.category_name,

                              ),
                              Expanded(
                                  child: ListView.builder(
                                      controller: _controller,
                                      shrinkWrap: true,
                                      itemCount: _posts.length,
                                      itemBuilder: (context, index) {
                                        return   singleCategoryProductItem(
                                          product: _posts[index] ,
                                          scafffoldKey: _drawerKey,
                                          category_screen: CategoryProductsScreen(
                                              category_id: widget.category_id,
                                            category_name: widget.category_name,
                                          ),
                                        );

                                      })),
                              // when the _loadMore function is running
                              if (_isLoadMoreRunning == true)
                                Padding(
                                  padding: const EdgeInsets.only(top: 20, bottom: 100),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                    ),
                                  ),
                                ),

                              // When nothing else to load
                              if (_hasNextPage == false)
                                Container(
                                  padding: const EdgeInsets.only(top: 20, bottom: 100),
                                  color: mainColor,
                                  child: Center(
                                    child: Text(translator.translate(  "You have fetched all of the content"),style: TextStyle(color: whiteColor),),
                                  ),
                                ),
                            ],
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

        ),
        ),
      ),
    );
  }
}
