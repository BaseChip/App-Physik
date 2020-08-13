import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsCDots {
  final SharedPreferences prefs;
  SharedPrefsCDots({@required this.prefs});

  /// Liefert zurück, ob CDots ausgewählt sind, falls nichts gespeichert ist
  /// wird false zurück gegeben
  bool get cDotsSetting {
    return prefs.getBool("cdots_enabled") ?? false;
  }

  set cDotsSetting(bool setting) {
    prefs.setBool("cdots_enabled", setting);
  }
}
