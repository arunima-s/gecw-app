class NotificationModel {
  final String image, link, details, userId, timeStamp;

  NotificationModel(
      this.image, this.link, this.details, this.userId, this.timeStamp);

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        link = json['link'] as String,
        details = json['details'] as String,
        userId = json['uuid'] as String,
        timeStamp = json['time'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'link': link,
        'details': details,
        'uuid': userId,
        'time': timeStamp
      };
}
