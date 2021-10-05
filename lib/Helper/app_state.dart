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
  Done({this.model , this.indicator});

  @override
  String toString() {
    // TODO: implement toString
    print('Done');
  }

}

class ErrorLoading extends AppState{
  Mappable model;
  String indicator;
  String message;
  ErrorLoading(this.model,{this.message,this.indicator});
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

