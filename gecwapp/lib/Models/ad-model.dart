class ADModel {
  final String link;
  final bool status;

  ADModel(this.link, this.status);

  ADModel.fromJson(Map<dynamic, dynamic> json)
      : link = json['link'] as String,
        status = json['status'] as bool;
}
