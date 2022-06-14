class HostelListModel {
  final String id;
  final String name, image, location, phoneNum, price, details;
  // final String name;
  // final String image;
  // final String location;

  // HostelListModel(this.id, this.name, this.image, this.location);

  HostelListModel(this.id, this.name, this.image, this.location, this.phoneNum,
      this.price, this.details);

  HostelListModel.fromJson(Map<dynamic, dynamic> json)
      // : date = DateTime.parse(json['date'] as String),
      : id = json['id'] as String,
        name = json['name'] as String,
        image = json['image'] as String,
        location = json['location'] as String,
        phoneNum = json['phone'] as String,
        price = json['fees'] as String,
        details = json['details'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'id': id, 'name': name, 'image': image};
}


// class HostelListModel {
//   // final String id;
//   final String name, location, phoneNum, warden;
//   final bool hasFood;
//   final List<String> images, places;

//   HostelListModel(this.name, this.location, this.phoneNum, this.warden,
//       this.hasFood, this.images, this.places);

//   HostelListModel.fromJson(Map<dynamic, dynamic> json)
//       // : date = DateTime.parse(json['date'] as String),
//         : name = json['name'] as String,
//         location = json['location'] as String,
//         phoneNum = json['phone'] as String,
//         warden = json['warden'] as String,
//         hasFood = json['food'] as bool,
//         images = json['images'] as List<String>,
//         places = json['near'] as List<String>;



//   // Map<dynamic, dynamic> toJson() =>
//   //     <dynamic, dynamic>{'id': id, 'name': name, 'image': image};
// }