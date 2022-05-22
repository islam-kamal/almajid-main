class Promo {
  var startDate;
  String? endDate;
  String? type;
  var amount;
  String? englishLabel;
  String? arabicLabel;
  bool? status; // check if promo is active or not
  Promo(
      {this.startDate,
        this.endDate,
        this.type,
        this.amount,
        this.englishLabel,
        this.arabicLabel,
      this.status});

  Promo.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    type = json['type'];
    amount = json['amount'];
    englishLabel = json['english_label'];
    arabicLabel = json['arabic_label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['type'] = this.type;
    data['amount'] = this.amount;
    data['english_label'] = this.englishLabel;
    data['arabic_label'] = this.arabicLabel;
    return data;
  }
}