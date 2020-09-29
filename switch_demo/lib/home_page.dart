import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'cell_model.dart';
import 'common_comp.dart';
import 'constants.dart';
import 'services.dart';
import 'switches_model.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    final dynamic notification = message['notification'];
  }

}

final Map<String, Item> _items = <String, Item>{};
Item _itemForMessage(Map<String, dynamic> message) {
  final dynamic data = message['data'] ?? message;
  final String itemId = data['id'];
  final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
    .._matchteam = data['name']
    .._score = data['status'];
  return item;
}

class Item {
  Item({this.itemId});
  final String itemId;

  StreamController<Item> _controller = StreamController<Item>.broadcast();
  Stream<Item> get onChanged => _controller.stream;

  String _matchteam;
  String get matchteam => _matchteam;
  set matchteam(String value) {
    _matchteam = value;
    _controller.add(this);
  }

  String _score;
  String get score => _score;
  set score(String value) {
    _score = value;
    _controller.add(this);
  }

//  static final Map<String, Route<void>> routes = <String, Route<void>>{};
//  Route<void> get route {
//    final String routeName = '/detail/$itemId';
//    return routes.putIfAbsent(
//      routeName,
//          () => MaterialPageRoute<void>(
//        settings: RouteSettings(name: routeName),
//        builder: (BuildContext context) => DetailPage(itemId),
//      ),
//    );
//  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isHomeDataLoading;

  var timer;

  Duration TIME_DELAY_UPDATE = Duration(seconds: 5);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  @override
  void initState() {
    super.initState();
    registerPushNotification();
    isHomeDataLoading = true;
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
    Services.updateSwitchStatus(cellModel);
    fetchWithoutLoading();
  }

  void runTimeDelay() {
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

  void registerPushNotification() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("matchscore");
  }


  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("${item.matchteam} with score: ${item.score}"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        //_navigateToItemDetail(message);
      }
    });
  }

}

gridClicked(BuildContext context, CellModel cellModel) {
  // Grid Click
  print("gridClicked = " +
      cellModel.name +
      " status = " +
      cellModel.status.toString());
}
