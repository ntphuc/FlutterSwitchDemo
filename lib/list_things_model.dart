

import 'cell_model.dart';

class ListThingsModel {
  List<CellModel> rows;

  ListThingsModel({this.rows});

  factory ListThingsModel.fromJson(Map<String, dynamic> json) {
    var list = json['rows'] as List;
    List<CellModel> listThings = list.map((e) => CellModel.fromJson(e)).toList();
    listThings  = listThings.where((item) => item.name.contains("Switch_")).toList();

    return ListThingsModel(
        rows: listThings
    );
  }
}