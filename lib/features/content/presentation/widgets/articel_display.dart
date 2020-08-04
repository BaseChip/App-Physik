import 'package:flutter/material.dart';

import 'articel_renderer/formelsammlung_renderer.dart';
import 'articel_renderer/renderer.dart';

class ArticelDisplay extends StatelessWidget {
  final String content;
  final String typ;
  ArticelDisplay({@required this.content, @required this.typ});

  @override
  Widget build(BuildContext context) {
    String t = typ.toLowerCase();
    if (t == "articel" || t == "artikel") {
      return ArticelRenderer(content: content);
    } else if (t == "formelsammlung") {
      return FormelSammlungRenderer(content: content);
    }
  }
}
