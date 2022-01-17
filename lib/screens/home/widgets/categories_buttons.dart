import 'dart:async';

import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class CategoriesButtons extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return categoriesButtonsSate();
  }

}

class categoriesButtonsSate extends State<CategoriesButtons> with TickerProviderStateMixin{
  var selected_category = 0;
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
                          height: isLandscape(context)
                              ? 2 * height(context) * .05
                              : height(context) * .05,
                          color: mainColor,
                          child: TabBar(
                            controller: _controller,
                            isScrollable: true,
                            indicatorWeight: 5,
                            tabs: snapshot.data.childrenData.map((item) => GestureDetector(
                              onTap: () {
                                setState(() {

                                  selected_category = snapshot.data.childrenData.indexOf(item);
                                });
                                Timer(Duration(seconds: 1), () async {
                                  customAnimatedPushNavigation(
                                      context, CategoryProductsScreen(
                                    category_id: item.id.toString(),
                                    category_name: item.name,

                                  ));
                                });

                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: width(context) * .01),
                                      Container(
                                     padding: EdgeInsets.only(right: 5,left: 5),
                                        child: Center(
                                          child: customDescriptionText(
                                              context: context,
                                              text: item.name,
                                              textColor:  whiteColor,
                                              percentageOfHeight: .015),
                                        ),
                                      ),
                                    ],
                                  )),
                            )).toList() ,
                          )

                   /*       ListView.builder(
                      itemCount: snapshot.data.childrenData.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected_category = index;
                                });
                                Timer(Duration(seconds: 1), () async {
                                  customAnimatedPushNavigation(
                                      context, CategoryProductsScreen(
                                    category_id: snapshot.data
                                        .childrenData[index].id.toString(),
                                    category_name: snapshot.data
                                        .childrenData[index].name,

                                  ));
                                });

                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: width(context) * .01),
                                      Container(
                                        width: width(context) * .33,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: index == selected_category ? mainColor : whiteColor,
                                        ),

                                        child: Center(
                                          child: customDescriptionText(
                                              context: context,
                                              text: snapshot.data
                                                  .childrenData[index].name,
                                              textColor: index == selected_category
                                                  ? whiteColor
                                                  : mainColor,
                                              percentageOfHeight: .02),
                                        ),
                                      ),
                                    ],
                                  )),
                            );
                          })*/
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