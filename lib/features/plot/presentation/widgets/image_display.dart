import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final serverUrl = "http://srv2.thebotdev.de";
  final String filename;
  const ImageDisplay({Key key, @required this.filename}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
          child: Column(
        children: <Widget>[
          Image.network("$serverUrl/outputs/plot$filename"),
          //Text(filename),
        ],
      )),
    );
  }
}
