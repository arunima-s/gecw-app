class BicycleClubModel {
  final String user, location;
  final bool isFree;

  BicycleClubModel(this.user, this.location, this.isFree);

  BicycleClubModel.fromJson(Map<dynamic, dynamic> json)
      : user = json['user'] as String,
        isFree = json['isFree'] as bool,
        location = json['location'] as String;

  Map<dynamic, dynamic> toJson() =>
      <dynamic, dynamic>{'user': user, 'isFree': isFree, 'location': location};
}
