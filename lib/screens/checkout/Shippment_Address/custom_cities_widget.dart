import 'package:almajidoud/Repository/CountriesRepo/countries_repoistory.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:almajidoud/Model/CityModel/city_model.dart';


class CustomCitiesWidget extends StatefulWidget {
  var city_name;
  CustomCitiesWidget({this.city_name});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomCitiesWidgetState();
  }
}

class CustomCitiesWidgetState extends State<CustomCitiesWidget> {
  var check = true;
  var _currentIndex = 1;

  var city_id;

  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: header_item[index],
      );
    });
  }

  List header_item = [translator.activeLanguageCode == 'ar'? 'اختيار المدينة' : 'Chosse City'];
  List<Item> _data;
  Future<List<CityModel>> cities_list;
  @override
  void initState() {
    cities_list= countriesRepository.get_cities(context: context);
    _data = generateItems(1);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(10),
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue),
                );
              },
              body: Container(
                  height: MediaQuery.of(context).size.width / 3,
                  child: FutureBuilder<List<CityModel>>(
                    future: cities_list,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState ==
                          ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder:
                                  (BuildContext context, int index) {

                                if(index ==0){
                                  return Container();
                                }else if(widget.city_name != null){
                                  snapshot.data.forEach((element) {
                                    if(element.title == widget.city_name || element.label == widget.city_name){
                                      city_id = element.value;
                                      _currentIndex = int.parse(city_id);
                                    }
                                  });
                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              groupValue:  _currentIndex,
                                              title: Text(
                                                "${translator.activeLanguageCode == 'ar'? snapshot.data[index].label :snapshot.data[index].title}",
                                                textDirection:
                                                TextDirection.rtl,
                                              ),
                                              value: snapshot.data[index].value,
                                              onChanged: (val) {
                                                setState(() {
                                                  _currentIndex = int.parse(val);
                                                  city_id = snapshot.data[index].value;
                                                  sharedPreferenceManager.writeData(CachingKey.REGION_ID, city_id);
                                                  sharedPreferenceManager.writeData(CachingKey.REGION_EN,  snapshot.data[index].title);
                                                  sharedPreferenceManager.writeData(CachingKey.REGION_AR,  snapshot.data[index].label);

                                                  item.isExpanded = false;


                                                  header_item.add(translator.activeLanguageCode == 'ar'? snapshot.data[index].label :snapshot.data[index].title);

                                                  item.headerValue =
                                                      header_item.last;
                                                });
                                              },
                                            ),
                                            Divider(
                                              color: Color(0xFFDADADA),
                                            )
                                          ],
                                        )),
                                  );
                                }else{
                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              groupValue:  _currentIndex,
                                              title: Text(
                                                "${translator.activeLanguageCode == 'ar'? snapshot.data[index].label :snapshot.data[index].title}",
                                                textDirection:
                                                TextDirection.rtl,
                                              ),
                                              value: snapshot.data[index].value,
                                              onChanged: (val) {
                                                setState(() {
                                                  _currentIndex = int.parse(val);
                                                  city_id = snapshot.data[index].value;
                                                  sharedPreferenceManager.writeData(CachingKey.REGION_ID, city_id);
                                                  sharedPreferenceManager.writeData(CachingKey.REGION_EN,  snapshot.data[index].title);
                                                  sharedPreferenceManager.writeData(CachingKey.REGION_AR,  snapshot.data[index].label);

                                                  item.isExpanded = false;


                                                  header_item.add(translator.activeLanguageCode == 'ar'? snapshot.data[index].label :snapshot.data[index].title);

                                                  item.headerValue =
                                                      header_item.last;
                                                });
                                              },
                                            ),
                                            Divider(
                                              color: Color(0xFFDADADA),
                                            )
                                          ],
                                        )),
                                  );
                                }

                              },
                            );
                          } else {
                            return Container(
                              child: Text(
                                  translator.translate("There is no cities")),
                            );
                          }
                        } else {
                          return Container(
                            child: Text(translator.translate("There is no cities")),
                          );
                        }
                      }

                      // By default, show a loading spinner.
                      return Center(
                        child: CircularProgressIndicator(
                        ),
                      );
                    },
                  )),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ));
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
