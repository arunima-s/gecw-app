import 'dart:ffi';

class HostelListModel {
  final String id;
  final String name;
  final String image;
  final String location;

  HostelListModel(this.id, this.name, this.image, this.location);

  HostelListModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      : id = json['id'] as String,
        name = json['name'] as String,
        image = json['image'] as String,
        location = json['location'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'id': id, 'name': name, 'image': image};
}
