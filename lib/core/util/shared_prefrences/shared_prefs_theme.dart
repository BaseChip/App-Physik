import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../ui/theme/app_themes.dart';
import '../../ui/theme/bloc/theme_bloc.dart';

class SharedPrefsTheme{
  final SharedPreferences prefs;
  SharedPrefsTheme({
    @required this.prefs
  });

  /// Lädt aus den SharedPrefrences die nummer des zu letzt verwendeten AppThemes und sucht den zugehörigen Enum und
  /// wandelt dies dann in ein ThemeState um, so das es direkt verwendet werden kann
  ThemeState get lastTheme{
    return ThemeState(themeData: appThemeData[AppTheme.values[prefs.getInt("theme") ?? 0]]);
  }

  /// Speichert das übergebene AppTheme als int in den SharedPreferences
  void saveTheme(AppTheme theme){
    prefs.setInt("theme", theme.index);
  }
}