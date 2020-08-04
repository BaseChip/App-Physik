import 'package:flutter/material.dart';

class ImageDisplay extends StatelessWidget {
  final server_url = "http://srv2.thebotdev.de";
  final String filename;
  const ImageDisplay({
    Key key,
    @required this.filename
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(child: Column(
        children: <Widget>[
          Image.network("$server_url/outputs/plot$filename"),
          //Text(filename),
        ],
      )),
    );
  }
}