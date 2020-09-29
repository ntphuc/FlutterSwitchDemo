import 'package:flutter/material.dart';
import 'cell_model.dart';

class Cell extends StatelessWidget {
  @required
  final CellModel cellModel;
  @required
  final Function onUpdateSwitchStatus;

  const Cell(this.cellModel, this.onUpdateSwitchStatus);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding:
          new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 0.0, top: 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Switch(
                value: cellModel.status,
                onChanged: (value){
                  cellModel.status = value;
                  onUpdateSwitchStatus(context,cellModel);
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  cellModel.displayName,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}