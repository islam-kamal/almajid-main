

void main() {
  List list1 = [{'attribute_code':'mobile_number','value':'+966591826195'},
    {'attribute_code':'name','value':'Ali'}];
  final mobileElement = list1.firstWhere((element) => element['attribute_code'] == 'mobile_number');

  print(mobileElement['value'].toString());
}



