import 'package:almajidoud/Base/network-mappers.dart';
import 'package:almajidoud/utils/file_export.dart';
abstract class AppState {
  get model =>null;
}
class Start extends AppState{

}

class Loading extends AppState{
  final String indicator;
  Mappable model;
  Loading({this.model , this.indicator});

  @override
  String toString() {
    // TODO: implement toString
    print('Loading');
  }

}

class Done extends AppState{
  Mappable model;
  final String indicator;
  List<dynamic> general_model;
  var general_value;
  Done({this.model , this.indicator,this.general_model, this.general_value});

  @override
  String toString() {
    // TODO: implement toString
    print('Done');
  }

}

class ErrorLoading extends AppState{
  Mappable model;
  List<dynamic> general_model;
  String indicator;
  String message;
  ErrorLoading({this.model,this.message,this.indicator,this.general_model});
  @override
  String toString() {
    // TODO: implement toString
    print('ErrorLoading');
  }

}
class EmptyField extends AppState{
  var value;
  EmptyField({this.value= 'بيانات الطلب غير مكتملة '});

  @override
  String toString() {
    // TODO: implement toString
    print('RadioSelection : ${value}');
  }


}

class RadioSelection extends AppState{
   var value;
  RadioSelection({this.value});

  @override
  String toString() {
    // TODO: implement toString
    print('RadioSelection : ${value}');
  }


}

