import 'package:flutter/material.dart';

class ContentErrorDisplay extends StatelessWidget{
  final String error;
  ContentErrorDisplay({@required this.error});

  @override
  Widget build(BuildContext context) {
        return Container(
      height: MediaQuery.of(context).size.height/2.5,
      child: Center(child: SingleChildScrollView(child: Text(error, style: Theme.of(context).primaryTextTheme.headline5, textAlign: TextAlign.center,))),
    );
  }

}