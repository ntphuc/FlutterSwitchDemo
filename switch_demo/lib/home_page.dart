import 'dart:async';

import 'package:flutter/material.dart';
import 'package:switch_demo/list_things_model.dart';
import 'cell_model.dart';
import 'common_comp.dart';
import 'constants.dart';
import 'services.dart';
import 'switches_model.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHomeDataLoading;

  var timer;

  Duration TIME_DELAY_UPDATE = Duration(seconds: 5);

  // Future<ListThingsModel> listThingsModel;
  @override
  void initState() {
    super.initState();
    isHomeDataLoading = true;
    // listThingsModel = Services.fetchListThings();
    runTimeDelay();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: ComComp.getAppBar(COLORS.APP_THEME_COLOR, "Home"),
      body: Center(
        child: Container(
          child: FutureBuilder<SwitchesModel>(
            future: Services.fetchSwitches(),
            builder: (context, snapshot) {
              print("refresh isHomeDataLoading = " +
                  isHomeDataLoading.toString());
              if (!isHomeDataLoading ||
                  snapshot.connectionState == ConnectionState.done)
                return snapshot.hasData
                    ? ComComp.homeGrid(
                        snapshot.data.switches, onUpdateSwitchStatus)
                    : ComComp.retryButton(fetch);
              else
                return ComComp.circularProgress();
            },
          ),
        ),
      ),
    );
  }

  setLoading(bool loading) {
    setState(() {
      isHomeDataLoading = loading;
    });
  }

  fetch() {
    setLoading(true);
  }

  fetchWithoutLoading() {
    setLoading(false);
  }

  onUpdateSwitchStatus(BuildContext context, CellModel cellModel) {
    print("onUpdateSwitchStatus = " +
        cellModel.name +
        " status = " +
        cellModel.status.toString());
    fetchWithoutLoading();
  }

  void runTimeDelay() {
//    Future.delayed(const Duration(milliseconds: 5000), () {
//      fetchWithoutLoading();
//    });

    if (timer == null)
      timer = Timer.periodic(TIME_DELAY_UPDATE, (Timer t) {
        fetchWithoutLoading();
      });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}

gridClicked(BuildContext context, CellModel cellModel) {
  // Grid Click
  print("gridClicked = " +
      cellModel.name +
      " status = " +
      cellModel.status.toString());
}
