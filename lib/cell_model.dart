class CellModel {
  String name;
  String displayName;
  bool status = false;

  CellModel({this.name, this.displayName, this.status});

  factory CellModel.fromJson(Map<String, dynamic> json) {
    return CellModel(
        name: json['name'] as String,
        displayName: json['displayName'] as String,
        status: json['status'] as bool
    );
  }
}