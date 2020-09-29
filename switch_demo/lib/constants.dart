import 'package:flutter/material.dart';

class APPURLS {
  static const String SAMPLE_URL =
      "https://jsonplaceholder.typicode.com/photos";

  static const String BASE_URL =
      "https://pp-2009210717tp.devportal.ptc.io/Thingworx/Things/";

  static const String APP_KEY = "6eeaff10-3812-487f-a7e3-7321f2aea7b9";

  static const String API_LIST_THINGS =
      "https://pp-2009210717tp.devportal.ptc.io/Thingworx/Things?appKey=" +
          APP_KEY;

  static const String API_LIST_SWITCHES = BASE_URL +
      "OpenAPI/Services/GetSwitches";

  static var API_UPDATE_SWITCH_STATUS =  "/Properties/status" ;
}

class MESSAGES {
  static const String INTERNET_ERROR = "No Internet Connection";
  static const String INTERNET_ERROR_RETRY =
      "No Internet Connection.\nPlease Retry";
}

class COLORS {
  // App Colors //
  static const Color DRAWER_BG_COLOR = Colors.lightGreen;
  static const Color APP_THEME_COLOR = Colors.green;
}