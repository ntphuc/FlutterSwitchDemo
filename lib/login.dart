// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:SwitchDemo/constants.dart';
import 'package:flutter/material.dart';
import 'package:notification_permissions/notification_permissions.dart';

import 'home_page.dart';
import 'preference_utils.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => new _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initUser();

    registerPushNotification();

  }

  Future<void> initUser() async {

    String roleAdmin = await PreferenceUtils.getServerUrl(
        PreferenceUtils.PREFERENCE_ROLE_ADMIN, "");
    if (roleAdmin == "") {
      usernameController.text = "user";
      passwordController.text = "user";
    }else{
      usernameController.text = "admin";
      passwordController.text = APPURLS.PASS_ADMIN;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(80.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                ),
              ),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(
                height: 24,
              ),
              RaisedButton(
                color: Colors.yellow,
                child: Text('LOGIN'),
                onPressed: () {
                  if (validate(context)) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  }else{
//                    Scaffold.of(context).showSnackBar(SnackBar(
//                      content: Text("Username or password is incorrect"),
//                    ));
                    showToast();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }


  bool validate(BuildContext context) {
    if (usernameController.text == "admin" &&
        passwordController.text == APPURLS.PASS_ADMIN) {
      PreferenceUtils.saveServerUrl(
          PreferenceUtils.PREFERENCE_ROLE_ADMIN,
          "true");
      return true;
    } else if (usernameController.text == "user" &&
        passwordController.text == "user") {
      PreferenceUtils.saveServerUrl(
          PreferenceUtils.PREFERENCE_ROLE_ADMIN,
          "false");
      return true;
    }

    return false;
  }

  void showToast() {
//    Fluttertoast.showToast(
//        msg: 'Some text',
//        toastLength: Toast.LENGTH_SHORT,
//        gravity: ToastGravity.CENTER,
//        timeInSecForIosWeb: 1,
//        backgroundColor: Colors.red,
//        textColor: Colors.white
//    );
  }

  void registerPushNotification() {
    NotificationPermissions
        .requestNotificationPermissions(
        iosSettings:
        const NotificationSettingsIos(
            sound: true,
            badge: true,
            alert: true));

  }




}