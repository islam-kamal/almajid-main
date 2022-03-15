import 'package:almajidoud/Bloc/Search_Bloc/search_bloc.dart';
import 'package:almajidoud/Model/ProductModel/product_model.dart' as product_model;
import 'package:almajidoud/Model/ProductModel/product_model.dart';
import 'package:almajidoud/Model/SearchModel/search_model.dart';
import 'package:almajidoud/screens/SearchScreen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:almajidoud/Model/SearchModel/search_model.dart' as search_model;
import 'package:search_widget/search_widget.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/screens/SearchScreen/auto_search_screen.dart';
class AutoSearchClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<AutoSearchClass> {
  product_model.Items _selectedItem;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: StreamBuilder<ProductModel>(
          stream: search_bloc.search_products_subject,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.items == null) {
                return Container();
              } else {
                return SearchWidget<product_model.Items>(
                  dataList: snapshot.data.items,
                  hideSearchBoxWhenItemSelected: true,
                  listContainerHeight: MediaQuery.of(context).size.height / 4,
                  queryBuilder: (query, list) {
                    return list
                        .where((item) => item.name
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                        .toList();
                  },
                  popupListItemBuilder: (item) {
                    return PopupListItemWidget(item);
                  },
                  selectedItemBuilder: (selectedItem, deleteSelectedItem) {},
                  // widget customization
                  noItemsFoundWidget: NoItemsFound(),
                  textFieldBuilder: (controller, focusNode) {
                    return MyTextField(controller, focusNode);
                  },
                  onItemSelected: (item) {
                    setState(() {
                      _selectedItem = item;
                    });
                  },
                );
              }
            } else if (snapshot.hasError) {
              return Container(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                ),
              );
              ;
            }
          },
        ));
  }
}

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  const MyTextField(this.controller, this.focusNode);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: width(context) * .5,
      height: isLandscape(context) ? 2 * height(context) * .04 : height(context) * .04,
      child: TextFormField(
        onTap: (){
          customAnimatedPushNavigation(context, SearchScreen());
        },
        style: TextStyle(color:whiteColor),
        textAlign: TextAlign.right,

        cursorColor: greyColor.withOpacity(.5),
        decoration: InputDecoration(
          hintStyle: TextStyle(
            color: mainColor, fontSize: 12, ),
          hintText: translator.translate("Type here to search"),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.search,
              size: 20,
            ),
            color: mainColor,
            onPressed: () {
            },
          ),
          filled: false,

          contentPadding: new EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 1)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: mainColor, width: 1)),
        ),
      ),
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Text(
      translator.translate("There is no products"),
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[900].withOpacity(0.7),
      ),
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  final product_model.Items item;
  const PopupListItemWidget(this.item);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: translator.currentLanguage == 'en'
            ? TextDirection.ltr
            : TextDirection.rtl,
        child: InkWell(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(12),
            child: Text(
              item.name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          onTap: () {
            search_bloc.add(SearchProductsEvent(search_text: item.name));
            customAnimatedPushNavigation(context, AutoSearchScreen());

          },
        ));
  }
}
