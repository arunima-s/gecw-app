class NotificationModel {
  final String image, name, link, details, userId, timeStamp, eventDate;

  NotificationModel(this.image, this.name, this.link, this.details, this.userId,
      this.timeStamp, this.eventDate);

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        name = json['name'] as String,
        link = json['link'] as String,
        details = json['details'] as String,
        userId = json['uuid'] as String,
        timeStamp = json['time'] as String,
        eventDate = json['eventDate'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'name': name,
        'link': link,
        'details': details,
        'uuid': userId,
        'time': timeStamp,
        'eventDate': eventDate
      };
}
