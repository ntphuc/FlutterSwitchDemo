import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:switch_demo/list_things_model.dart';
import 'cell_model.dart';
import 'constants.dart';
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
    final response = await http.get(APPURLS.API_LIST_THINGS,headers: { 'Accept': 'application/json','Content-Type': 'application/json'});
    try {
      if (response.statusCode == 200) {
        ListThingsModel list = ListThingsModel.fromJson(json.decode(response.body));
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
    return parsed.map<ListThingsModel>((json) => ListThingsModel.fromJson(json)).toList();
  }

  static Future<SwitchesModel> fetchSwitches() async {
    final response = await http.post(APPURLS.API_LIST_SWITCHES,
        headers: { 'Accept': 'application/json',
          'Content-Type': 'application/json', 'appKey': APPURLS.APP_KEY},
        body: jsonEncode(<String, int>{
          'deviceId': 1,
        }),);
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

}