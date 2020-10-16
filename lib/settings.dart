// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:SwitchDemo/constants.dart';
import 'package:SwitchDemo/preference_utils.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'services.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => new _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController serverUrlController = TextEditingController();
  TextEditingController appKeyController = TextEditingController();
  String _time = "Not set";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initServerUrl();
  }

  _initServerUrl() async {
    print("_nameRetriever init ");

    String serverUrl = await PreferenceUtils.getServerUrl(
        PreferenceUtils.PREFERENCE_SERVER_URL, APPURLS.BASE_URL);
//    String appKey = await PreferenceUtils.getServerUrl(
//        PreferenceUtils.PREFERENCE_SERVER_URL, APPURLS.BASE_URL);
    if (serverUrl == "") {
      serverUrl = APPURLS.BASE_URL;
    }
    print("_nameRetriever " + serverUrl);
    serverUrlController.text = serverUrl;
    setState(() {});
  }

  void requestUpdateScheduleTime(String hour, String minute) {
    print("requestUpdateScheduleTime = " +
        hour +
        " minute = " +
        minute);
    Services.updateTimeSchedule(hour, minute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Text(
                'Server Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: serverUrlController,
                decoration: InputDecoration(hintText: 'Server'),
              ),
              Visibility(
                  visible: false,
                  child: TextFormField(
                    controller: appKeyController,
                    decoration: InputDecoration(
                        hintText: 'AppKey', labelText: APPURLS.APP_KEY),
                    obscureText: true,
                  )),
              SizedBox(
                height: 24,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RaisedButton(
                  color: Colors.white70,
                  child: Text('CANCEL'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(
                  width: 40,
                ),
                RaisedButton(
                  color: Colors.yellow,
                  child: Text('SAVE'),
                  onPressed: () {
                    //Navigator.pushReplacementNamed(context, '/catalog');
                    PreferenceUtils.saveServerUrl(
                        PreferenceUtils.PREFERENCE_SERVER_URL,
                        serverUrlController.text);
                    PreferenceUtils.saveServerUrl(
                        PreferenceUtils.PREFERENCE_APP_KEY,
                        appKeyController.text);
                    Navigator.pop(context);
                  },
                )
              ]),
              SizedBox(
                height: 100,
              ),
              Text(
                'Time Schedule Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 4.0,
                onPressed: () {
                  DatePicker.showTimePicker(context,
                      theme: DatePickerTheme(
                        containerHeight: 210.0,
                      ),
                      showSecondsColumn: false,
                      showTitleActions: true, onConfirm: (time) {
                        print('confirm $time');
                        _time = '${time.hour} : ${time.minute}';
                        requestUpdateScheduleTime(time.hour.toString(), time.minute.toString());
                        setState(() {});
                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                  setState(() {});
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.access_time,
                                  size: 18.0,
                                  color: Colors.teal,
                                ),
                                Text(
                                  " $_time",
                                  style: TextStyle(
                                      color: Colors.teal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Text(
                        "  Change",
                        style: TextStyle(
                            color: Colors.teal,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
