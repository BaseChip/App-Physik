import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsAuth {
  final SharedPreferences prefs;
  SharedPrefsAuth({@required this.prefs});

  String get auth_key {
    return prefs.getString("auth_key");
  }

  set auth_key(String value) {
    prefs.setString("auth_key", value);
  }

  bool get logedin {
    return prefs.getBool("loged_in") ?? false;
  }

  set logedin(bool value) {
    prefs.setBool("loged_in", value);
  }
}
