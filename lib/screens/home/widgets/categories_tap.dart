import 'dart:async';

import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class CategoriesTap extends StatefulWidget{
  var category_index;
  var category_name;
  CategoriesTap({this.category_index,this.category_name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return categoriesTapSate();
  }

}

class categoriesTapSate extends State<CategoriesTap> with TickerProviderStateMixin{
  TabController? _controller;

  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    _controller?.dispose();
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
              child: CircularProgressIndicator(
                backgroundColor: blackColor,
              ),
            );
          }
          else if (state is Done) {
            var data = state.model as CategoryModel;
            if (data.childrenData == null || data.childrenData!.isEmpty) {
              return Container();
            } else {

              return StreamBuilder<CategoryModel>(
                stream: categoryBloc.categories_subject,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == null) {
                      return Container();
                    } else {
                      _controller = TabController(length: snapshot.data!.childrenData!.length, vsync: this);

                      return Container(
                          width: width(context),
                          height: isLandscape(context) ? 2 * height(context) * .04: height(context) * .04,
                          color: whiteColor,
                          child: TabBar(
                            controller: _controller,
                            labelColor: mainColor,
                            isScrollable: true,
                            // indicatorColor: mainColor ,

                            onTap: (index){

                              customAnimatedPushNavigation(
                                  context, CategoryProductsScreen(
                                category_id: snapshot.data!.childrenData![index].id.toString(), //item.id.toString(),
                                category_name: snapshot.data!.childrenData![index].name.toString(),//item.name,
                                category_index: _controller!.index,
                              ));
                              },
                            tabs: snapshot.data!.childrenData!.map((item) {

                              if(item.isActive == true)
                                return    Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),

                                  child: Center(
                                    child: customDescriptionText(
                                        context: context,
                                        text: item.name,
                                        textColor: widget.category_name == item.name? redColor : mainColor ,
                                        percentageOfHeight: .015),
                                  ),
                                );

                              else
                                return Container();

                            }
                            ).toList(),
                          ),
                      );
                    }
                  }
                  else if (snapshot.hasError) {
                    return Container(
                      child: Text('${snapshot.error}'),
                    );
                  }
                  else {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: blackColor,
                      ),
                    );
                    ;
                  }
                },
              );
            }
          }
          else if (state is ErrorLoading) {
            return Container();
          }
          else {
            return Center(
              child: CircularProgressIndicator(

              ),
            );
          }
        },
      ),
    );
  }

}