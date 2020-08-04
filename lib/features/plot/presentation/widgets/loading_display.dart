import 'package:flutter/material.dart';

class LoadingDisplay extends StatelessWidget {
  const LoadingDisplay({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height/2.5,
        child: Center(child: Column(
          children: <Widget>[
            CircularProgressIndicator(strokeWidth: 2,),
            Text("Plot wird erzeugt und geladen", style: Theme.of(context).primaryTextTheme.bodyText1,)
          ],
        )),
      ),
    );
  }
}