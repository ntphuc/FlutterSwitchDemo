import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'preference_utils.dart';
import 'cell_model.dart';
import 'constants.dart';
import 'list_things_model.dart';
import 'switches_model.dart';

class Services {
  static Future<List<CellModel>> fetchHomeData() async {
    final response = await http.get(APPURLS.SAMPLE_URL);
    try {
      if (response.statusCode == 200) {
        List<CellModel> list = parsePostsForHome(response.body);
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static List<CellModel> parsePostsForHome(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<CellModel>((json) => CellModel.fromJson(json)).toList();
  }

  static Future<ListThingsModel> fetchListThings() async {
    final response = await http.get(APPURLS.API_LIST_THINGS, headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    });
    try {
      if (response.statusCode == 200) {
        ListThingsModel list =
            ListThingsModel.fromJson(json.decode(response.body));
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static ListThingsModel parseListThingsModel(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ListThingsModel>((json) => ListThingsModel.fromJson(json))
        .toList();
  }

  static Future<SwitchesModel> fetchSwitchesOld() async {
    PreferenceUtils.getServerUrl(
            PreferenceUtils.PREFERENCE_SERVER_URL, APPURLS.BASE_URL)
        .then((serverUrl) async {
      print(serverUrl + APPURLS.API_LIST_SWITCHES);
      final response = await http.post(
        serverUrl + APPURLS.API_LIST_SWITCHES,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'appKey': APPURLS.APP_KEY
        },
        body: jsonEncode(<String, int>{
          'deviceId': 1,
        }),
      );
      try {
        if (response.statusCode == 200) {
          SwitchesModel list =
              SwitchesModel.fromJson(json.decode(response.body));
          return list;
        } else {
          throw Exception(MESSAGES.INTERNET_ERROR);
        }
      } catch (e) {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    });
  }

  static Future<SwitchesModel> fetchSwitches() async {
    String serverUrl = await PreferenceUtils.getServerUrl(
        PreferenceUtils.PREFERENCE_SERVER_URL, APPURLS.BASE_URL);

    print(serverUrl + APPURLS.API_LIST_SWITCHES);
    final response = await http.post(
      serverUrl + APPURLS.API_LIST_SWITCHES,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'appKey': APPURLS.APP_KEY
      },
      body: jsonEncode(<String, int>{
        'deviceId': 1,
      }),
    );
    try {
      if (response.statusCode == 200) {
        SwitchesModel list = SwitchesModel.fromJson(json.decode(response.body));
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static Future<bool> updateSwitchStatus(CellModel cellModel) async {
    String serverUrl = await PreferenceUtils.getServerUrl(
        PreferenceUtils.PREFERENCE_SERVER_URL, APPURLS.BASE_URL);
    String url = serverUrl +
        APPURLS.THINGWORX +"/"+
        cellModel.name + "/"+
        APPURLS.API_UPDATE_SWITCH_STATUS;
    print(url);
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'appKey': APPURLS.APP_KEY
      },
      body: jsonEncode(<String, bool>{
        'status': cellModel.status,
      }),
    );
    try {
      if (response.statusCode == 200) {
        // SwitchesModel list = SwitchesModel.fromJson(json.decode(response.body));
        return true;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

  static Future<bool> updateTimeSchedule(String hour, String minute) async {
    String serverUrl = await PreferenceUtils.getServerUrl(
        PreferenceUtils.PREFERENCE_SERVER_URL, APPURLS.BASE_URL);
    String url = serverUrl +
        APPURLS.API_UPDATE_TIME_SCHEDULE;
    print(url);
    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'appKey': APPURLS.APP_KEY
      },
      body: jsonEncode(<String, String>{
        'hour': hour, 'minute':minute
      }),
    );
    try {
      if (response.statusCode == 200) {
        // SwitchesModel list = SwitchesModel.fromJson(json.decode(response.body));
        return true;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }
}
