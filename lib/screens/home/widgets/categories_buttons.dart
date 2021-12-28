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

class categoriesButtonsSate extends State<CategoriesButtons>{
  var selected_category = 0;

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
                      print("length : ${snapshot.data.childrenData.length}");

                      return Container(
                          width: width(context),
                          height: isLandscape(context)
                              ? 2 * height(context) * .05
                              : height(context) * .05,
                          child: ListView.builder(
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
                              }));
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