class CellModel {
  String name;
  String description;
  String avatar;
  bool status;

  CellModel({this.name, this.description, this.avatar});

  factory CellModel.fromJson(Map<String, dynamic> json) {
    return CellModel(
        name: json['name'] as String,
        description: json['description'] as String,
        avatar: json['avatar'] as String
    );
  }
}