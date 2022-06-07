import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingsDrawer extends StatefulWidget {
  final FocusNode? node;
  SettingsDrawer({Key? key, this.node}) : super(key: key);
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  var current_index;
  bool finance_status = false;
  List<bool> _isExpanded = List.generate(50, (_) => false);

  @override
  void initState() {
    super.initState();
    widget.node!.unfocus();
  }

  @override
  void dispose() {
    widget.node!.requestFocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Container(
            height: height(context),
            color: whiteColor,
            child: SingleChildScrollView(
              child: Directionality(
                textDirection: translator.activeLanguageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child:  Column(
                  children: <Widget>[
                    Container(
                      color: whiteColor,
                      padding: EdgeInsets.only(right: width(context) * .01, left: width(context) * .01),
                      child: Column(
                        children: [
                          BlocBuilder(
                            bloc: categoryBloc,
                            builder: (context, state) {
                              if (state is Loading) {
                                return Center(
                                  child: SpinKitFadingCube(
                                    color: Theme.of(context).primaryColor,
                                    size: width(context) *0.05,
                                  ),
                                )
                                ;
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
                                        if (snapshot.data!.childrenData!.isEmpty) {
                                          return Container();
                                        } else {
                                          return Column(
                                            children: [
                                              responsiveSizedBox(context: context, percentageOfHeight: .01),
                                              Container(
                                                  width: width(context),
                                                  padding: EdgeInsets.all(10),
                                                  child: customDescriptionText(
                                                      context: context,
                                                      textAlign: TextAlign.start,
                                                      textColor: mainColor,
                                                      text: "${snapshot.data!.name}",
                                                      percentageOfHeight: .025)),
                                              Divider(
                                                color: mainColor,
                                                height: 10,
                                              ),


                                              ExpansionPanelList(
                                                expansionCallback: (index, isExpanded) => setState(() {
                                                  _isExpanded[index] = !isExpanded;
                                                }),
                                                children: [
                                                  for (int i = 0; i < snapshot.data!.childrenData!.length; i++)
                                                    if(snapshot.data!.childrenData![i].isActive == true)
                                                      ExpansionPanel(
                                                        headerBuilder: (_, isExpanded) {
                                                          return Center(
                                                            child:  InkWell(
                                                                onTap: (){

                                                                  var parentItem = snapshot.data!.childrenData![i];
                                                                  customAnimatedPushNavigation(
                                                                      context,
                                                                      CategoryProductsScreen(
                                                                        category_id: parentItem.id.toString(),
                                                                        category_name: parentItem.name,

                                                                      )

                                                                  );
                                                                },
                                                                child:
                                                                Container(
                                                                  margin: const EdgeInsets.all(6.0),
                                                                  padding: const EdgeInsets.all(10.0),
                                                                  width: double.infinity,
                                                                  child: Text(snapshot.data!.childrenData![i].name!),
                                                                )
                                                            ),
                                                          );
                                                        },
                                                        body: ListView.builder(
                                                            shrinkWrap: true,
                                                            padding: EdgeInsets.all(5),
                                                            physics: NeverScrollableScrollPhysics(),
                                                            itemCount:  snapshot.data!.childrenData![i].childrenData!.length ,
                                                            itemBuilder: (context,ind){
                                                              if(snapshot.data!.childrenData![i].childrenData![ind].isActive == true){
                                                                return InkWell(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(
                                                                          right: 10, left: 10),
                                                                      child: Card(

                                                                          child: Container(
                                                                            margin: const EdgeInsets.all(3.0),
                                                                            padding: const EdgeInsets.all(10.0),
                                                                            width: double.infinity,
                                                                            child: Text(snapshot.data!.childrenData![i].childrenData![ind].name!),
                                                                          )

                                                                      ),
                                                                    ),
                                                                    onTap: () {

                                                                      customAnimatedPushNavigation(
                                                                          context,
                                                                          CategoryProductsScreen(
                                                                            category_id: snapshot.data!.childrenData![i].childrenData![ind].id.toString(),
                                                                            category_name: snapshot.data!.childrenData![i].childrenData![ind].name,

                                                                          )

                                                                      );


                                                                    });
                                                              }

                                                              else{  //used for null safety not from code
                                                                return Container();
                                                              }

                                                            }),
                                                        isExpanded: _isExpanded[i],
                                                        canTapOnHeader: false,
                                                        //   hasIcon: snapshot.data.childrenData[i].childrenData.length > 0 ?true:false,
                                                      ),
                                                ],
                                              ),

                                              Container(
                                                height: width(context) * 0.5,
                                              )
                                            ],
                                          );
                                        }
                                      } else if (snapshot.hasError) {
                                        return Container(
                                          child: Text('${snapshot.error}'),
                                        );
                                      }
                                      else {
                                        return Center(
                                          child: SpinKitFadingCube(
                                            color: Theme.of(context).primaryColor,
                                            size: width(context) *0.05,
                                          ),
                                        )
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
                                  child: SpinKitFadingCube(
                                    color: Theme.of(context).primaryColor,
                                    size: width(context) *0.05,
                                  ),
                                )
                                ;
                              }
                            },
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
      ),
    );
  }
}
