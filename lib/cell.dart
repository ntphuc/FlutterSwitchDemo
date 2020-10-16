import 'package:custom_switch/custom_switch.dart';
import 'package:flutter/material.dart';
import 'cell_model.dart';

class Cell extends StatelessWidget {
  @required
  final CellModel cellModel;
  @required
  final bool isRoleAdmin;
  @required
  final Function onUpdateSwitchStatus;

  const Cell(this.cellModel, this.onUpdateSwitchStatus, this.isRoleAdmin);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Padding(
          padding:
              new EdgeInsets.only(left: 0.0, right: 0.0, bottom: 20.0, top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                  child: Text(
                cellModel.displayName,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontWeight: FontWeight.w500, fontSize: 20.0, color: Colors.black),
              )),
              Switch(
                activeColor: Colors.blue,
                value: cellModel.status,
                onChanged: (value) {
                  if ("power" != cellModel.displayName && isRoleAdmin) {
                    cellModel.status = value;
                    onUpdateSwitchStatus(context, cellModel);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
