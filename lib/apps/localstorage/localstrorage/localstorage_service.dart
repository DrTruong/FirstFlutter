import 'dart:convert';

import 'package:first_flutter/apps/localstorage/enum_to_string/enum_to_string.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Keys {
  key1,
}

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  read(Keys key) async {
    final data = _prefs.getString(GetStringEnum(key).value);
    if (data != null) {
      return json.decode(data);
    } else {
      return data;
    }
  }

  save(Keys key, value) async {
    _prefs.setString(GetStringEnum(key).value, json.encode(value));
  }

  remove(Keys key) async {
    _prefs.remove(GetStringEnum(key).value);
  }

  static Future<LocalStorageService> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorageService(prefs);
  }
}
