import 'dart:convert';
// Handler for the network's request.
abstract class RequestMappable {
  Map<String, dynamic> toJson();
}

// Handler for the network's response.

abstract class Mappable<T>  {
  factory  Mappable(Mappable  type, String data) {
    if (type is BaseMappable) {
      Map<String, dynamic> mappingData = json.decode(data);
      return type.fromJson(mappingData) as Mappable<T>;
    } else if (type is ListMappable) {
      var iterableData = json.decode(data);
      return type.fromJsonList(iterableData) as Mappable<T>;
    }
    return null as Mappable<T>;
  }
}

abstract class BaseMappable<T> implements Mappable {

  Mappable fromJson(Map<String, dynamic> json);
}

abstract class ListMappable<T> implements Mappable {
  Mappable fromJsonList(List<dynamic> json);
}
