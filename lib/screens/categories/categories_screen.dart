import 'package:almajidoud/Bloc/Category_Bloc/category_bloc.dart';
import 'package:almajidoud/Model/CategoryModel/category_model.dart';
import 'package:almajidoud/utils/file_export.dart';

class SettingsDrawer extends StatefulWidget {
  final FocusNode node;
  SettingsDrawer({Key key, this.node}) : super(key: key);
  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  var current_index;
  bool finance_status = false;

  @override
  void initState() {
    super.initState();
    widget.node.unfocus();
  }

  @override
  void dispose() {
    widget.node.requestFocus();
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
                textDirection: translator.currentLanguage == 'ar' ? TextDirection.rtl : TextDirection.ltr,
                child:  Column(
                children: <Widget>[
                  Container(
                    color: whiteColor,
                    padding: EdgeInsets.only(
                        right: width(context) * .01, left: width(context) * .01),
                    child: Column(
                      children: [


                        BlocBuilder(
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
                                      if (snapshot.data.childrenData.isEmpty) {
                                        return Container();
                                      } else {
                                        return Column(
                                          children: [
                                            responsiveSizedBox(
                                                context: context, percentageOfHeight: .01),
                                            Container(
                                                width: width(context),
                                                padding: EdgeInsets.all(10),
                                                child: customDescriptionText(
                                                    context: context,
                                                    textAlign: TextAlign.start,
                                                    textColor: mainColor,
                                                    text: "${snapshot.data.name}",
                                                    percentageOfHeight: .025)),
                                            Divider(
                                              color: mainColor,
                                              height: 10,
                                            ),
                                            ListView.builder(
                                                shrinkWrap: true,
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: snapshot.data.childrenData.length,
                                                padding: EdgeInsets.all(5),
                                                itemBuilder: (context, index) {

                                                  return snapshot.data.childrenData[index].isActive == true ?
                                                  ListTile(
                                                    title: Container(
                                                      width: width(context),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          customDescriptionText(
                                                              context: context,
                                                              text: snapshot.data.childrenData[index].name),
                                                          Icon(
                                                            Icons.keyboard_arrow_down,
                                                            size: 30,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    subtitle: (finance_status) ?
                                                    ListView.builder(
                                                        shrinkWrap: true,
                                                        padding: EdgeInsets.all(5),
                                                        physics: NeverScrollableScrollPhysics(),
                                                        itemCount:  snapshot.data.childrenData[index].childrenData.length ,
                                                        itemBuilder: (context,ind){
                                                          return InkWell(
                                                              child: Padding(
                                                            padding: EdgeInsets.only(
                                                                right: 10, left: 10),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                  Padding(
                                                                  padding: EdgeInsets.only(top: 15, bottom: 5),
                                                                  child:  Text(
                                                                        snapshot.data.childrenData[index].childrenData[ind].name,
                                                                        style: TextStyle(
                                                                            color: mainColor,
                                                                            fontFamily: AlmajedFont.font_family,
                                                                            fontSize: AlmajedFont.secondary_font_size),
                                                                  ),
                                                          ),

                                                                Divider(
                                                                  color: mainColor,
                                                                ),

                                                              ],
                                                            ),
                                                          ),
                                                              onTap: () {

                                                                customAnimatedPushNavigation(
                                                                  context,
                                                                    CategoryProductsScreen(
                                                                   category_id: snapshot.data.childrenData[index].childrenData[ind].id.toString(),
                                                                      category_name: snapshot.data.childrenData[index].childrenData[ind].name,

                                                                    )

                                                                );


                                                              });
                                                        })
                                                        : null,
                                                    onTap: () {
                                                      setState(() {
                                                        finance_status = !finance_status;
                                                      });
                                                    },
                                                  ) : Container();
                                                })
                                          ],
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
