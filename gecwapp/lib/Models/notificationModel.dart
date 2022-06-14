class NotificationModel {
  // final String id;
  final String image, link, details;
  // final String name;
  // final String image;
  // final String location;

  // HostelListModel(this.id, this.name, this.image, this.location);

  NotificationModel(this.image, this.link, this.details);

  NotificationModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      // : id = json['id'] as String,
        : image = json['image'] as String,
        link = json['link'] as String,
        details = json['details'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'image': image, 'link': link};
}
