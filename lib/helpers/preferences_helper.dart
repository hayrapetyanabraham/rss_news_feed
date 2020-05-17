import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._();

  static const lastNewsDate = 'lastNewsDate';
  static const selectedDuration = 'selectedDuration';
}

class StorageHelper {
  static Future<SharedPreferences> get _instance =>
      SharedPreferences.getInstance();

  static Future<String> getLastNewsDate() async {
    return (await _instance).getString(Preferences.lastNewsDate);
  }

  static Future<int> getSelectedDuration() async {
    return (await _instance).getInt(Preferences.selectedDuration);
  }

  static Future<void> setLastNewsDate(String date) async {
    await (await _instance).setString(Preferences.lastNewsDate, date);
  }

  static Future<void> setSelectedDuration(int duration) async {
    await (await _instance).setInt(Preferences.selectedDuration, duration);
  }
}
