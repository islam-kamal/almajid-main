import 'package:almajidoud/Base/shared_preference_manger.dart';
import 'package:almajidoud/Bloc/Bags_Bloc/bags_bloc.dart';
import 'package:almajidoud/Helper/app_event.dart';
import 'package:almajidoud/custom_widgets/custom_description_text.dart';
import 'package:almajidoud/custom_widgets/error_dialog.dart';
import 'package:almajidoud/utils/file_export.dart';
import 'package:almajidoud/utils/responsive.dart';
import 'package:flutter/material.dart';


class BagsWidget extends StatefulWidget {
  int? product_numbers;
   BagsWidget({this.product_numbers});

  @override
  _BagsWidgetState createState() => _BagsWidgetState();
}

class _BagsWidgetState extends State<BagsWidget> {

// Initial Selected Value
  int? dropdownvalue = 0;

// List of items in our dropdown menu

  late List<int?> list ;

  @override
  void initState() {
    list = new List<int?>.generate(widget.product_numbers!, (i) => i + 1);    super.initState();
    list.add(0);
    list.sort();

  }

  @override
  Widget build(BuildContext context) {
    return  BlocListener<BagsBloc,AppState>(
      bloc: bags_bloc,
        listener: (context, state) {
        if(state is Loading){
          if(state.indicator == "SendBagsNumberEvent"){

          }
        }else if(state is Done){
          if(state.indicator == "SendBagsNumberEvent"){
            StaticData.bags_request_status = true;

          }
        }else if(state is ErrorLoading){
          if(state.indicator == "SendBagsNumberEvent"){
            StaticData.bags_request_status = false;
          }
        }
        },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(Icons.shopping_bag,),
                SizedBox(width: 5,),
                Container(
                  alignment: Alignment.centerRight,
                  child: customDescriptionText(
                      context: context,
                      text: "Bags Number",
                      textAlign: TextAlign.start,
                      fontWeight: FontWeight.normal,
                      percentageOfHeight: .017),
                ),
              ],
            ),
           Container(
             width:  width(context) * .8,
             child:  DropdownButton(
               isExpanded: true,
               // Initial Value
               value: dropdownvalue,
               //itemHeight: 50,
               // Down Arrow Icon
               icon: const Icon(Icons.keyboard_arrow_down),

               // Array list of items
               items: list.map((int? items) {
                 return DropdownMenuItem(
                   value: items,
                   child: Text(items.toString()),
                 );
               }).toList(),
               menuMaxHeight:  width(context) * .5,
               // After selecting the desired option,it will
               // change button value to selected value
               onChanged: (int? newValue) {
                 setState(() {
                   dropdownvalue = newValue!;
                   StaticData.bags_number = dropdownvalue;
                   bags_bloc.add(SendBagsNumberEvent(
                       context: context,
                       bags_number: dropdownvalue
                   ));
                 });
               },
             ),
           )
          ],
        ),
      ),
    );
  }


}
