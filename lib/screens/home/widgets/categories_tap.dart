import 'dart:async';

import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class CategoriesTap extends StatefulWidget{
  var category_index;
  CategoriesTap({this.category_index});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return categoriesTapSate();
  }

}

class categoriesTapSate extends State<CategoriesTap> with TickerProviderStateMixin{
  int _selectedIndex = 0;
  TabController _controller;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocBuilder(
        bloc: categoryBloc,
        builder: (context, state) {
          if (state is Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is Done) {
            var data = state.model as CategoryModel;
            if (data.childrenData == null || data.childrenData.isEmpty) {
              return Container();
            } else {

              return StreamBuilder<CategoryModel>(
                stream: categoryBloc.categories_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      _controller = TabController(length: snapshot.data.childrenData.length, vsync: this);
                      return Container(
                          width: width(context),
                          height: isLandscape(context) ? 2 * height(context) * .06 : height(context) * .06,
                          color: mainColor,
                          child: TabBar(
                            controller: _controller,
                            isScrollable: true,
                            indicatorColor: mainColor ,
                            tabs: snapshot.data.childrenData.map((item) => GestureDetector(
                              onTap: () {
                                customAnimatedPushNavigation(
                                      context, CategoryProductsScreen(
                                      category_id: item.id.toString(),
                                      category_name: item.name,
                                  category_index: _controller.index,
                                  ));
                              },
                              child: Container(
                                padding: EdgeInsets.only(right: 5,left: 5),
                                child:Center(
                                  child: customDescriptionText(
                                      context: context,
                                      text: item.name,
                                      textColor:  whiteColor,
                                      percentageOfHeight: .015),
                                ),
                              ),
                            )).toList() ,
                          )
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
      ),
    );
  }

}