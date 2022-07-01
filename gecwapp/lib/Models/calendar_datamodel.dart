class CalendarDataModel {
  final String title, date, details;

  CalendarDataModel(this.title, this.date, this.details);

  CalendarDataModel.fromJson(Map<dynamic, dynamic> json)
      : title = json['title'] as String,
        date = json['date'] as String,
        details = json['detail'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'title': title, 'date': date, 'detail': details};
}
