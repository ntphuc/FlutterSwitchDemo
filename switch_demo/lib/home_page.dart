import 'package:flutter/material.dart';
import 'package:switch_demo/list_things_model.dart';
import 'cell_model.dart';
import 'common_comp.dart';
import 'constants.dart';
import 'services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHomeDataLoading;

  // Future<ListThingsModel> listThingsModel;
  @override
  void initState() {
    super.initState();
    isHomeDataLoading = false;
    // listThingsModel = Services.fetchListThings();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: ComComp.getAppBar(COLORS.APP_THEME_COLOR, "Home"),
      body: Center(
        child: Container(
          child: FutureBuilder<ListThingsModel>(
            future: Services.fetchListThings(),
            builder: (context, snapshot) {
              return snapshot.connectionState == ConnectionState.done
                  ? snapshot.hasData
                      ? ComComp.homeGrid(snapshot, onUpdateSwitchStatus)
                      : ComComp.retryButton(fetch)
                  : ComComp.circularProgress();
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
}

onUpdateSwitchStatus(BuildContext context, CellModel cellModel){
  print("onUpdateSwitchStatus = "+ cellModel.name + " status = "+ cellModel.status.toString());

}

gridClicked(BuildContext context, CellModel cellModel) {
  // Grid Click
  print("gridClicked = "+ cellModel.name + " status = "+ cellModel.status.toString());
}
