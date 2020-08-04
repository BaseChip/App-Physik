import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../injection_container.dart';
import '../../../util/shared_prefrences/shared_prefs_theme.dart';
import '../app_themes.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  //ThemeState get initialState => ThemeState(themeData: appThemeData[AppTheme.Dark]);
  ThemeState get initialState => sl<SharedPrefsTheme>().lastTheme;

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if(event is ThemeChanged){
      sl<SharedPrefsTheme>().saveTheme(event.theme);
      yield ThemeState(themeData: appThemeData[event.theme]);
    }
  }
}
