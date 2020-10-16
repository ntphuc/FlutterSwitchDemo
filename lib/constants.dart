import 'package:flutter/material.dart';

class APPURLS {
  static const String SAMPLE_URL =
      "https://jsonplaceholder.typicode.com/photos";

//  static const String BASE_URL =
//      "https://pp-2009210717tp.devportal.ptc.io";
//
//  static const String APP_KEY = "6eeaff10-3812-487f-a7e3-7321f2aea7b9";

  static const String PASS_ADMIN =
      "password@iot";

  static const String BASE_URL =
      "http://iot.cp.com.vn:8080";

  static const String APP_KEY = "b44b5c35-dbe0-4783-a59c-528145ff3a06";

  static const String API_LIST_THINGS =
      "https://pp-2009210717tp.devportal.ptc.io/Thingworx/Things?appKey=" +
          APP_KEY;

  static const String THINGWORX =
      "/Thingworx/Things";

  static const String API_LIST_SWITCHES = THINGWORX +
      "/OpenAPI/Services/GetSwitches";

  static const String API_UPDATE_TIME_SCHEDULE = THINGWORX +
      "/OpenAPI/Services/SetScheduleTime";


  static var API_UPDATE_SWITCH_STATUS =  "Properties/status" ;
}

class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}

class COLORS {
  // App Colors //
  static const Color DRAWER_BG_COLOR = Colors.lightBlue;
  static const Color APP_THEME_COLOR = Colors.blue;
}