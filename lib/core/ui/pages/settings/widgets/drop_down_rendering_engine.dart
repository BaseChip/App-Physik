import 'package:flutter/material.dart';

import '../../../../../injection_container.dart';
import '../../../../util/shared_prefrences/shared_prefs_rendering_engine.dart';

/// Dieses DropDownMenü ist als StatefulWidget geschrieben, damit sich das value immer auf den gleichen Wert setzt
/// wie die gerade ausgewählte Rendering Engine.
/// Würde dies kein StatefulWidget sein müsste die seite jedes mal vom Benutzer neu geladen werden, damit die Änderungen sichtbar werden.
class DropDownRenderingEngine extends StatefulWidget {
  DropDownRenderingEngine({Key key}) : super(key: key);

  @override
  _DropDownRenderingEngineState createState() =>
      _DropDownRenderingEngineState();
}

class _DropDownRenderingEngineState extends State<DropDownRenderingEngine> {
  @override
  Widget build(BuildContext context) {
    String _engine = sl<SharedPrefsRenderingEngine>().renderingEngine;
    return DropdownButton<String>(
      items: <String>["Katex", "MathJax"].map((String value) {
        return new DropdownMenuItem<String>(
          value: value,
          child: new Text(value),
        );
      }).toList(),
      value: _engine,
      dropdownColor: Theme.of(context).accentColor,
      style:
          TextStyle(color: Theme.of(context).primaryTextTheme.bodyText1.color),
      onChanged: (value) {
        sl<SharedPrefsRenderingEngine>().renderingEngine = value;
        setState(() {
          _engine = sl<SharedPrefsRenderingEngine>().renderingEngine;
        });
      },
      underline: Container(color: Colors.transparent),
    );
  }
}
