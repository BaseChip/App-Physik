import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../../../../core/util/parser/markdown_html_parser.dart';

class FormelWidget {
  static TeXViewWidget teXViewWidget(
      String title, String body, BuildContext context) {
    return TeXViewColumn(
        style: TeXViewStyle(
            margin: TeXViewMargin.all(10),
            padding: TeXViewPadding.all(10),
            //borderRadius: TeXViewBorderRadius.all(10),
            backgroundColor: Colors.transparent),
        children: [
          TeXViewDocument("<h4>$title</h4>",
              style: TeXViewStyle(
                  padding: TeXViewPadding.all(10),
                  borderRadius: TeXViewBorderRadius.all(10),
                  textAlign: TeXViewTextAlign.Center,
                  width: 250,
                  margin: TeXViewMargin.zeroAuto(),
                  backgroundColor: Theme.of(context).accentColor,
                  contentColor: Colors.white)),
          TeXViewDocument(MarkDownParser().parseString(body),
              style: TeXViewStyle(
                  margin: TeXViewMargin.only(top: 10),
                  contentColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  backgroundColor: Colors.transparent))
        ]);
  }
}
