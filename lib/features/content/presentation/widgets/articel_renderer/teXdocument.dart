import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../../../../core/util/parser/markdown_html_parser.dart';
import '../../../../../core/util/shared_prefrences/shared_prefs_theme.dart';
import '../../../../../injection_container.dart';

class TeXDocument {
  TeXDocument();
  static TeXViewWidget text(String body) {
    return TeXViewColumn(
        style: TeXViewStyle(
            margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
            backgroundColor: Colors.transparent),
        children: [
          TeXViewDocument(MarkDownParser().parseString(body),
              style: TeXViewStyle(
                  margin: TeXViewMargin.only(top: 10),
                  contentColor: sl<SharedPrefsTheme>()
                      .lastTheme
                      .themeData
                      .primaryTextTheme
                      .bodyText1
                      .color,
                  backgroundColor: Colors.transparent))
        ]);
  }
}
