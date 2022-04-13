class CityModel {
  String? title;
  String? value;
  String? label;

  CityModel({this.title, this.value, this.label});

  CityModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['value'] = this.value;
    data['label'] = this.label;
    return data;
  }
}