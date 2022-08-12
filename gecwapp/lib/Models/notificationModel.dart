class NotificationModel {
  final String image,
      link,
      details,
      userId,
      timeStamp,
      eventDate,
      user,
      eventName;
  final bool isVerified;

  NotificationModel(this.image, this.isVerified, this.link, this.details,
      this.userId, this.timeStamp, this.eventDate, this.user, this.eventName);

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      : image = json['image'] as String,
        isVerified = json['verified'] as bool,
        link = json['link'] as String,
        details = json['details'] as String,
        userId = json['uuid'] as String,
        timeStamp = json['time'] as String,
        eventDate = json['eventDate'] as String,
        user = json['club'] as String,
        eventName = json['name'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'image': image,
        'verified': isVerified,
        'link': link,
        'details': details,
        'uuid': userId,
        'time': timeStamp,
        'eventDate': eventDate,
        'club': user,
        'name': eventName
      };
}
