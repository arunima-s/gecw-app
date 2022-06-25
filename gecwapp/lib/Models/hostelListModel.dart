class HostelListModel {
  // final String id;
  final String name, location, phoneNum, warden, address;
  final bool hasFood, hasRoom;
  final List<dynamic> images, places;

  HostelListModel(this.name, this.location, this.phoneNum, this.warden,
      this.address, this.hasFood, this.images, this.places, this.hasRoom);

  HostelListModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      : name = json['name'] as String,
        location = json['location'] as String,
        phoneNum = json['phone'] as String,
        warden = json['warden'] as String,
        address = json['address'] as String,
        hasFood = json['food'] as bool,
        hasRoom = json['room'] as bool,
        images = json['images'] as List<dynamic>,
        places = json['near'] as List<dynamic>;

  // Map<dynamic, dynamic> toJson() =>
  //     <dynamic, dynamic>{'id': id, 'name': name, 'image': image};
}
