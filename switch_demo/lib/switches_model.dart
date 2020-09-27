import 'package:switch_demo/cell_model.dart';

class SwitchesModel {
  List<CellModel> switches;

  SwitchesModel({this.switches});

  factory SwitchesModel.fromJson(Map<String, dynamic> json) {
    var list = json['switches'] as List;
    List<CellModel> listThings = list.map((e) => CellModel.fromJson(e)).toList();
    return SwitchesModel(
        switches: listThings
    );
  }
}