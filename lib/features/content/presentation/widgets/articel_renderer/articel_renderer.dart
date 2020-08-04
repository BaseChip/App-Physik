import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../../../../core/util/shared_prefrences/shared_prefs_rendering_engine.dart';
import '../../../../../injection_container.dart';
import 'teXdocument.dart';

class ArticelRenderer extends StatelessWidget {
  final String content;
  final String image_url = "http://srv2.thebotdev.de/img/physik/";
  ArticelRenderer({@required this.content});
  @override
  Widget build(BuildContext context) {
    List<TeXViewWidget> content_list = [];
    Map<String, dynamic> content_json = json.decode(content);
    content_json.forEach((_key, value) {
      String key = _key.toLowerCase();
      if (key.startsWith("text")) {
        content_list.add(TeXDocument.text(value));
      } else if (key.startsWith("image")) {
        content_list.add(TeXViewImage.network("$image_url$value"));
      } else if (key.startsWith("youtube")) {
        content_list.add(TeXViewVideo.youtube(value));
      }
    });
    return Expanded(
      child: TeXView(
          renderingEngine:
              sl<SharedPrefsRenderingEngine>().renderingEngineAsTeXEngine,
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
          style: TeXViewStyle(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor),
          child: TeXViewColumn(
            children: content_list,
          )),
    );
  }
}
