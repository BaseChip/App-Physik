import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsSlider {
  final SharedPreferences prefs;
  SharedPrefsSlider({@required this.prefs});

  /// liest aus, ob der Nutzer das Intro schonmal hatte, falls nichts
  /// gespeichert ist wird false returned
  bool get introGot {
    return prefs.getBool("introGot") ?? false;
  }

  set introGot(bool got) {
    prefs.setBool("introGot", got);
  }
}
