import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../../../core/util/parser/markdown_html_parser.dart';

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
                  contentColor: Colors.white,
                  backgroundColor: Colors.transparent))
        ]);
  }
}
