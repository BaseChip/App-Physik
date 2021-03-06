import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../../../../core/util/shared_prefrences/shared_prefs_rendering_engine.dart';
import '../../../../../injection_container.dart';
import 'formelwidget.dart';

class FormelSammlungRenderer extends StatelessWidget {
  final String content;
  FormelSammlungRenderer({@required this.content});
  @override
  Widget build(BuildContext context) {
    List<TeXViewWidget> contentList = [];
    Map<String, dynamic> contentJson = json.decode(content);
    contentJson.forEach((key, value) {
      contentList.add(FormelWidget.teXViewWidget(key, value, context));
    });
    return Expanded(
      child: TeXView(
          loadingWidgetBuilder: (context) => Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Rendering...",
                        style: Theme.of(context).primaryTextTheme.bodyText1)
                  ],
                ),
              ),
          renderingEngine:
              sl<SharedPrefsRenderingEngine>().renderingEngineAsTeXEngine,
          style: TeXViewStyle(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          child: TeXViewColumn(
            children: contentList,
          )),
    );
  }
}
