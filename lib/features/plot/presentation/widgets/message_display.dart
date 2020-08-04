import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  const MessageDisplay({
    Key key,
    @required this.message
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height/2.5,
      child: Center(child: SingleChildScrollView(child: Text(message, style: Theme.of(context).primaryTextTheme.headline5, textAlign: TextAlign.center,))),
    );
  }
}