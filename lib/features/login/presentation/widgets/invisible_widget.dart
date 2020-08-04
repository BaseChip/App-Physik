import 'package:flutter/material.dart';

class InvisibleWidget extends StatelessWidget {
  const InvisibleWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Opacity(
        child: Text("Nothing to see"),
        opacity: 0.0,
      ),
    );
  }
}
