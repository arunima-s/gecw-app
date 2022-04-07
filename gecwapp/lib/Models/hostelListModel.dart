import 'dart:ffi';

class HostelListModel {
  String id;
  String name;
  String image;

  HostelListModel(this.id, this.name, this.image);

  HostelListModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      : id = json['id'] as String,
        name = json['name'] as String,
        image = json['image'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'id': id, 'name': name, 'image': image};
}
