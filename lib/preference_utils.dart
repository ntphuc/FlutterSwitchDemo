
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceUtils {
  static const String PREFERENCE_SERVER_URL = "PREFERENCE_SERVER_URL";

  static const String PREFERENCE_APP_KEY = "PREFERENCE_APP_KEY";

  static const String PREFERENCE_ROLE_ADMIN = "PREFERENCE_ROLE_ADMIN";


  static Future<void> saveServerUrl(String key, String value) async {
// obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
// set value
    prefs.setString(key, value);
  }

  static Future<String> getServerUrl(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();

// Try reading data from the counter key. If it doesn't exist, return 0.
    if (prefs.containsKey(key))
      return prefs.getString(key) ;
    else
      return value;
  }
}
