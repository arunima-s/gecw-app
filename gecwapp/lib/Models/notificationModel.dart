class NotificationModel {
  final String image, link, details;

  NotificationModel(this.image, this.link, this.details);

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        link = json['link'] as String,
        details = json['details'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'image': image, 'link': link, 'details': details};
}
