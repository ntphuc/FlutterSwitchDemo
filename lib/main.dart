import 'package:SwitchDemo/login.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'preference_utils.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyMainState createState() => new _MyMainState();
}

class _MyMainState  extends State<MyApp> {
  bool isLoginAlready = false;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRole();
  }


  Future<void> getRole() async {
    String roleAdmin = await PreferenceUtils.getServerUrl(
        PreferenceUtils.PREFERENCE_ROLE_ADMIN, "");


    isLoginAlready =  roleAdmin != "";
    print( "main roleAdmin = " + roleAdmin + " isLoginAlready = " +isLoginAlready.toString());
    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: isLoginAlready? '/home': "/",
      routes: {
        '/': (context) => MyLogin(),
        '/home': (context) => MyHomePage(),
      },
     // home: isLoginAlready ? MyHomePage(): MyLogin() ,
    );
  }
}

