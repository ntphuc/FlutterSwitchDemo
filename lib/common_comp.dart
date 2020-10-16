import 'package:flutter/material.dart';
import 'package:SwitchDemo/settings.dart';
import 'constants.dart';
import 'cell.dart';
import 'cell_model.dart';

class ComComp {
  static Padding text(String text, FontWeight fontWeight, double fontSize,
      List padding, Color color, TextOverflow overflow) {
    return Padding(
      padding: new EdgeInsets.only(
          left: padding[0],
          right: padding[1],
          top: padding[2],
          bottom: padding[3]),
      child: Text(
        text,
        textAlign: TextAlign.left,
        overflow: overflow,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
        ),
      ),
    );
  }

  static AppBar getAppBar(
      BuildContext context, Color color, bool isRoleAdmin, String title) {
    return AppBar(
      backgroundColor: COLORS.APP_THEME_COLOR,
      title: Text(title.toUpperCase()),
      actions: <Widget>[
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyLogin()),
                  );
                },
                child: Visibility(
                  visible: isRoleAdmin,
                  child: Icon(Icons.settings),
                ))),
      ],
    );
  }

  static CircularProgressIndicator circularProgress() {
    return CircularProgressIndicator(
      valueColor: new AlwaysStoppedAnimation<Color>(COLORS.APP_THEME_COLOR),
    );
  }

  static GestureDetector internetErrorText(Function callback) {
    return GestureDetector(
      onTap: callback,
      child: Center(
        child: Text(MESSAGES.INTERNET_ERROR),
      ),
    );
  }

  static Padding homeGrid(
      List<CellModel> list, Function onUpdateSwitchStatus, bool isRoleAdmin) {
    return Padding(
      padding:
          EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 20.0),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Cell(list[index], onUpdateSwitchStatus, isRoleAdmin),
            // onTap: () => gridClicked(context, snapshot.data.rows[index]),
          );
        },
      ),
    );
  }

  static FlatButton retryButton(Function fetch) {
    return FlatButton(
      child: Text(
        MESSAGES.INTERNET_ERROR_RETRY,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
      onPressed: () => fetch(),
    );
  }
}
