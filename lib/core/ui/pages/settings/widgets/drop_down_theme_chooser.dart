import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../theme/app_themes.dart';
import '../../../theme/bloc/theme_bloc.dart';

DropdownButton dropDownTheme(BuildContext context) {
  return new DropdownButton<AppTheme>(
    items: AppTheme.values.map((AppTheme appTheme) {
      return DropdownMenuItem<AppTheme>(value: appTheme, child: Text(_mapEnumThemeToString(appTheme)));
    }).toList(),
    dropdownColor: Theme.of(context).accentColor,
    style: TextStyle(color: Theme.of(context).primaryTextTheme.bodyText1.color),
    onChanged: (value) {
      BlocProvider.of<ThemeBloc>(context).add(ThemeChanged(theme: value));
    },
    underline: Container(
      color: Colors.transparent
    ),
  );
}
/// Wandelt den gegebenen Enum vom Typ AppTheme in einen String um
/// 
/// Ein Enum vom Typ AppTheme würde eigtl. z. B. AppTheme.Dark heißen, allerdings möchten wir in der Ausgabe nur Dark stehen haben,
/// weshalb erst der Enum in einen String umgewandelt wird und dann das AppTheme. durch einen leeren String ersetzt wird
/// Zudem werden alle Unterstriche durch ein Leerzeichen ersetzt
String _mapEnumThemeToString(AppTheme appTheme){
  return appTheme.toString().replaceFirst("AppTheme.", "").replaceAll("_", " ");
  }