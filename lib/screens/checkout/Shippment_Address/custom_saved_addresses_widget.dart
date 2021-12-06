import 'package:almajidoud/Repository/CountriesRepo/countries_repoistory.dart';
import 'package:almajidoud/Repository/ShippmentAdressRepo/shipment_address_repository.dart';
import 'package:almajidoud/screens/checkout/checkout_address_screen.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:flutter/material.dart';
import 'package:almajidoud/Model/ShipmentAddressModel/client/saved_addresses_model.dart';


class CustomSavedAddressesWidget extends StatefulWidget {

  CustomSavedAddressesWidget();
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CustomSavedAddressesWidgetState();
  }
}

class CustomSavedAddressesWidgetState extends State<CustomSavedAddressesWidget> {
  var check = true;
  var _currentIndex = 1;

  var chossed_address_id;

  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: header_item[index],
      );
    });
  }

  List header_item = [translator.activeLanguageCode == 'ar'? 'اختيار من العناوين المحفوظة' : 'Chosse From Saved Address'];
  List<Item> _data;

  @override
  void initState() {
    print("StaticData.saved_addresses : ${StaticData.saved_addresses}");
    super.initState();
    _data = generateItems(1);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.9,
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
                  height: MediaQuery.of(context).size.width / 2.5,
                  child: FutureBuilder<List<SavedAddressesModel>>(
                    future: shipmentAddressRepository.get_all_saved_addresses(context: context),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            print("snapshot.data. ${snapshot.data[0].region}");
                            return Directionality(
                                textDirection: translator.activeLanguageCode == 'ar'?TextDirection.rtl : TextDirection.ltr,
                                child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    StaticData.new_address_status = true;
                                    customAnimatedPushNavigation(context,CheckoutAddressScreen());
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                    width: MediaQuery.of(context).size.width * 0.9,

                                    color: greyColor.withOpacity(.5),
                                    child: Text(translator.translate("Add new Address"),
                                      style: TextStyle(fontSize: AlmajedFont.secondary_font_size),),
                                  ),
                                ),
                              Expanded(child:  ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot.data.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  /*     if(snapshot.data.length ==0){
                                  return InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                                      color: greyColor.withOpacity(.5),
                                      child: Text(translator.translate("Add new Address"),
                                        style: TextStyle(fontSize: AlmajedFont.secondary_font_size),),
                                    ),
                                  );
                                }
*/
                                  return Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Container(
                                        padding: EdgeInsets.only(
                                            right: 10, left: 10),
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                              groupValue: _currentIndex,
                                              title: Text(
                                                  "${snapshot.data[index].region.region} ,${snapshot.data[index].street[0]}",
                                                  textDirection: TextDirection.rtl,
                                                  style: TextStyle(fontSize: AlmajedFont.secondary_font_size)
                                              ),
                                              value: snapshot.data[index].id,
                                              onChanged: (val) {
                                                setState(() {
                                                  _currentIndex = val;
                                                  chossed_address_id = snapshot.data[index].id;
                                                  sharedPreferenceManager.writeData(CachingKey.CHOSSED_ADDRESS_ID, chossed_address_id);

                                                  item.isExpanded = false;


                                                  header_item.add( "${snapshot.data[index].region.region} ,${snapshot.data[index].street[0]}");

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
                                },
                              ))
                              ],
                            )
                            );
                          } else {
                            return Container(
                              child: Text(
                                  translator.translate("There is no saved addresses")),
                            );
                          }
                        } else {
                          return Container(
                            child: Text(translator.translate("There is no saved addresses")),
                          );
                        }
                      }

                      // By default, show a loading spinner.
                      return Center(
                        child: CircularProgressIndicator(),
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

  var expandedValue;
  var headerValue;
  var isExpanded;
}
